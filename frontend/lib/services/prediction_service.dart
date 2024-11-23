// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/learning_data.dart';

class ApiService {
  final String baseUrl =
      'https://summative-ml-4-794291747792.us-central1.run.app';

  Future<String> predictAdaptability(LearningData learningData) async {
    try {
      final data = learningData.toJson();
      print('Sending request with data: ${jsonEncode(data)}');

      final response = await http.post(
        Uri.parse('$baseUrl/predict'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result['prediction'].toString();
      } else {
        throw Exception('Failed to predict adaptability: ${response.body}');
      }
    } catch (e) {
      print('Error in prediction: $e');
      throw Exception('Error making prediction: $e');
    }
  }
}
