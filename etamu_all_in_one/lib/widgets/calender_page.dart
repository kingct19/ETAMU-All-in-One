import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:etamu_all_in_one/services/calendar_service.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<CalendarEvent>> _events = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCalendarData();
  }

  Future<void> _loadCalendarData() async {
    try {
      final events = await CalendarService().fetchEvents();

      final Map<DateTime, List<CalendarEvent>> grouped = {};
      for (final event in events) {
        final day = DateTime(event.start.year, event.start.month, event.start.day);
        grouped.putIfAbsent(day, () => []).add(event);
      }

      setState(() {
        _events = grouped;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load calendar: $e')),
        );
      }
    }
  }

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);
    return _events[normalized] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF002147);
    const gold = Color(0xFFFFD700);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: navy,
        title: const Text("Academic Calendar"),
        titleTextStyle: TextStyle(
          fontFamily: 'BreeSerif',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: gold,
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  eventLoader: _getEventsForDay,
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(color: Color(0xFFFFD700), shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(color: Color(0xFF08335B), shape: BoxShape.circle),
                    weekendTextStyle: TextStyle(color: Colors.redAccent),
                    defaultTextStyle: TextStyle(color: Colors.black87),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontFamily: 'BreeSerif',
                      fontSize: 18,
                    ),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                ),
                const SizedBox(height: 12),
                if (_selectedDay != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Events on ${_selectedDay!.toLocal().toString().split(' ')[0]}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'BreeSerif',
                          ),
                        ),
                        const SizedBox(height: 8),
                        ..._getEventsForDay(_selectedDay!).map((e) => Card(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                leading: const Icon(Icons.event, color: navy),
                                title: Text(e.summary),
                                subtitle: Text(
                                  "${_formatTime(e.start)} → ${_formatTime(e.end)}",
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} ${time.month}/${time.day}/${time.year}";
  }
}
