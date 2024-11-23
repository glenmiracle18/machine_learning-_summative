import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFE39B63);
  static const Color background = Colors.white;
  static const Color text = Colors.black87;
}

class AppConstants {
  static const List<String> genderOptions = [
    'Male',
    'Female'
  ]; // Will be converted to Boy/Girl

  static const List<String> ageRanges = ['16-20', '21-25', '26-30', '>30'];

  static const List<String> educationLevels = [
    'School',
    'College',
    'University'
  ];

  static const List<String> institutionTypes = ['Government', 'Non Government'];

  static const List<String> yesNoOptions = ['Yes', 'No'];

  static const List<String> locationOptions = ['Yes', 'No'];

  static const List<String> selfLms = ['Yes', 'No'];

  static const List<String> loadSheddingLevels = ['High', 'Mid', 'Low'];

  static const List<String> financialConditions = ['Poor', 'Mid', 'Rich'];

  static const List<String> internetTypes = ['Mobile Data', 'Wifi'];

  static const List<String> networkTypes = ['2G', '3G', '4G'];

  static const List<String> classDurations = ['1-3', '3-6', '>6'];

  static const List<String> deviceTypes = ['Mobile', 'Computer', 'Tab'];
}

class AppStrings {
  static const String appTitle = 'Learning Mode Recommendation';
  static const String subtitle =
      'Predict student success in online learning environments';
}
