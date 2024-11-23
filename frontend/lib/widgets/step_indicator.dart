// lib/widgets/step_indicator.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;

  const StepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStep(1, 'Personal Info'),
        _buildLine(1),
        _buildStep(2, 'Environment'),
        _buildLine(2),
        _buildStep(3, 'Technical Setup'),
      ],
    );
  }

  Widget _buildStep(int step, String label) {
    final isActive = step <= currentStep;
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.primary : Colors.grey[300],
          ),
          child: Center(
            child: Text(
              step.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.black87 : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildLine(int step) {
    return Container(
      width: 60,
      height: 1,
      color: Colors.grey[300],
      margin: const EdgeInsets.only(bottom: 20),
    );
  }
}
