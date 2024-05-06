import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kradadtod/common/widgets/appBar/commonAppBar.dart';
import 'package:kradadtod/utils/http/httpClient.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/functions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  String? username;
  String? displayName;
  String? email;
  String? password;
  String? confirmPassword;

  void handleRegister() {
    if (username != null ||
        displayName != null ||
        email != null ||
        password != null ||
        confirmPassword != null) {
      if (password != confirmPassword) {
        Fluttertoast.showToast(
          msg: "Password does not matched!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.grey.shade100.withOpacity(0.7),
          textColor: Colors.black,
          fontSize: 16.0,
        );
      } else {
        Map<String, dynamic> userData = {
          'username': username,
          'email': email,
          'profileUrl': null,
          'displayName': displayName,
          'password': password,
        };

        KAppHttpHelper.post("user", userData)
            .then((_) => Navigator.pop(context));
      }
    } else {
      Fluttertoast.showToast(
        msg: "Input invalid!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.grey.shade100.withOpacity(0.7),
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CommonAppBar(
                showBackArrow: true,
                title: Text("Register"),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
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
                          child: const Icon(FluentIcons.person_16_regular),
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
                      "Display Name",
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
                          child: const Icon(
                              FluentIcons.credit_card_person_20_regular),
                        ),
                        hintText: "Display Name",
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onChanged: (value) {
                        displayName = value;
                      },
                    ),
                    const SizedBox(
                      height: KAppSizes.sm,
                    ),
                    Text(
                      "E-mail",
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
                        hintText: "E-mail",
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onChanged: (value) {
                        email = value;
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
                      height: KAppSizes.sm,
                    ),
                    Text(
                      "Confirm Password",
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
                        hintText: "Confirm Password",
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onChanged: (value) {
                        confirmPassword = FunctionHelpers.hashWithSHA256(value);
                      },
                    ),
                    const SizedBox(
                      height: KAppSizes.lg,
                    ),
                    TextButton(
                      onPressed: handleRegister,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        disabledBackgroundColor: Colors.black.withOpacity(0.5),
                        disabledForegroundColor: Colors.white,
                      ),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Register",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
