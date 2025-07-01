import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utilities/weather_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    final weatheprovider = Provider.of<WeatherModel>(context);

    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_sharp,
              color: const Color.fromARGB(255, 210, 210, 210),
            ),
            Text(
              weatheprovider.city,
              style: GoogleFonts.robotoCondensed(
                textStyle: TextStyle(
                  color: const Color.fromARGB(255, 210, 210, 210),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
