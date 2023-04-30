import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static String timeKey = "TIMEKEY";
  static String lastDoneOn = "LASTDONEON";
  static String streakKey = "StreakKey";
  static String kcalKey = "kcalKey";
  static String workOutTimeKey = "WorkOutTimeKey";
  static String firstTime = "FIRSTTIMEKEY";

  //To calculate workout duration
  static Future<bool> setStartTime(String time) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(timeKey, time);
  }

  static Future<String?> getStartTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(timeKey);
  }

//To maintain the streak increment

  static Future<bool> setLastDoneOn(String date) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(lastDoneOn, date);
  }

  static Future<String?> getLastDoneOn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(lastDoneOn);
  }

//To fetch and save the value of streak
  static Future<bool> setStreak(int streak) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setInt(streakKey, streak);
  }

  static Future<int?> getStreak() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(streakKey);
  }

// To fetch and save the kCAL of workout
  static Future<bool> setkcal(int kcal) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setInt(kcalKey, kcal);
  }

  static Future<int?> getKcal() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(kcalKey);
  }

//To save and fetch the overall workout time
  static Future<bool> setWorkOutTime(int minutes) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setInt(workOutTimeKey, minutes);
  }

  static Future<int?> getWorkOutTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(workOutTimeKey);
  }

  static Future<bool> setFirstTime(bool isFirstTime) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(firstTime, isFirstTime);
  }

  static Future<bool?> getFirstTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(firstTime);
  }
}
