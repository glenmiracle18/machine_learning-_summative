// lib/models/learning_data.dart
class LearningData {
  String? gender;
  String? age;
  String? educationLevel;
  String? institutionType;
  String? itStudent;
  String? location;
  String? loadShedding;
  String? financialCondition;
  String? internetType;
  String? networkType;
  String? classDuration;
  String? selfLms;
  String? device;

  Map<String, dynamic> toJson() {
    // Print current values for debugging
    print('Current values before conversion:');
    print('Gender: $gender');
    print('Age: $age');
    print('Education Level: $educationLevel');
    print('Institution Type: $institutionType');
    print('IT Student: $itStudent');
    print('Location: $location');
    print('Load Shedding: $loadShedding');
    print('Financial Condition: $financialCondition');
    print('Internet Type: $internetType');
    print('Network Type: $networkType');
    print('Class Duration: $classDuration');
    print('Self Lms: $selfLms');
    print('Device: $device');

    final json = {
      'Gender': _convertGender(),
      'Age': _convertAge(),
      'Education_Level': educationLevel ?? 'College',
      'Institution_Type': institutionType ?? 'Government',
      'IT_Student': itStudent ?? 'No',
      'Location': location == 'Urban' ? 'Yes' : 'No',
      'Load_shedding': _convertLoadShedding(),
      'Financial_Condition': _convertFinancialCondition(),
      'Internet_Type': _convertInternetType(),
      'Network_Type': networkType ?? '4G',
      'Class_Duration': _convertClassDuration(),
      'Self_Lms': selfLms ?? 'No',
      'Device': _convertDevice()
    };

    // Print final JSON for debugging
    print('Final JSON to be sent:');
    print(json);

    return json;
  }

  String _convertGender() {
    switch (gender?.toLowerCase()) {
      case 'male':
        return 'Boy';
      case 'female':
        return 'Girl';
      default:
        return 'Boy';
    }
  }

  String _convertAge() {
    final ageNum = int.tryParse(age ?? '0') ?? 0;
    if (ageNum <= 20) return '16-20';
    if (ageNum <= 25) return '21-25';
    if (ageNum <= 30) return '26-30';
    return '>30';
  }

  String _convertLoadShedding() {
    switch (loadShedding?.toLowerCase()) {
      case 'high':
        return 'High';
      case 'medium':
        return 'Mid';
      case 'low':
        return 'Low';
      default:
        return 'Mid';
    }
  }

  String _convertFinancialCondition() {
    switch (financialCondition?.toLowerCase()) {
      case 'poor':
        return 'Poor';
      case 'average':
        return 'Mid';
      case 'good':
        return 'Rich';
      default:
        return 'Mid';
    }
  }

  String _convertInternetType() {
    switch (internetType?.toLowerCase()) {
      case 'mobile data':
        return 'Mobile Data';
      case 'wifi':
      case 'broadband':
        return 'Wifi';
      default:
        return 'Mobile Data';
    }
  }

  String _convertClassDuration() {
    try {
      final duration = int.tryParse(classDuration ?? '0') ?? 0;
      if (duration <= 3) return '1-3';
      if (duration <= 6) return '3-6';
      return '>6';
    } catch (e) {
      print('Error converting class duration: $e');
      return '1-3';
    }
  }

  String _convertDevice() {
    switch (device?.toLowerCase()) {
      case 'mobile phone':
        return 'Mobile';
      case 'laptop':
        return 'Computer';
      case 'tablet':
        return 'Tab';
      default:
        return 'Mobile';
    }
  }
}
