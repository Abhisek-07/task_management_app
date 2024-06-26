import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_management_app/state/task_bloc/task_cubit.dart';
import 'package:task_management_app/state/tasks_app_bloc_observer.dart';
import 'package:task_management_app/ui_defaults/ui_default_styles.dart';
import 'package:task_management_app/utils/export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();

  Hive
    ..init(appDocumentDir.path)
    ..registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasksBox');
  Bloc.observer = TasksAppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.yellow, titleTextStyle: appBarTextStyle,
          // foregroundColor: Colors.black
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.yellow,
        ),
        useMaterial3: true,
      ),
      home: BlocProvider<TasksCubit>(
          create: (BuildContext context) => TasksCubit(),
          child: const HomePage()),
    );
  }
}
