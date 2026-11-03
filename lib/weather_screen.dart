import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_2/add.dart';
import 'package:weather_2/cubit.dart';
import 'dart:ui';

import 'package:weather_2/forecast.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

@override
  void initState() {
    super.initState();
    context.read<WeatherCubit>().getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Weather App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<WeatherCubit>().getCurrentWeather();
            },
            icon: Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitial) {
            return const Center(
              child: Text(
                'Tap the refresh icon to load weather',
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),
            );
          }
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is WeatherError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          if (state is WeatherLoaded) {
            final data = state.weatherData;

            final currentTemp = data['list'][0]['main']['temp'].toString();
            final currentSky = data['list'][0]['weather'][0]['main'];

            final humidity =data['list'][0]['main']['humidity'].toString();
            final windSpeed = data['list'][0]['wind']['speed'].toString();
            final pressure = data['list'][0]['main']['pressure'].toString();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,

                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '$currentTemp K',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36,
                                  ),
                                ),
                                Icon(
                                  currentSky == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 64,
                                ),
                                Text(
                                  currentSky,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Text(
                    'Hourly Forecast',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(height: 10),

                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final hourlyData = data['list'][index + 1];
                        final hourlyTemp = hourlyData['main']['temp'].toString();
                        final hourlySky = hourlyData['weather'][0]['main'];
                        final timeString = hourlyData['dt_txt'].substring(11, 16);
                        return Forecast(
                          temp: hourlyTemp,
                          icon: hourlySky == 'Rain' ? Icons.beach_access : Icons.sunny,
                          time: timeString,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Additional Information',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Add(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: humidity,
                      ),
                      Add(
                        icon: Icons.air,
                        label: 'Wind Speed',
                        value: windSpeed,
                      ),
                      Add(
                        icon: Icons.beach_access,
                        label: 'Pressure',
                        value: pressure,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
