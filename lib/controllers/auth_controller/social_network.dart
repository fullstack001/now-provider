import 'dart:convert';

import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/screens/set_profile_screen.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../models/apple_credentials.dart';

class SocialNetwork extends GetxController {
  final ProfileScreenController _controller =
      Get.put(ProfileScreenController());

  final _storage = const FlutterSecureStorage();

  Future<void> facebookLogin() async {
    try {
      final result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      switch (result.status) {
        case LoginStatus.success:
          final AccessToken accessToken = result.accessToken!;
          print('Logged in!');
          print('Token: ${accessToken.token}');
          print('User id: ${accessToken.userId}');
          print('Expires: ${accessToken.expires}');
          print('Declined permissions: ${accessToken.declinedPermissions}');

          final userData = await FacebookAuth.instance.getUserData();
          print('facebook ${userData.toString()}');

          Get.toNamed(
            SetProfileScreen.id,
            arguments: userData,
          );
          break;
        case LoginStatus.cancelled:
          print('Login cancelled by the user.');
          break;
        case LoginStatus.failed:
          print('Something went wrong with the login process.');
          print('Here\'s the error Facebook gave us: ${result.message}');
          break;
        case LoginStatus.operationInProgress:
          print('Login operation is still in progress.');
          break;
      }
    } catch (exception) {
      Logger().e(exception);
    }
  }

  Future<void> googleLogin() async {
    String countryCode = await SharedRefrence().getCountryId(key: "countryId");
    print("final resulttttttttt:$countryCode");
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          // 'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
      googleSignIn.onCurrentUserChanged
          .listen((GoogleSignInAccount? account) async {
        print("acc:$account");

        if (account != null) {
          Map _body = <String, String>{
            "name": account.displayName!,
            "email": account.email,
            "social_id": account.id,
            "social_type": "google",
            "user_type": "PROVIDER",
            "country_id": countryCode
          };

          _controller.socialSignUp(
            _body,
            // fname: account.displayName.splitBefore(" "),
            // lname: account.displayName.splitAfter(" ")
          );
          await googleSignIn.disconnect();
          // Get.toNamed(
          //   SetProfileScreen.id,
          //   arguments: account,
          // );
        }
      });

      print("adfa");

      var res = await googleSignIn.signIn();
      if (res == null) {
        googleSignIn.disconnect();
      }
      print("");
    } on Exception catch (exception) {
      Logger().e(exception);
    }
  }

  void googleLoginClick() async {
    try {
      GoogleSignIn _googleSignIn = await GoogleSignIn(
        scopes: [
          'email',
          // 'https://www.googleapis.com/auth/userinfo.profile'
          // 'https://www.googleapis.com/auth/contacts.readonly',
          // 'https://www.googleapis.com/auth/userinfo.email',
        ],
      );
      _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
        print("result");
        if (account != null) {
          Map<String, dynamic> body = {
            'name': account.displayName,
            'email': account.email,
            'social_id': account.id,
            'social_type': 'google',
          };
          _controller.socialInfoLogin(body); //todo
        }
      });

      print("adfa");

      var res = await _googleSignIn.signIn();
      if (res == null) {
        _googleSignIn.disconnect();
      }
      print("");
    } on Exception catch (exception) {
      Logger().e(exception);
    }
  }

  void appleLogin() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    var storageData =
        await _storage.read(key: credential.userIdentifier!) ?? "";
    if (storageData.isEmpty) {
      String? givenName = credential.givenName!.toString().capitalizeFirst;
      String? familyName = credential.familyName!.toString().capitalizeFirst;
      String? email = credential.email!;
      String? id = credential.userIdentifier!;
      AppleCredentials cred = AppleCredentials(
        name: "$givenName $familyName",
        email: email,
        id: id,
      );
      var encodedData = json.encode(cred.toJson());
      _storage.write(key: credential.userIdentifier!, value: encodedData);
      await appleLoginToServer(cred.toJson());
    } else {
      var decData = json.decode(storageData);
      _storage.write(key: credential.userIdentifier!, value: storageData);
      // AppleCredentials obj = AppleCredentials.fromJson(decData);
      await appleLoginToServer(decData);
    }
    print("");
  }

  getName(String displayName, type) {
    String fName = displayName.split(" ")[0];
    if (type == "first_name") {
      return fName;
    }
    String lName = displayName.replaceAll("$fName ", "");
    return lName.trim();
  }

  Future<void> appleLoginToServer(decData) async {
    String countryCode = await SharedRefrence().getCountryId(key: "countryId");
    print("");
    Map<String, dynamic> body = {
      "name": decData['name'],
      "email": decData['email'],
      "social_id": decData['id'],
      'social_type': 'apple',
      "country_id": countryCode
    };
    _controller.socialInfoLogin(body); //todo
  }
}
/*
import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

void main() {
  runApp(
    const MaterialApp(
      title: 'Google Sign In',
      home: SignInDemo(),
    ),
  );
}

class SignInDemo extends StatefulWidget {
  const SignInDemo({Key? key}) : super(key: key);

  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
    json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
     var res = await _googleSignIn.signIn();
      print("");
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          Text(_contactText),
          ElevatedButton(
            onPressed: _handleSignOut,
            child: const Text('SIGN OUT'),
          ),
          ElevatedButton(
            child: const Text('REFRESH'),
            onPressed: () => _handleGetContact(user),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            onPressed: _handleSignIn,
            child: const Text('SIGN IN'),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}
com.app.farenowprovider
You16:48
com.farenow.provider
You16:52
0eajj50Ng1x6VhnsIF5TOUZuEeE=
Aurangzaib Rana17:00
9D:32:CE:AA:11:22:D6:F7:D4:41:1B:1E:9F:6C:BC:31:53:C9:C9:25
You17:05
nTLOqhEi1vfUQRsen2y8MVPJySU=
Aurangzaib Rana17:08
3ed06e64c53da422687016adfd3c0ad2
You17:13
com.comp.farenow
Aurangzaib Rana17:13
2613248358812200
Aurangzaib Rana17:16
56:8C:A5:B1:D5:B4:6B:E1:11:BA:DE:B7:65:7E:DE:48:D1:7C:1E:44
You17:17
VoylsdW0a+ERut63ZX7eSNF8HkQ=
com.app.farenow
Aurangzaib Rana17:19
a6d7be189daba5af8690be8e5ab76c01
 */
