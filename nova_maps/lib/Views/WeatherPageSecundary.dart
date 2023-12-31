import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:weather/weather.dart';

class WeatherPageSecond extends StatefulWidget {
  final String location;

  const WeatherPageSecond({Key? key, required this.location}) : super(key: key);

  @override
  _WeatherPageSecondState createState() => _WeatherPageSecondState();
}

class _WeatherPageSecondState extends State<WeatherPageSecond> {
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Weather Page', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.grey[800], // Dark grey background
      ),
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
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Wind: ${_weather?.windSpeed} m/s    Humidity: ${_weather?.humidity}%',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Forecast for the Next Day
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Feels Like Temperature:  ${_weather?.tempFeelsLike}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _launchURL,
                child: Text('More Weather Info'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Button color
                  onPrimary: Colors.white, // Text color
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  
  void _launchURL() async {
    const url =
        'https://www.accuweather.com/pt/pt/almada/275589/weather-forecast/275589';

    Uri uri = Uri.parse(url);

    await launchUrl(uri);
  }
}
