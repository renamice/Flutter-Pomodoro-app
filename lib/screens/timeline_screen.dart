import 'package:flutter/material.dart';
import 'package:pomodoro/interface/data_handler.dart';
import 'package:pomodoro/models/time_stamps.dart';
import 'package:pomodoro/models/user.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimelineScreen> {
  late List sessions;
  late DateTime now = DateTime.now();
  late int day = now.day;
  late int month = now.month;
  late int year = now.year;
  List specificSessions = [];

  @override
  void initState() {
    super.initState();
    sessions = getUserSessions();
  }

  Widget _listBody(int index) {
    _getSessionsForDate(year: year, month: month, day: day);

    if (specificSessions.isEmpty) {
      return SizedBox();
    }

    String mode = specificSessions[index]["mode"];
    int hour = specificSessions[index]["date"][DateMeasures.hour.toString()];
    int minutes =
        specificSessions[index]["date"][DateMeasures.minute.toString()];
    int total = specificSessions[index]["duration"];
    return mode == "rest"
        ? ListTile(
          tileColor: Color.fromARGB(255, 184, 187, 38),
          leading: Text(
            mode,
            style: TextStyle(color: Color.fromARGB(255, 60, 56, 54)),
          ),
          title: Text(
            "$hour:$minutes",
            style: TextStyle(color: Color.fromARGB(255, 251, 241, 199)),
          ),
          trailing: Text(
            "$total minutes",
            style: TextStyle(color: Color.fromARGB(255, 60, 56, 54)),
          ),
        )
        : ListTile(
          tileColor: Color.fromARGB(255, 69, 133, 136),
          leading: Text(
            mode,
            style: TextStyle(color: Color.fromARGB(255, 29, 32, 33)),
          ),
          title: Text(
            "$hour:$minutes",
            style: TextStyle(color: Color.fromARGB(255, 235, 219, 178)),
          ),
          trailing: Text(
            "$total minutes",
            style: TextStyle(color: Color.fromARGB(255, 60, 56, 54)),
          ),
        );
  }

  void _changeDay(int changeBy) {
    // full implementation remaining
    // does not account for month change as of now.
    // someday in the future...
    setState(() {
      day += changeBy;
    });
  }

  void _getSessionsForDate({required year, required month, required day}) {
    specificSessions = [];
    for (final session in sessions) {
      int sessionYear = session["date"][DateMeasures.year.toString()];
      int sessionMonth = session["date"][DateMeasures.month.toString()];
      int sessionDay = session["date"][DateMeasures.day.toString()];

      if (sessionYear == year && sessionMonth == month && sessionDay == day) {
        specificSessions.add(session);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return sessions.isEmpty
        ? Scaffold(
          appBar: AppBar(),
          body: Center(child: Text("You have no sessions yet.")),
        )
        : Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SizedBox(
              width: 600,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    // date
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //IconButton(
                          //  onPressed: () {
                          //    _changeDay(-1);
                          //  },
                          //  icon: Icon(Icons.arrow_left),
                          //),
                          Text("$year/$month/$day"),
                          //IconButton(
                          //  onPressed: () {
                          //    _changeDay(1);
                          //  },
                          //  icon: Icon(Icons.arrow_right),
                          //),
                        ],
                      ),
                    ),
                    // graph
                    Expanded(
                      child: ListView.builder(
                        itemCount: sessions.length,
                        itemBuilder: (context, index) {
                          return _listBody(index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}
