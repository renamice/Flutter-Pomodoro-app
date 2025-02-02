import 'package:flutter/material.dart';
import 'package:pomodoro/screens/rest_screen.dart';
import 'package:pomodoro/screens/work_screen.dart';

class ScreenHandler extends StatefulWidget {
  const ScreenHandler({super.key});

  @override
  State<ScreenHandler> createState() => _ScreenHandlerState();
}

class _ScreenHandlerState extends State<ScreenHandler> {
  // routes
  String work = "/work";
  String rest = "/rest";

  String current = "/work";

  void toWork() => setState(() {
    current = work;
  });
  void toRest() => setState(() {
    current = rest;
  });

  @override
  Widget build(BuildContext context) {
    if (current == rest) {
      return RestScreen(toWork: toWork);
    }
    return TimerScreen(toRest: toRest);
  }
}
