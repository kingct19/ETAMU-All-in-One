import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  static Future<Map<DateTime, List<String>>> getUpcomingEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final eventsString = prefs.getString('calendar_events');

    if (eventsString == null) return {};

    final decoded = jsonDecode(eventsString) as Map<String, dynamic>;
    final parsedEvents = decoded.map((key, value) {
      final date = DateTime.parse(key);
      final list = List<String>.from(value);
      return MapEntry(date, list);
    });

    final now = DateTime.now();
    final upcoming =
        parsedEvents.entries.where((entry) => entry.key.isAfter(now)).toList()
          ..sort((a, b) => a.key.compareTo(b.key));

    if (upcoming.isNotEmpty) {
      return {upcoming.first.key: upcoming.first.value};
    }
    return {};
  }

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};

  static Map<DateTime, List<String>> savedEvents = {};

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _loadEvents();
  }

  Future<void> _initializeNotifications() async {
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(initSettings);

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> _loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final eventsString = prefs.getString('calendar_events');
    if (eventsString != null) {
      final decoded = jsonDecode(eventsString) as Map<String, dynamic>;
      _events = decoded.map((key, value) {
        final date = DateTime.parse(key);
        final list = List<String>.from(value);
        return MapEntry(date, list);
      });
      savedEvents = Map.from(_events);
      setState(() {});
    }
  }

  Future<void> _saveEvents() async {
    savedEvents = Map.from(_events);
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      _events.map((key, value) => MapEntry(key.toIso8601String(), value)),
    );
    await prefs.setString('calendar_events', encoded);
    await _loadEvents();
  }

  void _showAddEventDialog() {
    final titleController = TextEditingController();
    TimeOfDay selectedTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add Event'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Event Title'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (picked != null) selectedTime = picked;
                  },
                  child: const Text('Pick Reminder Time'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final title = titleController.text.trim();
                  if (title.isEmpty || _selectedDay == null) return;

                  setState(() {
                    _events[_selectedDay!] = [...?_events[_selectedDay], title];
                  });
                  await _saveEvents();

                  final reminderTime = DateTime(
                    _selectedDay!.year,
                    _selectedDay!.month,
                    _selectedDay!.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );

                  await _notificationsPlugin.zonedSchedule(
                    reminderTime.millisecondsSinceEpoch ~/ 1000,
                    'Event Reminder',
                    title,
                    tz.TZDateTime.from(reminderTime, tz.local),
                    const NotificationDetails(
                      android: AndroidNotificationDetails(
                        'reminders',
                        'Reminders',
                        channelDescription:
                            'Reminder notifications for calendar events',
                      ),
                    ),
                    matchDateTimeComponents: DateTimeComponents.time,
                    androidScheduleMode:
                        AndroidScheduleMode.exactAllowWhileIdle,
                  );

                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  List<String> _getEventsForDay(DateTime day) => _events[day] ?? [];

  void _deleteEvent(int index) async {
    if (_selectedDay != null && _events[_selectedDay!] != null) {
      setState(() {
        _events[_selectedDay!]!.removeAt(index);
        if (_events[_selectedDay!]!.isEmpty) {
          _events.remove(_selectedDay!);
        }
      });
      await _saveEvents();
    }
  }

  Future<void> _refreshEvents() async {
    await _loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar'), leading: Container()),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshEvents,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                eventLoader: _getEventsForDay,
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                ),
              ),
              const SizedBox(height: 10),
              if (_selectedDay != null &&
                  _getEventsForDay(_selectedDay!).isNotEmpty)
                ..._getEventsForDay(_selectedDay!).asMap().entries.map(
                  (entry) => ListTile(
                    title: Text(entry.value),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        _deleteEvent(entry.key);
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
