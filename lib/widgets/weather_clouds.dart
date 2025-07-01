import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utilities/weather_provider.dart';

class WeatherClouds extends StatefulWidget {
  const WeatherClouds({super.key});

  @override
  State<WeatherClouds> createState() => _WeatherCloudsState();
}

class _WeatherCloudsState extends State<WeatherClouds> {
  
  @override
  Widget build(BuildContext context) {
    final weatheprovider = Provider.of<WeatherModel>(context);

    return Expanded(
      child: Container(
        alignment: Alignment(0, 0),
        child: LottieBuilder.asset(
          weatheprovider.weatherImage,
        ),
      ),
    );
  }
}
