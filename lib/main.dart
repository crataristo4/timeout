import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeout/provider/timer_provider.dart';
import 'package:timeout/views/splashscreen.dart';

import 'routes/route_generator.dart';
import 'utils/enums.dart';

void main() {
  runApp(const EntryPoint());
}

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  final _timerProvider = TimerProvider();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => TimerProvider()),
      ],
      child: ChangeNotifierProvider<TimerProvider>(
        create: (_) => _timerProvider,
        builder: (context, child) {
          return Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: _handleInteraction,
            child: MaterialApp(
              title: 'Timeout',
              theme: ThemeData(fontFamily: 'regular', primaryColor: Colors.blue),
              initialRoute: SplashScreen.routeName,
              onGenerateRoute: RouteGenerator.generateRoute,
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }

  /// handle user interaction
  void _handleInteraction([_]) async {
    //todo you have to handle your own logic here
    ///in my case i use a token to check if user has logged in
    ///your use-case might be different
    if ('token' != null) {
      ///user has logged in
      ///which simply means reset timer on interaction
      _timerProvider.restartTimer();
    } else if (_timerProvider.timeoutStatus == TimeoutStatus.completed) {
      _timerProvider.stopTimer();
    } else {
      ///do nothing since user has not logged in
      ///todo @Sampson handle your own logic
    }
  }
}
