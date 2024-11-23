import 'package:flutter/material.dart';
import 'screens/personal_info.dart';
import 'models/learning_data.dart';
import 'utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning Mode Recommendation',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: PersonalInfoScreen(
        learningData: LearningData(),
      ),
    );
  }
}
