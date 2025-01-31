import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/coutdown.dart';

class RestScreen extends StatefulWidget {
  const RestScreen({super.key, required this.toWork});

  final void Function() toWork;

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
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
              Countdown(minutes: 5),
              SizedBox(height: 20),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.downloading)),
            ],
          ),
        ),
      ),
    );
  }
}
