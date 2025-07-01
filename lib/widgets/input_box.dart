import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utilities/global_variable.dart';
import 'package:weather_app/utilities/weather_provider.dart';

class InputBox extends StatefulWidget {
  const InputBox({super.key});

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  @override
  Widget build(BuildContext context) {
    final weatheprovider = Provider.of<WeatherModel>(context);

    return Container(
      // color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onSubmitted: (value) {
            FocusScope.of(context).unfocus(); // dismiss the keyboard
            weatheprovider.fetchcoordinates(value);
          },
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          controller: myController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            hintText: "Enter Location",
            hintStyle: TextStyle(
              color: const Color.fromARGB(255, 167, 167, 167),
            ),
            filled: true,
            fillColor: const Color.fromARGB(39, 255, 255, 255),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: const Color.fromARGB(255, 196, 196, 196),
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(4),
              child: IconButton.filledTonal(
                color: const Color.fromARGB(255, 0, 0, 0),

                onPressed:
                    () => weatheprovider.fetchcoordinates(myController.text),
                icon: Icon(Icons.search, size: 25),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
