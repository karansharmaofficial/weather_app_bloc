import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherRepository {
  Future<Map<String,dynamic>> getWeather() async{
    try{
      final apiKey = dotenv.env['WEATHER_API_KEY'];
      final res=await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=$apiKey'));
      final data =jsonDecode(res.body);

      if(data['cod']!='200'){
        throw 'An unexpected error occurred';
      }

      return data;
    }catch(e){
      throw e.toString();
    }

  }
}
