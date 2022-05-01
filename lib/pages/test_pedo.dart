import 'package:ebrana_schody/widgets/app_text.dart';
import 'package:pedometer/pedometer.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/material.dart';
import 'dart:async';


String formatDate(DateTime d) {
  return 0.toString();
}

void main() {
  runApp(PedoApp());
}

class PedoApp extends StatefulWidget {
  @override
  _PedoAppState createState() => _PedoAppState();
}

class _PedoAppState extends State<PedoApp> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  var x;
  var y;
  var z;

  @override
  void initState() {
    super.initState();
    initPlatformState();

    accelerometerEvents.listen((AccelerometerEvent event) {
        x = event.x;
        y = event.y;
        z = event.z;
    });
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
            children:[
              Text(x, style: TextStyle(fontSize: 60),),
              Text(y, style: TextStyle(fontSize: 60),),
              Text(z, style: TextStyle(fontSize: 60),),
            ]
        );
  }
}