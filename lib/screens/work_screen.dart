import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/coutdown.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key, required this.toRest});

  final void Function() toRest;

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Spacer(),
          IconButton(
            onPressed: widget.toRest,
            icon: Icon(Icons.arrow_right_alt),
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
              Countdown(minutes: 25),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.downloading)),
            ],
          ),
        ),
      ),
    );
  }
}
