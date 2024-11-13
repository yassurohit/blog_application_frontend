import 'dart:convert';

import 'package:blog_flutter/auth/login_api.dart';
import 'package:blog_flutter/helpers/sharedPref_helper.dart';
import 'package:blog_flutter/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Color backgroundColor1 = const Color(0xFFF1F1F1);
  Color backgroundColor2 = const Color(0xFFF1F1F1);
  String _email = '';
  String _password = '';
  Color borderColor1 = const Color(0x7F484848);
  Color borderColor2 = const Color(0x7F484848);
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double notifi = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 180.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'Blog App',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF2C2C2C),
                          fontSize: screenHeight * 0.0192,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0.05,
                          letterSpacing: 0.15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.09725, left: 24, right: 24),
                child: const Text(
                  'Email ID',
                  style: TextStyle(
                    color: Color(0xFF2C2C2C),
                    fontSize: 16,
                    fontFamily: 'Satoshi Variable',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: screenHeight * 0.005,
                ),
                child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.055,
                  decoration: ShapeDecoration(
                    color: backgroundColor1,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.visiblePassword,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(32),
                      FilteringTextInputFormatter.deny(' '),
                      FilteringTextInputFormatter.singleLineFormatter,
                    ],
                    onChanged: (Emailtext) {
                      setState(() {
                        _email = Emailtext;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 0.0, bottom: screenHeight * 0.00625, left: 8.0),
                      border: InputBorder.none,
                      hintText: 'abcd.1@gmail.com',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFF939393).withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.0275, left: 24),
                child: const Text(
                  'Password',
                  style: TextStyle(
                    color: Color(0xFF2C2C2C),
                    fontSize: 16,
                    fontFamily: 'Satoshi Variable',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.005, left: 24, right: 24),
                child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.055,
                  decoration: ShapeDecoration(
                    color: backgroundColor2,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFF888888)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: TextField(
                    obscureText: !isPasswordVisible,
                    controller: passwordController,
                    onChanged: (passwordText) {
                      setState(() {
                        _password = passwordText;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: screenHeight * 0.005,
                          bottom: screenHeight * 0.005,
                          left: 8.0),
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFF939393).withOpacity(0.8),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 24, top: (screenHeight - notifi) * 0.120, right: 24),
                child: SizedBox(
                  width: screenWidth,
                  height: (screenHeight - notifi) * 0.05,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: _email.isNotEmpty && _password.isNotEmpty
                          ? MaterialStateProperty.all(
                              const Color.fromRGBO(1, 0, 0, 1))
                          : MaterialStateProperty.all(
                              const Color(0xFF9B9B9B)), // Disabled state color
                      minimumSize:
                          MaterialStateProperty.all(const Size(313, 50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(6.0)), // Sharp edges
                        ),
                      ),
                    ),
                    onPressed: () async {
                      bool isLoginSuccess = await _login(_email, _password);
                      if (isLoginSuccess) {
                        context.go('/blog');
                      }
                    },
                    child: const Text(
                      'Sign in',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Satoshi Variable',
                        fontWeight: FontWeight.w500,
                        height: 0.10,
                        letterSpacing: 0.14,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      context.push('/otp-page');
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Center(
                        child: Text(
                          'Login with OTP',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 14,
                            fontFamily: 'Satoshi Variable',
                            fontWeight: FontWeight.w500,
                            height: 0.10,
                            letterSpacing: 0.14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      context.push('/signup');
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Center(
                        child: Text(
                          'Sign up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                            fontFamily: 'Satoshi Variable',
                            fontWeight: FontWeight.w500,
                            height: 0.10,
                            letterSpacing: 0.14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _login(String email, String password) async {
    bool isLoginSuccess = false;
    if (!isValidEmail(email) || password.isEmpty) {
      ToastUtils.showToast('Please enter valid details');
      return false;
    }
    print("before Calling api");
    List<dynamic> response = await loginApiCall(email, password);
    print("after Calling api");
    if (response[0]) {
      isLoginSuccess = true;
      String responseJson = response[1];
      var jsonResponse = json.decode(responseJson);
      String token = jsonResponse['access'];
      SharedPrefsHelper().saveString('token', token);
      ToastUtils.showToast('Successfully Logged In');
    } else {
      ToastUtils.showToast('Invalid Credentials.Failed to Login');
    }
    return isLoginSuccess;
  }
}
