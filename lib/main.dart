// main.dart (updated)
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisser_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tisser_app/features/auth/presentation/bloc/auth_events.dart';
import 'package:tisser_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:tisser_app/features/auth/presentation/pages/splash_screen.dart';
import 'package:tisser_app/features/task/presentation/bloc/task_event.dart';
import 'firebase_options.dart';
import 'service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthBloc>()..add(LoadCurrentUserEvent()),
        ),
        BlocProvider(
          create: (context) => di.sl<TaskBloc>()..add(LoadTasksEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        theme: ThemeData(
          primaryColor: Colors.deepOrange,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.deepOrange,
            secondary: Colors.orange,
          ),
          appBarTheme: const AppBarTheme(
            color: Colors.deepOrange,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
