import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class UvIndex {
  static String mapUviValueToString({var uvi}) {
    String uvIndex;
    if (uvi <= 2) {
      return uvIndex = 'Low';
    } else if (uvi <= 5) {
      return uvIndex = 'Medium';
    } else if (uvi <= 7) {
      return uvIndex = 'High';
    } else if (uvi <= 10) {
      return uvIndex = 'Very High';
    } else if (uvi >= 11) {
      return uvIndex = 'Extreme';
    } else {
      uvIndex = 'Unknown';
    }
    return uvIndex;
  }
}

class MapString {
  static Widget mapInputToWeather(String input, BuildContext context) {
    String text2;
    switch (input) {
      case 'Tornado':
        text2 = 'Tornado';
        break;
      case 'Thunderstorm':
        text2 = 'Thunderstorm';
        break;
      case 'Drizzle':
        text2 = 'Drizzly';
        break;
      case 'Rain':
        text2 = 'Raining';
        break;
      case 'Snow':
        text2 = 'Snowing';
        break;
      case 'Mist':
        text2 = 'Misty';
        break;
      case 'fog':
        text2 = 'Foggy';
        break;
      case 'Smoke':
        text2 = 'Smoky';
        break;
      case 'Squall':
        text2 = 'Squally';
        break;
      case 'Haze':
        text2 = 'Hazy';
        break;
      case 'Dust':
        text2 = 'Dusty';
        break;
      case 'Sand':
        text2 = 'Sandy';
        break;
      case 'Ash':
        text2 = 'Ashy';
        break;
      case 'Clear':
        text2 = "Sunny";
        break;
      case 'Clouds':
        text2 = "Cloudy";
        break;
      default:
        text2 = "No Info";
    }
    return Text(
      text2,
      style: TextStyle(
        fontSize: 15,
      ),
    );
  }

  static Icon mapStringToIcon(
      String input, BuildContext context, double iconSize) {
    IconData myIcon;
    switch (input) {
      case 'Thunderstorm':
        myIcon = WeatherIcons.thunderstorm;
        break;
      case 'Drizzle':
        myIcon = WeatherIcons.wind_deg_0;
        break;
      case 'Rain':
        myIcon = WeatherIcons.rain;
        break;
      case 'Snow':
        myIcon = WeatherIcons.snow;
        break;
      case 'Clear':
        myIcon = WeatherIcons.day_sunny;
        break;
      case 'Clouds':
        myIcon = WeatherIcons.cloudy;
        break;
      case 'Mist':
        myIcon = WeatherIcons.fog;
        break;
      case 'fog':
        myIcon = WeatherIcons.fog;
        break;
      case 'Smoke':
        myIcon = WeatherIcons.smoke;
        break;
      case 'Haze':
      case 'Dust':
      case 'Sand':
        myIcon = WeatherIcons.sandstorm;
        break;
      case 'Ash':
        myIcon = WeatherIcons.volcano;
        break;
      case 'Squall':
      case 'Tornado':
        myIcon = WeatherIcons.hurricane_warning;
        break;
      default:
        myIcon = WeatherIcons.na;
    }
    return Icon(
      myIcon,
      size: iconSize,
      color: Theme.of(context).primaryColor,
    );
  }
}
