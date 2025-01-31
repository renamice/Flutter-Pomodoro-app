import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class Countdown extends StatefulWidget {
  const Countdown({super.key, required this.minutes});

  final int minutes;

  @override
  State<Countdown> createState() => _CountState();
}

class _CountState extends State<Countdown> {
  late int minutes;
  late int seconds = 30;
  Timer? timer;
  String prefix = "";
  // mode: start, running, paused, extra
  String mode = "start";

  @override
  void initState() {
    super.initState();
    minutes = widget.minutes;
  }

  void _countUp() {
    prefix = "+";
    setState(() {
      mode = "extra";
    });

    timer = Timer.periodic(Duration(milliseconds: 50), (_) {
      if (seconds == 60) {
        setState(() {
          seconds = 0;
          minutes++;
        });
      }
      setState(() {
        seconds++;
      });
    });
  }

  void _countdown() {
    mode = "running";
    timer = Timer.periodic(Duration(milliseconds: 50), (_) {
      if (seconds == 0) {
        minutes--;
        seconds = 60;
      }
      setState(() {
        seconds--;
      });
      if (minutes == 0 && seconds == 0) {
        timer!.cancel();
        _countUp();
        return;
      }
    });
  }

  void _stopTimer() {
    setState(() {
      mode = "paused";
    });
    timer?.cancel();
  }

  void _reset() {
    setState(() {
      _stopTimer();
      mode = "start";
      minutes = widget.minutes;
      seconds = 0;
      prefix = "";
    });
  }

  Widget _buttons() {
    if (mode == "start") {
      return IconButton(
        onPressed: () {
          _countdown();
        },
        icon: Icon(Icons.play_circle),
      );
    }

    if (mode == "running") {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              _stopTimer();
            },
            icon: Icon(Icons.pause),
          ),
          IconButton(
            onPressed: () {
              _reset();
            },
            icon: Icon(Icons.close),
          ),
        ],
      );
    }

    if (mode == "paused") {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              _countdown();
            },
            icon: Icon(Icons.play_circle),
          ),
          IconButton(
            onPressed: () {
              _reset();
            },
            icon: Icon(Icons.close),
          ),
        ],
      );
    }

    return IconButton(
      onPressed: () {
        _stopTimer();
        _save();
      },
      icon: Icon(Icons.pause),
    );
  }

  void _save() {}

  // Int -> String
  // Adds a '0' to the front if number is only one digit
  String _twoDigits(int number) => (number > 9) ? "$number" : "0$number";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$prefix${_twoDigits(minutes)}:${_twoDigits(seconds)}",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 75),
        ),
        _buttons(),
      ],
    );
  }
}
