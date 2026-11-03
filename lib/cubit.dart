import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_2/weather_repository.dart';

abstract class WeatherState{}
class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState{
  final Map<String,dynamic> weatherData;
  WeatherLoaded(this.weatherData);
}

class WeatherError extends WeatherState {
  final String errorMessage;
  WeatherError(this.errorMessage);
}


class WeatherCubit extends Cubit<WeatherState>{
  final WeatherRepository weatherRepository;
  WeatherCubit(this.weatherRepository) : super(WeatherInitial());

  Future<void> getCurrentWeather() async{
    emit(WeatherLoading());
    try{
      final weatherData = await weatherRepository.getWeather();
      emit(WeatherLoaded(weatherData));
    }catch(e  ){
     String errorMessage=e.toString();
      emit(WeatherError(errorMessage));
    }
  }


}