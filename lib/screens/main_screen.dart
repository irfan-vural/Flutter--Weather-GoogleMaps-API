import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/utils/location.dart';
import 'package:weather_app/utils/weather.dart';

class MainScreen extends StatefulWidget {
  final WeatherData weatherData;
  final LocationHelper locationData;

  const MainScreen(
      {super.key, required this.weatherData, required this.locationData});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? temperature;
  Icon? weatherDisplayIcon;
  AssetImage? backgroundImage;
  String? city;
  var initialCameraPosition =
      CameraPosition(target: LatLng(41.010850, 28.966990), zoom: 21);

  void updatedDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature!.round();
      WeatherDislpayData weatherDislpayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDislpayData.weatherImage;
      weatherDisplayIcon = weatherDislpayData.weatherIcon;
      city = weatherData.city;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatedDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(child: weatherDisplayIcon),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                '$temperature°',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  letterSpacing: -5,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                '$city',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  // letterSpacing: -5,
                ),
              ),
            ),
            SizedBox(
              height: 95,
            ),
            FloatingActionButton(onPressed: () {
              FirebaseFirestore firestore = FirebaseFirestore.instance;
              CollectionReference users =
                  FirebaseFirestore.instance.collection('user');

              users.add("data${hashCode}");
            })
            // Container(
            //    height: 400,
            //    child: GoogleMap(
            //      initialCameraPosition: initialCameraPosition,
            //    ),
            //  )
          ],
        ),
      ),
    );
  }
}
