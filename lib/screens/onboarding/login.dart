import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:nice_water/screens/home_container/home_container.dart';
import 'package:nice_water/screens/onboarding/reset_password.dart';
import 'package:nice_water/services/auth_provider.dart';
import 'package:nice_water/utils/theme.dart';
import 'package:provider/provider.dart';

import '../../services/snakbar_service.dart';
import '../../widgets/gaps.dart';
import '../../widgets/input_field_dark.dart';
import '../../widgets/primary_button.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routePath = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  bool hidePassword = true;
  late AuthProvider _auth;
  togglePasswordVisibility() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor,
            Colors.blue,
          ],
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
                vertical: defaultPadding,
              ),
              children: [
                verticalGap(defaultPadding * 1.5),
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                verticalGap(defaultPadding),
                Text(
                  'Welcome\nBack 🤗',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                verticalGap(defaultPadding * 1.5),
                InputFieldDark(
                  hint: 'Email',
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  obscure: false,
                  icon: LineAwesomeIcons.at,
                ),
                verticalGap(defaultPadding),
                InputFieldDark(
                  hint: 'Password',
                  controller: _passwordCtrl,
                  keyboardType: TextInputType.visiblePassword,
                  obscure: hidePassword,
                  icon: LineAwesomeIcons.lock,
                  togglePassword: togglePasswordVisibility,
                ),
                verticalGap(defaultPadding * 2),
                PrimaryButton(
                  onPressed: () {
                    _auth
                        .loginUserWithEmailAndPassword(
                            _emailCtrl.text, _passwordCtrl.text)
                        .then((value) {
                      if (value) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            HomeContainer.routePath, (route) => false);
                      }
                    });
                  },
                  label: 'Login',
                  isDisabled: _auth.status == AuthStatus.authenticating,
                  isLoading: _auth.status == AuthStatus.authenticating,
                ),
                verticalGap(defaultPadding),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeContainer.routePath, (route) => false);
                  },
                  child: Text(
                    'Login as Guest',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                verticalGap(defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, RegisterScreen.routePath);
                      },
                      child: Text(
                        'Register',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      color: Colors.white,
                      width: 2,
                      height: 15,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, ResetPasswordScreen.routePath);
                      },
                      child: Text(
                        'Reset Password',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
