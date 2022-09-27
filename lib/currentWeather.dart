import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:http/http.dart' as http;

class CurrentWeatherPage extends StatefulWidget {
  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot != null) {
                Weather weather = snapshot.data;
                if (weather == null) {
                  return Text("Error getting weather");
                } else {
                  return  weatherBox(weather);
                }
              } else {
                return CircularProgressIndicator();
              }
            },
            future: getCurrentWeather(),
          ),
        )
    );
  }

  Widget weatherBox(Weather weather) {

    return Column(
        children: <Widget>[
          Text("${weather.temp}°C"),
          Text("${weather.description}"),
          Text("Feels:${weather.feelsLike}°C"),
          Text("H:${weather.high}°C L:${weather.low}°C"),
        ]
    );
  }

  Future getCurrentWeather() async {
    late Weather weather;
    String city = "Dhaka";
    String apiKey = "2317a35c6a10c1657d739fcc89ce2f36";
    var url = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
    } else {
      // TODO: Throw error here
    }
    return weather;
  }
}
