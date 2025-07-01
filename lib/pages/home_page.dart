import 'package:flutter/material.dart';
import 'package:weather_app/utilities/weather_provider.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utilities/global_variable.dart';
import 'package:weather_app/widgets/input_box.dart';
import 'package:weather_app/widgets/location.dart';
import 'package:weather_app/widgets/weather_clouds.dart';
import 'package:weather_app/widgets/temperature_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    print(" fgdsgsgdsggdgsd $myController");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherModel>(context, listen: false).getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<WeatherModel>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 37, 37),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/black-stars-iphone-0fj7hstk89o8gub5.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [InputBox(), Location(), WeatherClouds(), TemperatureBox()],
        ),
      ),
    );
  }
}
