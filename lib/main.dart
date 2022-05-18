import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rabbit/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  
  runApp(const App());
}
