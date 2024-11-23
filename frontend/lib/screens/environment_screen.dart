import 'package:flutter/material.dart';
import '../widgets/navigation_button.dart';
import '../widgets/step_indicator.dart';
import '../widgets/custom_dropdown.dart';
import '../models/learning_data.dart';
import '../utils/constants.dart';
import 'technical_setup_screen.dart';

class EnvironmentScreen extends StatefulWidget {
  final LearningData learningData;

  const EnvironmentScreen({super.key, required this.learningData});

  @override
  State<EnvironmentScreen> createState() => _EnvironmentScreenState();
}

class _EnvironmentScreenState extends State<EnvironmentScreen> {
  void _validateAndNavigate(BuildContext context) {
    if (widget.learningData.location == null ||
        widget.learningData.financialCondition == null ||
        widget.learningData.selfLms == null ||
        widget.learningData.loadShedding == null) {
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
            TechnicalSetupScreen(learningData: widget.learningData),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  AppStrings.subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                const StepIndicator(currentStep: 2),
                const SizedBox(height: 40),
                CustomDropdown(
                  label: 'Good learning location?',
                  value: widget.learningData.location,
                  items: AppConstants.locationOptions,
                  onChanged: (value) {
                    setState(() {
                      widget.learningData.location = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: 'Financial Condition',
                  value: widget.learningData.financialCondition,
                  items: AppConstants.financialConditions,
                  onChanged: (value) {
                    setState(() {
                      widget.learningData.financialCondition = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: 'Self Lms',
                  value: widget.learningData.selfLms,
                  items: AppConstants.selfLms,
                  onChanged: (value) {
                    setState(() {
                      widget.learningData.selfLms = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: 'Load-Shedding Level',
                  value: widget.learningData.loadShedding,
                  items: AppConstants.loadSheddingLevels,
                  onChanged: (value) {
                    setState(() {
                      widget.learningData.loadShedding = value;
                    });
                  },
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 80),
                NavigationButtons(
                  onPrevious: () => Navigator.pop(context),
                  onNext: () => _validateAndNavigate(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
