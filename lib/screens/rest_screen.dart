import 'package:flutter/material.dart';
import 'package:pomodoro/interface/data_handler.dart';
import 'package:pomodoro/models/user.dart';
import 'package:pomodoro/widgets/coutdown.dart';
import 'package:pomodoro/widgets/buttons.dart';

class RestScreen extends StatefulWidget {
  const RestScreen({super.key, required this.toWork});

  final void Function() toWork;

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  late Map settings;

  @override
  void initState() {
    super.initState();
    settings = getUserSettings();
  }

  late var background = settings[Settings.rest_background.toString()];
  late var foreground = settings[Settings.rest_foreground.toString()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Spacer(),

          IconButton(onPressed: widget.toWork, icon: Icon(Icons.replay)),

          Container(width: 20),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              Container(
                height: 20,
                child: Text("Rest", style: TextStyle(fontSize: 18)),
              ),
              // todo: get rest time from backend
              Countdown(minutes: 5, color: foreground),
              SizedBox(height: 20),
              Spacer(),
              ButtonMore(color: foreground),
            ],
          ),
        ),
      ),
    );
  }
}
