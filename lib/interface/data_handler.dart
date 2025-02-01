import 'package:hive_ce_flutter/hive_flutter.dart';

const pomodoroBox = "pomodoro_box";
const userSettings = "user_settings";
const userSessions = "user_sessions";

final _storageBox = Hive.box(pomodoroBox);
final List userSettingsTable = _storageBox.get(userSettings) ?? [];
final List userSessionsTable = _storageBox.get(userSessions) ?? [];

void updateSettings(Map<String, dynamic> updated) {
  _saveToDatabase(tableName: userSettings, data: [updated]);
}

void addSession(Map<String, dynamic> completedSession) {
  userSessionsTable.add(completedSession);
  _saveToDatabase(tableName: userSessions, data: userSessionsTable);
}

void editSession({
  required Map<String, dynamic> old,
  required Map<String, dynamic> updated,
}) {
  int index = userSessionsTable.indexOf(old);
  userSessionsTable.remove(old);
  userSessionsTable.insert(index, updated);
}

void deleteSession(Map<String, dynamic> session) {
  userSessionsTable.remove(session);
}

void logUserSettings(Map<String, dynamic> userProfile) {
  _saveToDatabase(tableName: userSettings, data: [userProfile]);
}

Map getUserSettings() {
  return userSettingsTable[0];
}

Map getUserSessions() {
  return userSessionsTable[0];
}

// Basic Functions
void _saveToDatabase({required String tableName, required List data}) {
  _storageBox.put(tableName, data);
}
