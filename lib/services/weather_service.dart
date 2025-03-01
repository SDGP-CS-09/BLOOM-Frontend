import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class WeatherService {
  final String apiKey =
      '7799fb40c8a482506192ae756ff019e6'; // Bloom.Weather API Key

  // Function to get user's current location
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  // Function to fetch weather data based on user location
  Future<Map<String, dynamic>> fetchWeather() async {
    try {
      Position position = await getCurrentLocation(); // Get user's location
      final double lat = position.latitude;
      final double lon = position.longitude;

      final String url =
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body); // Parse JSON response
      } else {
        throw Exception('Failed to load weather data: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }
}
