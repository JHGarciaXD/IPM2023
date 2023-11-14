import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherBox extends StatefulWidget {
  final String location;

  const WeatherBox({Key? key, required this.location}) : super(key: key);

  @override
  _WeatherBoxState createState() => _WeatherBoxState();
}

class _WeatherBoxState extends State<WeatherBox> {
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

  Icon _getWeatherIcon() {
    if (_weather == null) {
      return const Icon(Icons.cloud, color: Colors.black);
    }

    switch (_weather?.weatherMain) {
      case 'Céu limpo':
        return const Icon(Icons.wb_sunny, color: Colors.black);
      case 'Nuvens':
        return const Icon(Icons.cloud, color: Colors.black);
      case 'Chuva':
        return const Icon(Icons.beach_access, color: Colors.black);
      case 'Neve':
        return const Icon(Icons.ac_unit, color: Colors.black);
      default:
        return const Icon(Icons.cloud, color: Colors.black);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_weather == null)
                CircularProgressIndicator()
              else
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getWeatherIcon(),
                    const SizedBox(height: 12.0),
                    Text(
                      '${_weather?.temperature?.celsius?.toStringAsFixed(1)}°C',
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
