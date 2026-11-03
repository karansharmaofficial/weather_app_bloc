import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_2/cubit.dart';
import 'package:weather_2/weather_repository.dart';
import 'package:weather_2/weather_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
 const MyApp({super.key});

 @override
 Widget build(BuildContext context) {
 return RepositoryProvider(
  create: (context) => WeatherRepository(),
   child: BlocProvider(
    create: (context) => WeatherCubit(context.read<WeatherRepository>()),
     child: MaterialApp(
     debugShowCheckedModeBanner: false,
     theme: ThemeData.dark(useMaterial3: true),
     home: WeatherScreen(),
     ),
   ),
 );
 }
}