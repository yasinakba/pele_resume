import 'package:flutter/material.dart';
import 'package:jalali_flutter_datepicker/jalali_flutter_datepicker.dart';
import 'package:jalali_table_calendar_plus/Utils/holy_day.dart';
import 'package:jalali_table_calendar_plus/Utils/options.dart';
import 'package:jalali_table_calendar_plus/Widget/table_calendar.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return buildCalendar(context);
  }
}
Widget buildCalendar(BuildContext context) {
  DateTime today = DateTime.now();
  Map <DateTime, List<dynamic>>events = {
    today: ['sample event', 26],
    today.add(const Duration(days: 1)): ['all types can use here', {"key": "value"}],
  };
  return JalaliTableCalendar(
    events: events,
    range: false,
    option: JalaliTableCalendarOption(
      daysOfWeekTitles: [
        "شنبه",
        "یکشنبه",
        "دوشنبه",
        "سه شنبه",
        "چهارشنبه",
        "پنجشنبه",
        "جمعه"
      ],
    ),
    customHolyDays: [
      // use jalali month and day for this
      HolyDay(month: 4, day: 10), // For Repeated Days
      HolyDay(year: 1404, month: 1, day: 26), // For Only One Day
    ],
    onRangeSelected: (selectedDates) {
      for (DateTime date in selectedDates) {
        print('date');
      }
    },
    marker: (date, event) {
      if (event.isNotEmpty) {
        return Positioned(
            top: -2,
            left: 1,
            child: GestureDetector(
              onTap: () {
                print('object');
              },
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blue),
                  child: Text(event.length.toString())),
            ));
      }
      return null;
    },
    onDaySelected: (DateTime date) {
      print('${date.toJalali()}');
    },
  );
}