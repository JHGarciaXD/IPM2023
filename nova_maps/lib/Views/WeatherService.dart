import 'package:weather/weather.dart';

class WeatherService {
  final String apiKey;
  final WeatherFactory weatherFactory;

  WeatherService(this.apiKey) : weatherFactory = WeatherFactory(apiKey);

  Future<Weather?> getWeatherByCityName(String cityName) async {
    try {
      return await weatherFactory.currentWeatherByCityName(cityName);
    } catch (e) {
      print('Error fetching weather data: $e');
      return null;
    }
  }
}
