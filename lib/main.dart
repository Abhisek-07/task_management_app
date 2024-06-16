import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/state/task_bloc/task_cubit.dart';
import 'package:task_management_app/state/tasks_app_bloc_observer.dart';
import 'package:task_management_app/utils/export.dart';

void main() {
  Bloc.observer =  TasksAppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
  bodyColor: Colors.black,
  displayColor: Colors.black,
),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.yellow),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow, ),
        useMaterial3: true,
      ),
      home: BlocProvider(create: (BuildContext context) => TasksCubit(),
      child: const HomePage()),
    );
  }
}


