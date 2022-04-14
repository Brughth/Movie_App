import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_infos/home/cubit/carousel_cubit.dart';
import 'package:movie_infos/home/home_page.dart';
import 'package:movie_infos/outils/theme.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: lightTheme,
        dark: darkTheme,
        initial: AdaptiveThemeMode.dark,
        builder: (theme, darkTheme) {
          return BlocProvider(
            create: (context) => CarouselCubit(),
            child: MaterialApp(
              title: 'Movie Infos',
              debugShowCheckedModeBanner: false,
              theme: theme,
              darkTheme: darkTheme,
              home: const HomePage(),
            ),
          );
        });
  }
}
