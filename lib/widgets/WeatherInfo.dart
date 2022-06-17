import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import '../helper/utils.dart';

class WeatherInfo extends StatelessWidget {
  final wData;
  WeatherInfo({this.wData});

  Widget _weatherInfoBuilder(String header, String body, IconData icon,
      double rightPad, double iconSize) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 15, right: rightPad),
            child: Icon(
              icon,
              color: Colors.blue,
              size: iconSize,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  header,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ),
              FittedBox(
                child: Text(
                  body,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      height: MediaQuery.of(context).size.height / 6,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          image: DecorationImage(
              image: NetworkImage('https://img.freepik.com/free-vector/white-abstract-background-3d-paper-style_23-2148403778.jpg?w=2000'),
              fit: BoxFit.cover

          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 15,
              offset: Offset(6, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: _weatherInfoBuilder(
                'Precipitation',
                '${wData.precip}%',
                WeatherIcons.raindrops,
                0,
                50,
              ),
            ),
            VerticalDivider(
              color: Colors.black,
              indent: 25,
              endIndent: 25,
            ),
            SizedBox(
              child: _weatherInfoBuilder(
                'UV Index',
                UvIndex.mapUviValueToString(uvi: wData.uvi),
                WeatherIcons.day_sunny,
                15,
                30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
