import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'dart:convert';

import '../models/weather.dart';
import '../models/dailyWeather.dart';

class WeatherProvider with ChangeNotifier {
  String apiKey = '3f7fb7e5e186e6824f55b9ac49a2da99';
  Weather weather = Weather();
  DailyWeather currentWeather = DailyWeather();
  List<DailyWeather> hourlyWeather = [];
  List<DailyWeather> hourly24Weather = [];
  List<DailyWeather> fiveDayWeather = [];
  List<DailyWeather> sevenDayWeather = [];
  late bool loading;
  bool isRequestError = false;
  bool isLocationError = false;

  getWeatherData() async {
    loading = true;
    isRequestError = false;
    isLocationError = false;
    await Location().requestService().then((value) async {
      if (value) {
        final locData = await Location().getLocation();
        var latitude = locData.latitude;
        var longitude = locData.longitude;
        Uri url = Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey');
        Uri dailyUrl = Uri.parse(
            'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&exclude=minutely,current&appid=$apiKey');
        try {
          final response = await http.get(url);
          final extractedData =
              json.decode(response.body) as Map<String, dynamic>;
          weather = Weather.fromJson(extractedData);
        } catch (error) {
          loading = false;
          this.isRequestError = true;
          notifyListeners();
        }
        try {
          final response = await http.get(dailyUrl);
          final dailyData = json.decode(response.body) as Map<String, dynamic>;
          currentWeather = DailyWeather.fromJson(dailyData);
          List? tempHourly = [];
          List? temp24Hour = [];
          List? tempSevenDay = [];
          List items = dailyData['daily'];
          List itemsHourly = dailyData['hourly'];
          tempHourly = itemsHourly
              .map((item) => DailyWeather.fromHourlyJson(item))
              .toList()
              .skip(1)
              .take(3)
              .toList();
          temp24Hour = itemsHourly
              .map((item) => DailyWeather.fromHourlyJson(item))
              .toList()
              .skip(1)
              .take(24)
              .toList();
          tempSevenDay = items
              .map((item) => DailyWeather.fromDailyJson(item))
              .toList()
              .skip(1)
              .take(7)
              .toList();
          hourlyWeather = tempHourly.cast<DailyWeather>();
          hourly24Weather = temp24Hour.cast<DailyWeather>();
          sevenDayWeather = tempSevenDay.cast<DailyWeather>();
          loading = false;
          notifyListeners();
        } catch (error) {
          loading = false;
          this.isRequestError = true;
          notifyListeners();
          throw error;
        }
      } else {
        loading = false;
        isLocationError = true;
        notifyListeners();
      }
    });
  }

  searchWeatherData({required String location}) async {
    loading = true;
    isRequestError = false;
    isLocationError = false;
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&appid=$apiKey');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      weather = Weather.fromJson(extractedData);
    } catch (error) {
      loading = false;
      this.isRequestError = true;
      notifyListeners();
      throw error;
    }
    var latitude = weather.lat;
    var longitude = weather.long;
    print(latitude);
    print(longitude);
    Uri dailyUrl = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&exclude=minutely,current&appid=$apiKey');
    try {
      final response = await http.get(dailyUrl);
      final dailyData = json.decode(response.body) as Map<String, dynamic>;
      print(dailyUrl);
      currentWeather = DailyWeather.fromJson(dailyData);
      List? tempHourly = [];
      List temp24Hour = [];
      List tempSevenDay = [];
      List items = dailyData['daily'];
      List itemsHourly = dailyData['hourly'];
      tempHourly = itemsHourly
          .map((item) => DailyWeather.fromHourlyJson(item))
          .toList()
          .skip(1)
          .take(3)
          .toList();
      temp24Hour = itemsHourly
          .map((item) => DailyWeather.fromHourlyJson(item))
          .toList()
          .skip(1)
          .take(24)
          .toList();
      tempSevenDay = items
          .map((item) => DailyWeather.fromDailyJson(item))
          .toList()
          .skip(1)
          .take(7)
          .toList();
      hourlyWeather = tempHourly.cast<DailyWeather>();
      hourly24Weather = temp24Hour.cast<DailyWeather>();
      sevenDayWeather = tempSevenDay.cast<DailyWeather>();
      loading = false;
      notifyListeners();
    } catch (error) {
      loading = false;
      this.isRequestError = true;
      notifyListeners();
      throw error;
    }
  }
}
