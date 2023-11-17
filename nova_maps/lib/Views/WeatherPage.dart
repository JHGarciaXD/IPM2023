import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather/weather.dart';

class WeatherPage extends StatefulWidget {
  final String location;
  final VoidCallback openDrawer;

  const WeatherPage(
      {Key? key, required this.location, required this.openDrawer})
      : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherFactory wf = WeatherFactory("791419c029c33fc5048c2cba277d742b");
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    _weather = await wf.currentWeatherByCityName(widget.location);
    setState(() {});
  }

  Icon _getWeatherIcon(double iconSize) {
    if (_weather == null) {
      return Icon(Icons.cloud, color: Colors.white, size: iconSize);
    }

    switch (_weather?.weatherMain) {
      case 'Céu limpo':
        return Icon(Icons.wb_sunny, color: Colors.white, size: iconSize);
      case 'Nuvens':
        return Icon(Icons.cloud, color: Colors.white, size: iconSize);
      case 'Chuva':
        return Icon(Icons.beach_access, color: Colors.white, size: iconSize);
      case 'Neve':
        return Icon(Icons.ac_unit, color: Colors.white, size: iconSize);
      default:
        return Icon(Icons.cloud, color: Colors.white, size: iconSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[300]!, Colors.grey[600]!],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Weather Icon
              _getWeatherIcon(200.0),

              // Temperature
              SizedBox(height: 20.0),
              Text(
                '${_weather?.temperature?.celsius?.toStringAsFixed(1)}°C',
                style: const TextStyle(
                  fontSize: 36.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 40.0),

              // Wind and Humidity
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Wind: ${_weather?.windSpeed} m/s    Humidity: ${_weather?.humidity}%',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Forecast for the Next Day
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Feels Like Temperature:  ${_weather?.tempFeelsLike}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
