import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'location.dart';
import 'package:flutter/material.dart';

const apiKey = '4c94589c8beb7654c7fb8fa1b8a3071c';

class WeatherDislpayData {
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDislpayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  WeatherData({required this.locationData});

  LocationHelper locationData;
  double? currentTemperature;
  int? currentCondition;
  String? city;
  Future<void> getCurrentTemperature() async {
    Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric'));
    if (response.statusCode == 200) {
      String data = response.body;

      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        city = currentWeather['name'];
      } catch (e) {
        print('hata burda');
      }
    } else {
      print('apiden deger gelmedi');
    }
  }

  WeatherDislpayData getWeatherDisplayData() {
    if (currentCondition! < 600) {
      return WeatherDislpayData(
          weatherIcon: Icon(
            FontAwesomeIcons.cloud,
            size: 75,
            color: Colors.white,
          ),
          weatherImage: AssetImage('assets/bulutlu.png'));
    } else {
      var now = new DateTime.now();
      if (now.hour > 19) {
        return WeatherDislpayData(
            weatherIcon: Icon(
              FontAwesomeIcons.moon,
              size: 75,
              color: Colors.white,
            ),
            weatherImage: AssetImage('assets/gece.png'));
      } else {
        return WeatherDislpayData(
            weatherIcon: Icon(
              FontAwesomeIcons.sun,
              size: 75,
              color: Colors.white,
            ),
            weatherImage: AssetImage('assets/gunesli.png'));
      }
    }
  }
}
