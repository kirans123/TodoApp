import 'package:flutter/material.dart';
import 'package:login_and_registration/app/widgets/app_button.dart';
import 'package:login_and_registration/utils/constants/assets.dart';
import 'package:login_and_registration/utils/theme/gap.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(Assets.error),
            const Text(
              'An error occurred',
            ),
            Gap.h20,
            AppButton(
              type: ButtonType.primary,
              text: 'Go Back',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
