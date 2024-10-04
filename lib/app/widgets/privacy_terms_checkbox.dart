import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login_and_registration/data/init/init_service.dart';
import 'package:login_and_registration/utils/constants/constants.dart';

class PrivacyTermsCheckbox extends StatefulWidget {
  final bool isTermsAccepted;
  final ValueChanged<bool?> onChanged;

  const PrivacyTermsCheckbox({
    super.key,
    required this.isTermsAccepted,
    required this.onChanged,
  });

  @override
  PrivacyTermsCheckboxState createState() => PrivacyTermsCheckboxState();
}

class PrivacyTermsCheckboxState extends State<PrivacyTermsCheckbox> {
  Future<void> _onPrivacyPolicyTap() async {
    await launchService.launchUrlInApp(privacyUrl);
  }

  Future<void> _onTermsConditionsTap() async {
    await launchService.launchUrlInApp(termsUrl);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Checkbox(
          value: widget.isTermsAccepted,
          onChanged: widget.onChanged,
        ),
        Expanded(
          child: GestureDetector(
            child: RichText(
              text: TextSpan(
                style: theme.textTheme.bodyMedium,
                children: [
                  const TextSpan(text: 'I accept the '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = _onPrivacyPolicyTap,
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Terms & Conditions',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = _onTermsConditionsTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
