import 'package:flutter/material.dart';
import 'package:login_form_validation/pallete.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(
          color: Pallete.whiteColor,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
