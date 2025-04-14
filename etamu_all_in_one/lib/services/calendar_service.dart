import 'package:http/http.dart' as http;
import 'package:icalendar_parser/icalendar_parser.dart';

class CalendarEvent {
  final String summary;
  final DateTime start;
  final DateTime end;

  CalendarEvent({
    required this.summary,
    required this.start,
    required this.end,
  });
}

class CalendarService {
  static const String icsUrl = 'https://calendar.tamuc.edu/academic/calendar/1.ics';

  Future<List<CalendarEvent>> fetchEvents() async {
    final response = await http.get(Uri.parse(icsUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to load calendar data');
    }

    final ical = ICalendar.fromString(response.body);
    final rawEvents = ical.data.where((e) => e['type'] == 'VEVENT');

    return rawEvents.map((e) {
      final data = e['data'];
      if (data == null) return null;

      final summary = data['SUMMARY'] ?? 'No Title';
      final start = DateTime.tryParse(data['DTSTART'] ?? '');
      final end = DateTime.tryParse(data['DTEND'] ?? '');

      if (start == null || end == null) return null;

      return CalendarEvent(
        summary: summary,
        start: start,
        end: end,
      );
    }).whereType<CalendarEvent>().toList();
  }
}
