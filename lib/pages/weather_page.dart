import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {


  //api Key
  final _weatherService = WeatherService('683eea191171fe2c02f4e92188ba65ef');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async{
    String cityName = await _weatherService.getCurrentCity();

  try{
    final weather =  await _weatherService.getWeather(cityName);
    setState(() {
      _weather = weather;
    });
  }
  // any errors
  catch (e){
    debugPrint ('error');
  }
}
 //weather animantion 
String getWeatherAnimation(String? mainCondition){
  if(mainCondition == null) return 'assets/sunny.json';
  switch (mainCondition.toLowerCase()){
    case 'clouds':
    case 'mist':
    case 'haze':
    case 'dust':
    case 'fog':
    case 'smoke':
      return 'assets/cloudy.json';
    case 'rain':
    case 'drizzle':
    case 'shower rain':
      return 'assets/rainy.json';
     case 'thunderstorm':
       return 'asssets/thundrain.json'; 
      case 'clear':
       return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
  }

}

 //init state
 @override
  void initState() {
    super.initState();
   _fetchWeather(); 
  }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName?? "loading city..."),

                //animation
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),  
            Text('${_weather?.temperature.round()}°'),
          
          //weather condition
            Text(_weather?.mainCondition?? "")
          ],
        ),
      ),
    );
  }
}