import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kradadtod/utils/helpers/functions.dart';
import 'package:kradadtod/utils/http/httpClient.dart';
import '../../../common/widgets/appBar/commonAppBar.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AccountState();
}

class _AccountState extends State<AccountScreen> {
  Future<dynamic>? _userData;
  String? email;
  String? displayName;

  @override
  void initState() {
    super.initState();
    _checkIsLoggedIn();
  }

  _checkIsLoggedIn() async {
    if (await FunctionHelpers.hasLoginData()) {
      final data = await FunctionHelpers.getLoginData();
      if (data['identity'] != null && data['password'] != null) {
        String id = data['identity'];
        String password = data['password'];

        final res =
            await KAppHttpHelper.get("auth?identity=$id&password=$password");
        _userData = Future.value(res);
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: _userData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final response = snapshot.data;
                  return CommonAppBar(
                    showBackArrow: false,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: KAppColors.azure,
                              radius: KAppSizes.profileBorder,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/user.png'),
                                radius: KAppSizes.profileImage,
                              ),
                            ),
                            const SizedBox(width: KAppSizes.defaultSpace),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  response['displayName'],
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  "@" + response["username"],
                                  style: Theme.of(context).textTheme.labelSmall,
                                )
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(FluentIcons.settings_28_regular),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return CommonAppBar(
                    showBackArrow: false,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: KAppColors.azure,
                              radius: KAppSizes.profileBorder,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/user.png'),
                                radius: KAppSizes.profileImage,
                              ),
                            ),
                            const SizedBox(width: KAppSizes.defaultSpace),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Please login!",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(FluentIcons.settings_28_regular),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: KAppSizes.xl, vertical: KAppSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Edit your account",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: KAppSizes.md,
                  ),
                  FutureBuilder(
                    future: _userData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final response = snapshot.data;

                        TextEditingController? _usernameController;
                        TextEditingController? _emailController;
                        TextEditingController? _displayNameController;

                        if (response['username'] != null) {
                          _usernameController =
                              TextEditingController(text: response['username']);
                        }

                        if (response['email'] != null) {
                          _emailController =
                              TextEditingController(text: response['email']);
                        }

                        if (response['displayName'] != null) {
                          _displayNameController = TextEditingController(
                              text: response['displayName']);
                        }

                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(KAppSizes.lg),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Username",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(
                                  height: KAppSizes.sm,
                                ),
                                TextField(
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 0),
                                    prefixIcon: Container(
                                      padding:
                                          const EdgeInsets.all(KAppSizes.md),
                                      child: const Icon(
                                          FluentIcons.mention_16_regular),
                                    ),
                                    hintText: "Username",
                                    enabled: response["username"] != null
                                        ? false
                                        : true,
                                    hintStyle:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                const SizedBox(
                                  height: KAppSizes.md,
                                ),
                                Text(
                                  "E-mail",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(
                                  height: KAppSizes.sm,
                                ),
                                TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 0),
                                    prefixIcon: Container(
                                      padding:
                                          const EdgeInsets.all(KAppSizes.md),
                                      child: const Icon(
                                          FluentIcons.mail_inbox_16_regular),
                                    ),
                                    hintText: "E-mail",
                                    hintStyle:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  onChanged: (value) {
                                    email = value;
                                  },
                                ),
                                const SizedBox(
                                  height: KAppSizes.md,
                                ),
                                Text(
                                  "Display Name",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(
                                  height: KAppSizes.sm,
                                ),
                                TextField(
                                  controller: _displayNameController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 0),
                                    prefixIcon: Container(
                                      padding:
                                          const EdgeInsets.all(KAppSizes.md),
                                      child: const Icon(
                                          FluentIcons.draw_text_20_regular),
                                    ),
                                    hintText: "Display Name",
                                    hintStyle:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  onChanged: (value) {
                                    displayName = value;
                                  },
                                ),
                                const SizedBox(
                                  height: KAppSizes.md,
                                ),
                                TextButton(
                                  onPressed: () {
                                    final userObject = <String, dynamic>{
                                      'username': response['username']
                                    };

                                    if (displayName != null) {
                                      userObject['displayName'] = displayName;
                                    }

                                    if (email != null) {
                                      userObject['email'] = email;
                                    }

                                    KAppHttpHelper.put("user", userObject)
                                        .then((_) => {
                                              Fluttertoast.showToast(
                                                msg: "Successfully updated!",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.SNACKBAR,
                                                backgroundColor: Colors
                                                    .grey.shade100
                                                    .withOpacity(0.7),
                                                textColor: Colors.black,
                                                fontSize: 16.0,
                                              )
                                            });
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    disabledBackgroundColor:
                                        Colors.black.withOpacity(0.5),
                                    disabledForegroundColor: Colors.white,
                                  ),
                                  child: const SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Update",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
