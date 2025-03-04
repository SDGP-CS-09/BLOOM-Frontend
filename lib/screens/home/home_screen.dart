import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _city = "Loading...";
  String _temperature = "--°C";
  String _weatherIcon = "☁️";

  @override
  void initState() {
    super.initState();
    _getWeather();
  }

  Future<void> _getWeather() async {
    try {
      Position position = await _determinePosition();
      Map<String, dynamic> weatherData =
          await fetchWeather(position.latitude, position.longitude);

      setState(() {
        _city =
            "${weatherData['name']}, ${weatherData['sys']['country']}"; // Include country
        _temperature = "${weatherData['main']['temp'].toStringAsFixed(0)}°C";
        _weatherIcon = getWeatherEmoji(weatherData['weather'][0]['main']);
      });
    } catch (e) {
      setState(() {
        _city = "Location Error";
        _temperature = "--°C";
      });
    }
  }

  String getWeatherEmoji(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return "☀️";
      case 'clouds':
        return "☁️";
      case 'rain':
        return "🌧️";
      case 'thunderstorm':
        return "⛈️";
      case 'snow':
        return "❄️";
      default:
        return "🌥️";
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
    const String apiKey = '7799fb40c8a482506192ae756ff019e6'; // Your API Key
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildNavItem(String assetPath, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Image.asset(
        assetPath,
        width: 30,
        height: 30,
        color: _selectedIndex == index ? Colors.green : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      Column(
        children: [
          const SizedBox(height: 50), // Space under status bar

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search plants & Flowers",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Weather Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: 320,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _weatherIcon,
                    style: const TextStyle(fontSize: 40),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _temperature,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _city,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: Center(
              child: Text("Home Page", style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
      const Center(
          child: Text("Community Page", style: TextStyle(fontSize: 20))),
      const Center(child: Text("Explore Page", style: TextStyle(fontSize: 20))),
      const Center(child: Text("Profile Page", style: TextStyle(fontSize: 20))),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem('assets/Logos/Vector 300 (Stroke).png', 0), // Home
              _buildNavItem('assets/Logos/profile-2user.png', 1), // Community
              const SizedBox(width: 50), // Space for FloatingActionButton
              _buildNavItem('assets/Logos/tree.png', 2), // Explore
              _buildNavItem('assets/Logos/profile-circle.png', 3), // Profile
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF003300),
        elevation: 0,
        child: const Icon(
          Icons.camera_alt,
          size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
