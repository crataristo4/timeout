import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeout/provider/timer_provider.dart';
import 'package:timeout/utils/enums.dart';

///here is where you wrap the consumer to the page to listen and timeout app
class MainPage extends StatefulWidget {
  static const String routeName = 'main-page';
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    ///do no miss this step
    return Consumer<TimerProvider>(builder: (context, timerProvider, _) {
      ///very important
      context.dependOnInheritedWidgetOfExactType();
      if (timerProvider.timeoutStatus == TimeoutStatus.completed) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          //todo @Sampson-- HERE you have change the route to desired page
          //todo which could be a PIN page or something
        });
      }

      return const Scaffold(
        body: Center(
          child: Text('App must timeout to some page after 5 mins'),
        ),
      );
    });
  }
}
