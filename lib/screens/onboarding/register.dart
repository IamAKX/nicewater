import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:nice_water/screens/onboarding/login.dart';
import 'package:nice_water/services/auth_provider.dart';
import 'package:nice_water/widgets/input_field_dark.dart';
import 'package:nice_water/widgets/primary_button.dart';
import 'package:provider/provider.dart';

import '../../services/snakbar_service.dart';
import '../../utils/theme.dart';
import '../../widgets/gaps.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routePath = '/registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
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
                  'Nice to\nmeet you 🙋',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                verticalGap(defaultPadding * 1.5),
                InputFieldDark(
                  hint: 'Name',
                  controller: _nameCtrl,
                  keyboardType: TextInputType.name,
                  obscure: false,
                  icon: LineAwesomeIcons.user,
                ),
                verticalGap(defaultPadding),
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
                        .registerUserWithEmailAndPassword(
                            _nameCtrl.text, _emailCtrl.text, _passwordCtrl.text)
                        .then((value) {
                      if (value) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            LoginScreen.routePath, (route) => false);
                      }
                    });
                  },
                  label: 'Register',
                  isDisabled: _auth.status == AuthStatus.authenticating,
                  isLoading: _auth.status == AuthStatus.authenticating,
                ),
                verticalGap(defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginScreen.routePath,
                          (route) => false,
                        );
                      },
                      child: Text(
                        'Have an account? Login',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ),
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
