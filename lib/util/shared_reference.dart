import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedRefrence {
  void setSignIn(bool val) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("login", val);
  }

  saveIsocode({key, data}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, data);
  }

  Future<String> getIsocode({key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String countryIsocode = preferences.getString(key) ?? "";
    return countryIsocode;
  }

  saveCountryId({key, data}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, data);
  }

  Future<String> getCountryId({key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String countryIsocode = preferences.getString(key) ?? "";
    return countryIsocode;
  }

  saveCurrencyCode({key, data}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, data);
  }

  getCurrencyCode({key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String countryIsocode = preferences.getString(key) ?? "";
    return countryIsocode;
  }

  Future<bool> getSignIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool login = preferences.getBool("login") ?? false;
    return login;
  }

  saveFirstName({key, firstName}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, firstName);
  }

  Future<String> getFirstName({key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String login = preferences.getString(key) ?? "";
    return login;
  }

  saveLastName({key, lastName}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, lastName);
  }

  Future<String> getLastName({key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String login = preferences.getString(key) ?? "";
    return login;
  }

  savephoneNumber({key, phoneNumber}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, phoneNumber);
  }

  Future<String> getphoneNumber({key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String login = preferences.getString(key) ?? "";
    return login;
  }

  saveSpendEachMonth({key, spendEachMonth}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, spendEachMonth);
  }

  Future<String> getSpendEachMonth({key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String login = preferences.getString(key) ?? "";
    return login;
  }

  saveString({key, data}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (data != null) {
      await preferences.setString(key, data);
    } else {}
  }

  Future<String?> getString({key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? login = preferences.getString(key);
    return login;
  }

  void clearPrefs({key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  void setIntro(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("intro", val);
    Get.rawSnackbar(
      message: "Welcome",
      duration: Duration(seconds: 1),
      backgroundColor: Colors.blue,
      isDismissible: true,
    );
  }
}
