import 'package:http/http.dart' as http;
import 'package:icalendar_parser/icalendar_parser.dart';

class CalendarEvent {
  final String summary;
  final DateTime start;
  final DateTime end;

  CalendarEvent({required this.summary, required this.start, required this.end});
}

class CalendarService {
  static const String icsUrl = 'https://calendar.tamuc.edu/academic/calendar/1.ics';

  Future<List<CalendarEvent>> fetchEvents() async {
    final response = await http.get(Uri.parse(icsUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to load calendar data');
    }

    final ical = ICalendar.fromString(response.body);
    final events = ical.data.where((e) => e['type'] == 'VEVENT');

    return events.map((e) {
      return CalendarEvent(
        summary: e['data']['SUMMARY'] ?? 'No Title',
        start: DateTime.parse(e['data']['DTSTART']),
        end: DateTime.parse(e['data']['DTEND']),
      );
    }).toList();
  }
}
