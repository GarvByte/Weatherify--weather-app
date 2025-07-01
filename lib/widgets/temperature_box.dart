import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utilities/weather_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class TemperatureBox extends StatefulWidget {
  const TemperatureBox({super.key});

  @override
  State<TemperatureBox> createState() => _TemperatureBoxState();
}

class _TemperatureBoxState extends State<TemperatureBox> {
  @override
  Widget build(BuildContext context) {
    final weatheprovider = Provider.of<WeatherModel>(context);

    return Expanded(
      child: Container(
        alignment: Alignment(0, 0),
        // color: Colors.deepOrange,
        child: Text(
          weatheprovider.temperature,
          style: GoogleFonts.robotoCondensed(
            textStyle: TextStyle(
              color: const Color.fromARGB(255, 210, 210, 210),
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }
}
