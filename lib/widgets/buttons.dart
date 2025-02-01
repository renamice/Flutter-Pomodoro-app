import 'package:flutter/material.dart';
import 'package:pomodoro/interface/hexcolor.dart';

class ButtonMore extends StatelessWidget {
  const ButtonMore({super.key, required this.color});

  final String color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {},
          icon: TextButton(
            onPressed: () {},
            child: Text(
              "Timeline",
              style: TextStyle(color: HexColor.fromHex(color)),
            ),
          ),
        ),
        SizedBox(width: 30),
        IconButton(
          onPressed: () {},
          icon: TextButton(
            onPressed: () {},
            child: Text(
              "Settings",
              style: TextStyle(color: HexColor.fromHex(color)),
            ),
          ),
        ),
      ],
    );
    //return Container(
    //  decoration: BoxDecoration(
    //    borderRadius: BorderRadiusDirectional.circular(50),
    //    border: Border.all(color: HexColor.fromHex(color)),
    //  ),
    //  child: IconButton(
    //    onPressed: () {},
    //    icon: Icon(Icons.more_horiz, color: HexColor.fromHex(color)),
    //  ),
    //);
  }
}
