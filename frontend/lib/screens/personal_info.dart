import 'package:flutter/material.dart';
import '../widgets/step_indicator.dart';
import '../widgets/custom_dropdown.dart';
import '../models/learning_data.dart';
import '../utils/constants.dart';
import 'environment_screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  final LearningData learningData;

  const PersonalInfoScreen({super.key, required this.learningData});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ageController.text = widget.learningData.age ?? '';
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  void _validateAndNavigate(BuildContext context) {
    if (widget.learningData.gender == null ||
        widget.learningData.age == null ||
        widget.learningData.educationLevel == null ||
        widget.learningData.institutionType == null ||
        widget.learningData.itStudent == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EnvironmentScreen(learningData: widget.learningData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(AppStrings.appTitle),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  AppStrings.subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                const StepIndicator(currentStep: 1),
                const SizedBox(height: 40),
                CustomDropdown(
                  label: 'Gender',
                  value: widget.learningData.gender,
                  items: AppConstants.genderOptions,
                  onChanged: (value) {
                    setState(() {
                      widget.learningData.gender = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: 'Educational Level',
                  value: widget.learningData.educationLevel,
                  items: AppConstants.educationLevels,
                  onChanged: (value) {
                    setState(() {
                      widget.learningData.educationLevel = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: 'Institution Type',
                  value: widget.learningData.institutionType,
                  items: AppConstants.institutionTypes,
                  onChanged: (value) {
                    setState(() {
                      widget.learningData.institutionType = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      widget.learningData.age = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: 'IT Student?',
                  value: widget.learningData.itStudent,
                  items: AppConstants.yesNoOptions,
                  onChanged: (value) {
                    setState(() {
                      widget.learningData.itStudent = value;
                    });
                  },
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Previous'),
                    ),
                    ElevatedButton(
                      onPressed: () => _validateAndNavigate(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
