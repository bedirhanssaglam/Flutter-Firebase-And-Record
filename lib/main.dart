import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_and_firebase_service/feature/home/view/home_view.dart';
import 'package:flutter_record_and_firebase_service/product/constants/product_constants.dart';
import 'package:flutter_record_and_firebase_service/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ProductConstants.appName,
      theme: ThemeData.dark(),
      home: const HomeView(),
    );
  }
}
