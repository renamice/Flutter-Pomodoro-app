import 'package:flutter/material.dart';
import 'package:pomodoro/interface/data_handler.dart';
import 'package:pomodoro/interface/hexcolor.dart';
import 'package:pomodoro/models/user.dart';
import 'package:pomodoro/widgets/coutdown.dart';
import 'package:pomodoro/widgets/buttons.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key, required this.toRest});

  final void Function() toRest;

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late Map settings;

  @override
  void initState() {
    super.initState();
    settings = getUserSettings();
  }

  late var background = settings[Settings.work_background.toString()];
  late var foreground = settings[Settings.work_foreground.toString()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex(background),
      appBar: AppBar(
        backgroundColor: HexColor.fromHex(background),
        actions: [
          Spacer(),
          IconButton(
            onPressed: widget.toRest,
            icon: Icon(Icons.arrow_right_alt),
            color: HexColor.fromHex(foreground),
          ),
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
              // todo: get work time from backend
              Countdown(minutes: 25, color: foreground),
              Spacer(),
              ButtonMore(color: foreground),
            ],
          ),
        ),
      ),
    );
  }
}
