import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'event_details_page.dart';
import 'main_navigation_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Using a deep green color scheme for the application with pink text
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green[800] ?? Colors.green),
        scaffoldBackgroundColor: Color(0xFF004D40), // Deep green background for all scaffolds
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.pink),
          bodyMedium: TextStyle(color: Colors.pink),
          titleMedium: TextStyle(color: Colors.pink),
          titleLarge: TextStyle(color: Colors.pink),
          displaySmall: TextStyle(color: Colors.pink),
          displayMedium: TextStyle(color: Colors.pink),
          displayLarge: TextStyle(color: Colors.pink),
        ),
      ),
      home: const MainNavigationPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  void _addEvent() {
    if (_selectedDay == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a day first')),
      );
      return;
    }
    
    // Navigate to the event details page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetailsPage(selectedDate: _selectedDay!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00695C), // Slightly lighter deep green for contrast
        foregroundColor: Colors.white, // White text
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              calendarStyle: const CalendarStyle(
                todayTextStyle: TextStyle(color: Colors.pink),
                defaultTextStyle: TextStyle(color: Colors.pink),
                weekendTextStyle: TextStyle(color: Colors.pinkAccent),
                selectedTextStyle: TextStyle(color: Colors.white),
                selectedDecoration: BoxDecoration(
                  color: Colors.pink,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(color: Colors.pink, fontSize: 18.0),
                formatButtonTextStyle: TextStyle(color: Colors.pink),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.pink),
                weekendStyle: TextStyle(color: Colors.pinkAccent),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 20),
            if (_selectedDay != null) 
              Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Date: ${DateFormat.yMMMMd().format(_selectedDay!)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.pink,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Events for this day will appear here',
                        style: TextStyle(color: Colors.pink[200]),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        tooltip: 'Add Event',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
