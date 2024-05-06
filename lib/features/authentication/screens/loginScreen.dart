import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kradadtod/features/authentication/screens/registerScreen.dart';
import 'package:kradadtod/navigation.dart';
import 'package:kradadtod/utils/constants/sizes.dart';
import 'package:kradadtod/utils/helpers/functions.dart';
import 'package:kradadtod/utils/http/httpClient.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  String? username;
  String? password;

  handleLogin() async {
    if (username == null || password == null) {
      Fluttertoast.showToast(
        msg: "Field cannot be empty!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.grey.shade100.withOpacity(0.7),
        textColor: Colors.black,
        fontSize: 16.0,
      );
    } else {
      KAppHttpHelper.get("auth?identity=$username&password=$password")
          .then((value) => {
                if (value['message'] != null)
                  {
                    Fluttertoast.showToast(
                      msg: value['message'],
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.SNACKBAR,
                      backgroundColor: Colors.grey.shade100.withOpacity(0.7),
                      textColor: Colors.black,
                      fontSize: 16.0,
                    )
                  }
                else if (value['username'] != null)
                  {
                    FunctionHelpers.setLoginData(username!, password!),
                    Navigator.of(context).pushReplacement(PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const Navigation(),
                    ))
                  }
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KAppSizes.xl),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/logos/app.svg",
                width: 120,
                height: 120,
              ),
              const SizedBox(
                height: 80.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Username / E-mail",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: KAppSizes.sm,
                  ),
                  TextField(
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 0),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(KAppSizes.md),
                        child: const Icon(FluentIcons.mention_16_regular),
                      ),
                      hintText: "Username",
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onChanged: (value) {
                      username = value;
                    },
                  ),
                  const SizedBox(
                    height: KAppSizes.sm,
                  ),
                  Text(
                    "Password",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: KAppSizes.sm,
                  ),
                  TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 0),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(KAppSizes.md),
                        child: const Icon(FluentIcons.password_16_regular),
                      ),
                      hintText: "Password",
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onChanged: (value) {
                      password = FunctionHelpers.hashWithSHA256(value);
                    },
                  ),
                  const SizedBox(
                    height: KAppSizes.lg,
                  ),
                  TextButton(
                    onPressed: handleLogin,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      disabledBackgroundColor: Colors.black.withOpacity(0.5),
                      disabledForegroundColor: Colors.white,
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: KAppSizes.lg,
                  ),
                  TextButton(
                    onPressed: () {
                      FunctionHelpers.navigateTo(
                          context, const RegisterScreen());
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      disabledBackgroundColor: Colors.black.withOpacity(0.1),
                      disabledForegroundColor: Colors.black,
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Register",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
