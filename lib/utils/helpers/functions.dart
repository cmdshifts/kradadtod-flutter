import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FunctionHelpers {
  static void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  static String getBankLogo(int code) {
    switch (code) {
      case 2:
        return "assets/logos/bank/bbl.jpeg";
      case 4:
        return "assets/logos/bank/kbank.png";
      default:
        return "assets/logos/app.svg";
    }
  }

  static Future<Map<String, dynamic>> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    final identity = prefs.getString("identity");
    final password = prefs.getString("password");
    return {"identity": identity, "password": password};
  }

  static Future<void> setLoginData(String id, String pwd) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("identity", id);
    prefs.setString("password", pwd);
  }

  static Future<bool> hasLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.containsKey("identity") && prefs.containsKey("password"));
  }

  static String hashWithSHA256(String password) {
    List<int> bytes = utf8.encode(password);

    Digest digest = sha256.convert(bytes);

    String hashedString = digest.toString();

    return hashedString;
  }
}
