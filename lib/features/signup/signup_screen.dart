import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_and_registration/app/bloc_providers/bloc/auth_bloc.dart';
import 'package:login_and_registration/app/bloc_providers/bloc/auth_event.dart';
import 'package:login_and_registration/app/bloc_providers/bloc/auth_state.dart';
import 'package:login_and_registration/app/router/routes.dart';
import 'package:login_and_registration/app/widgets/app_button.dart';
import 'package:login_and_registration/app/widgets/custom_text_form_widget.dart';
import 'package:login_and_registration/app/widgets/privacy_terms_checkbox.dart';
import 'package:login_and_registration/app/widgets/responsive_layout.dart';
import 'package:login_and_registration/utils/constants/assets.dart';
import 'package:login_and_registration/utils/extensions/context_extension.dart';
import 'package:login_and_registration/utils/extensions/theme_extension.dart';
import 'package:login_and_registration/utils/mixins/form_validation.dart';
import 'package:login_and_registration/utils/theme/gap.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> with FormValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isButtonEnabled = false;
  bool _isTermsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return validateEmail(_emailController.text) == null &&
        validateUserName(_nameController.text) == null &&
        validateMobile(_mobileController.text) == null &&
        _isTermsAccepted;
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            RegisterUserEvent(
              email: _emailController.text,
              password: _passwordController.text,
              userName: _nameController.text,
              mobile: _mobileController.text,
            ),
          );

      // _registerUser();
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.white],
              ),
            ),
          ),
          ResponsiveLayout(
            builder: (context, boxWidth, isLargeScreen) {
              return SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: boxWidth),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: theme.spacing.s32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: theme.sizing.s20),
                          Hero(
                            tag: 'logo',
                            child:
                                Image.asset(Assets.logo, width: 40, height: 40),
                          ),
                          Gap.h40,
                          Text(
                            'Welcome 👋🏻',
                            style: theme.textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Let's get started...",
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(.7),
                            ),
                          ),
                          Gap.h32,
                          Form(
                            key: _formKey,
                            onChanged: () {
                              setState(() {
                                _isButtonEnabled = _isFormValid();
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextFormWidget(
                                  controller: _nameController,
                                  labelText: 'Full Name',
                                  hintText: 'Please enter your full name',
                                  textInputAction: TextInputAction.next,
                                  validator: validateUserName,
                                ),
                                CustomTextFormWidget(
                                  controller: _emailController,
                                  labelText: 'Email',
                                  hintText: 'Please enter your email',
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  validator: validateEmail,
                                ),
                                CustomTextFormWidget(
                                  controller: _mobileController,
                                  labelText: 'Mobile',
                                  hintText: 'Please enter your mobile number',
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  validator: validateMobile,
                                ),
                                CustomTextFormWidget(
                                  controller: _passwordController,
                                  labelText: 'Password',
                                  hintText: 'Please enter your password',
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  validator: validatePassword,
                                  obscureText: !_isPasswordVisible,
                                  suffix: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                      iconSize: 20,
                                      padding: EdgeInsets.zero,
                                      onPressed: _togglePasswordVisibility,
                                    ),
                                  ),
                                ),
                                Gap.h16,
                                PrivacyTermsCheckbox(
                                  isTermsAccepted: _isTermsAccepted,
                                  onChanged: (value) {
                                    setState(() {
                                      _isTermsAccepted = value ?? false;
                                      _isButtonEnabled = _isFormValid();
                                    });
                                  },
                                ),
                                Gap.h16,
                                BlocConsumer<AuthBloc, AuthState>(
                                  listener: (context, state) {
                                    if (state is AuthSuccess) {
                                      const LoginRoute()
                                          .pushReplacement(context);
                                    } else if (state is AuthFailure) {
                                      context.snackBarError(state.message);
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is AuthLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    return SizedBox(
                                      width: theme.sizing.s28,
                                      child: AppButton(
                                        onPressed: _isButtonEnabled
                                            ? () => _submitForm(context)
                                            : null,
                                        text: 'Sign Up',
                                        margin: EdgeInsets.all(
                                          theme.spacing.s0,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Gap.h16,
                          InkWell(
                            onTap: () {
                              const LoginRoute().replace(context);
                            },
                            child: Text(
                              "Sign In",
                              style: theme.textTheme.bodyLarge!.copyWith(
                                color: theme.colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
