import 'package:flutter/material.dart';
import 'package:pomodoro/interface/data_handler.dart';
import 'package:pomodoro/models/user.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final previousData = getUserSettings();
  Map<String, dynamic> newData = {};

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      updateSettings(newData);
      Navigator.of(context).pop();
    }
  }

  bool _validateHexCode(String value) {
    if (value.isEmpty) {
      return false;
    }
    if ((value[0] == "#" && value.length != 7) ||
        (value[0] != "#" && value.length != 6)) {
      return false;
    }
    if (value.length == 7) {
      value = value.replaceFirst("#", "");
    }
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value) ? true : false;
  }

  String _getProperHexCode(String value) {
    if (value[0] != "#") {
      return "#$value";
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromARGB(255, 29, 32, 33),
        backgroundColor: Color.fromARGB(255, 69, 133, 136),
      ),
      backgroundColor: Color.fromARGB(255, 69, 133, 136),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(color: Color.fromARGB(255, 249, 245, 215)),
                  maxLength: 20,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 29, 32, 33),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your name";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    newData[Settings.name.toString()] = value;
                  },
                  initialValue: previousData[Settings.name.toString()],
                ),
                TextFormField(
                  style: TextStyle(color: Color.fromARGB(255, 249, 245, 215)),
                  maxLength: 30,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 29, 32, 33),
                    ),
                  ),
                  onSaved: (value) {
                    newData[Settings.email.toString()] = value;
                  },
                  validator: (value) {
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value!);
                    return emailValid ? null : "Enter a valid email.";
                  },
                  initialValue: previousData[Settings.email.toString()],
                ),

                TextFormField(
                  style: TextStyle(color: Color.fromARGB(255, 249, 245, 215)),
                  decoration: InputDecoration(
                    labelText: "Work Time",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 29, 32, 33),
                    ),
                  ),
                  onSaved: (value) {
                    newData[Settings.work_time.toString()] = int.parse(value!);
                  },
                  validator: (value) {
                    int? toInt = int.tryParse(value!);
                    if (toInt == null || toInt < 0) {
                      return "Enter valid positive number";
                    }
                    return null;
                  },
                  initialValue:
                      previousData[Settings.work_time.toString()].toString(),
                ),
                TextFormField(
                  style: TextStyle(color: Color.fromARGB(255, 249, 245, 215)),
                  decoration: InputDecoration(
                    labelText: "Rest Time",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 29, 32, 33),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    int? toInt = int.tryParse(value!);
                    if (toInt == null || toInt < 0) {
                      return "Enter valid positive number";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    newData[Settings.rest_time.toString()] = int.parse(value!);
                  },
                  initialValue:
                      previousData[Settings.rest_time.toString()].toString(),
                ),
                TextFormField(
                  style: TextStyle(color: Color.fromARGB(255, 249, 245, 215)),
                  maxLength: 7,
                  decoration: InputDecoration(
                    labelText: "Work background",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 29, 32, 33),
                    ),
                  ),
                  validator: (value) {
                    return _validateHexCode(value!)
                        ? null
                        : "Enter valid hex code";
                  },
                  onSaved: (value) {
                    newData[Settings.work_background
                        .toString()] = _getProperHexCode(value!);
                  },
                  initialValue:
                      previousData[Settings.work_background.toString()],
                ),
                TextFormField(
                  style: TextStyle(color: Color.fromARGB(255, 249, 245, 215)),
                  maxLength: 7,
                  decoration: InputDecoration(
                    labelText: "Work foreground",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 29, 32, 33),
                    ),
                  ),
                  validator: (value) {
                    return _validateHexCode(value!)
                        ? null
                        : "Enter valid hex code";
                  },
                  onSaved: (value) {
                    newData[Settings.work_foreground
                        .toString()] = _getProperHexCode(value!);
                  },
                  initialValue:
                      previousData[Settings.work_foreground.toString()],
                ),
                TextFormField(
                  style: TextStyle(color: Color.fromARGB(255, 249, 245, 215)),
                  maxLength: 7,
                  decoration: InputDecoration(
                    labelText: "Rest background",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 29, 32, 33),
                    ),
                  ),
                  validator: (value) {
                    return _validateHexCode(value!)
                        ? null
                        : "Enter valid hex code";
                  },
                  onSaved: (value) {
                    newData[Settings.rest_background
                        .toString()] = _getProperHexCode(value!);
                  },
                  initialValue:
                      previousData[Settings.rest_background.toString()],
                ),
                TextFormField(
                  style: TextStyle(color: Color.fromARGB(255, 249, 245, 215)),
                  maxLength: 7,
                  decoration: InputDecoration(
                    labelText: "Rest foreground",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 29, 32, 33),
                    ),
                  ),
                  validator: (value) {
                    return _validateHexCode(value!)
                        ? null
                        : "Enter valid hex code";
                  },
                  onSaved: (value) {
                    newData[Settings.rest_foreground
                        .toString()] = _getProperHexCode(value!);
                  },
                  initialValue:
                      previousData[Settings.rest_foreground.toString()],
                ),

                // buttons to save or cancle
                SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          _submitForm();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 235, 219, 178),
                        ),
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Color.fromARGB(255, 29, 32, 33),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 251, 73, 52),
                        ),
                        child: Text(
                          "Cancle",
                          style: TextStyle(
                            color: Color.fromARGB(255, 29, 32, 33),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
