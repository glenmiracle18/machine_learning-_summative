import 'package:flutter/material.dart';
import '../widgets/step_indicator.dart';
import '../widgets/custom_dropdown.dart';
import '../models/learning_data.dart';
import '../utils/constants.dart';
import '../services/prediction_service.dart';
import 'prediction_result_screen.dart';

class TechnicalSetupScreen extends StatefulWidget {
  final LearningData learningData;

  const TechnicalSetupScreen({super.key, required this.learningData});

  @override
  State<TechnicalSetupScreen> createState() => _TechnicalSetupScreenState();
}

class _TechnicalSetupScreenState extends State<TechnicalSetupScreen> {
  final ApiService _apiService = ApiService();
  final _classDurationController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _classDurationController.text = widget.learningData.classDuration ?? '';
  }

  @override
  void dispose() {
    _classDurationController.dispose();
    super.dispose();
  }

  Future<void> _makePrediction() async {
    // Validate that all required fields are filled
    if (widget.learningData.internetType == null ||
        widget.learningData.device == null ||
        widget.learningData.networkType == null ||
        widget.learningData.classDuration == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final prediction =
          await _apiService.predictAdaptability(widget.learningData);

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PredictionResultsScreen(
            learningData: widget.learningData,
            predictionResult: prediction,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
                const StepIndicator(currentStep: 3),
                const SizedBox(height: 40),
                CustomDropdown(
                  label: 'Internet Type',
                  value: widget.learningData.internetType,
                  items: AppConstants.internetTypes,
                  onChanged: (value) {
                    setState(() {
                      widget.learningData.internetType = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: 'Device',
                  value: widget.learningData.device,
                  items: AppConstants.deviceTypes,
                  onChanged: (value) {
                    setState(() {
                      widget.learningData.device = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: 'Network Type',
                  value: widget.learningData.networkType,
                  items: AppConstants.networkTypes,
                  onChanged: (value) {
                    setState(() {
                      widget.learningData.networkType = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _classDurationController,
                  decoration: InputDecoration(
                    labelText: 'Class Duration (hours)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      widget.learningData.classDuration = value;
                    });
                  },
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed:
                          _isLoading ? null : () => Navigator.pop(context),
                      child: const Text('Previous'),
                    ),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _makePrediction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text('Predict'),
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
