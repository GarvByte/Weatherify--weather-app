import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/utilities/global_variable.dart';

class WeatherModel extends ChangeNotifier {
  final String apiKey = "1672234005fb1385dd1255598a481767";
  String _temperature = '';
  String get temperature => _temperature;
  late String latitude;
  late String longitude;
  late String weatherDescription;
  String weatherImage = "assets/mistWeather.json";
  String city =
      myController.text.isEmpty ? "Please type your location" : "loading";

  Future<void> fetchcoordinates(String cityName) async {
    myController.clear();
    final String geocodingURL =
        "https://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=5&appid=$apiKey";
    final responseFromGeocodingAPI = await http.get(Uri.parse(geocodingURL));

    print("myconterller cityu = $cityName");
    print("mycontroeller urtl = $geocodingURL");
    if (responseFromGeocodingAPI.statusCode != 200) {
      print("error = ${responseFromGeocodingAPI.statusCode}");
      print("uanble to fetch coordinated");
      print("ur; = $geocodingURL");
    }
    if (responseFromGeocodingAPI.statusCode == 200) {
      final coordinates = json.decode(responseFromGeocodingAPI.body);
      if (coordinates.isEmpty) {
        city = "location not found";
        print("location not foufsdfsfnd");
        notifyListeners();
      } else {
        latitude = coordinates[0]['lat'].toString();
        longitude = coordinates[0]['lon'].toString();
        city = coordinates[0]['name'];

        print("cityName = $cityName");
        print("latitude = $latitude");
        print("longitude = $longitude");
        await fetchWeather();
      }
    }
  }

  Future<void> fetchWeather() async {
    final String weatherURL =
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey";
    ;
    final responseFromWeatherAPI = await http.get(Uri.parse(weatherURL));

    if (responseFromWeatherAPI.statusCode == 200) {
      final weatherData = json.decode(responseFromWeatherAPI.body);
      _temperature = "${weatherData['main']['temp'].toString()}°C";
      weatherDescription = "${weatherData['weather'][0]['main']}";
      notifyListeners();

      print("temperature = $_temperature");
      print("weathjer  = $weatherData");
    } else {
      print("latitude is there but temperature not found");
    }

    imageName();
  }

  Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (serviceEnabled == false) {
      print("location service is disabled");
      _temperature = "Location service is disabled";
      notifyListeners();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("location permission denied");
        _temperature =
            "Location permission is denied we can't get you temperature of current location but you still can search for the location";
        notifyListeners();
      }
    }
    // print("lcoation = ${await Geolocator.getCurrentPosition()}");
    Position position = await Geolocator.getCurrentPosition();
    latitude = "${position.latitude}";
    longitude = "${position.longitude}";
    print("positon latitude = $latitude and longitude  = $longitude");

    getCity(latitude, longitude);

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getCity(String lat, String lon) async {
    String url =
        "https://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$lon&limit=5&appid=$apiKey";
    final cityResponsefromAPi = await http.get(Uri.parse(url));

    if (cityResponsefromAPi.statusCode != 200) {
      print("error = ${cityResponsefromAPi.statusCode}");
      print("uanble to fetch coordinate from currentlocation");
    }
    if (cityResponsefromAPi.statusCode == 200) {
      final currentLocation = json.decode(cityResponsefromAPi.body);
      if (currentLocation.isEmpty) {
        print("location not found");
        city = "location not found";
        notifyListeners();
      } else {
        city = currentLocation[0]['name'];
        print("Current cityName = $city");
        fetchWeather();
      }
    }
  }

  void imageName() {
    switch (weatherDescription.toLowerCase()) {
      case "clear":
        weatherImage = dayImages[2];
        print("image 1 updated");
        break;

      case "rain":
      case "shower rain":
      case "thunderstorm":
        weatherImage = dayImages[0];
        print("image 2 updated");
        break;

      case "clouds":
      case "scattered clouds":
      case "broken clouds":
      case "overcast clouds":
        weatherImage = dayImages[1];
        print("image 3 updated");
        break;

      case "snow":
        weatherImage = dayImages[3];
        print("image 4 updated");
        break;

      case "mist":
        weatherImage = dayImages[4];
        print("image 5 updated");
        break;

      default:
        weatherImage = dayImages[0]; // fallback
        print("image default updated");
    }

    notifyListeners(); // Only call once after image change
  }
}
