import 'package:calculator_app/provider/calculator_provider.dart';
import 'package:calculator_app/screen/calculator_screen.dart';
import 'package:calculator_app/screen/calculator_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ============= Without Provider ===============
    // return MaterialApp(
    //   title: 'Calculator',
    //   theme: ThemeData.dark(),
    //   home: const CalculatorScreen(),
    // );

    // ============ Using Provider for dependency injection ===========
    return ChangeNotifierProvider(
      create: (_) => CalculatorProvider(),
      child: MaterialApp(
        title: 'Calculator',
        theme: ThemeData.dark(),
        home: CalculatorScreenProvider(),
      ),
    );

    // ============ Using BloC for dependency injection ===========
  }
}
