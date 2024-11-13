import 'dart:convert';

import 'package:blog_flutter/auth/signup_api.dart';
import 'package:blog_flutter/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isDataEntered = false;
  bool _isPasswordVisible = false;
  Color backgroundColor1 = const Color(0xFFF1F1F1);
  Color backgroundColor2 = const Color(0xFFF1F1F1);
  Color backgroundColor3 = const Color(0xFFF1F1F1);
  Color borderColor1 = const Color(0x7F484848);
  Color borderColor2 = const Color(0x7F484848);
  Color borderColor3 = const Color(0x7F484848);
  String email = '';
  String username = '';
  String password = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double notifi = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 78.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 80,
                    ),
                    child: Text(
                      'Blog App',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF2C2C2C),
                        fontSize: 15.36,
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
              SizedBox(height: screenHeight * 0.075),
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.02375, left: 24, right: 24),
                child: const Text(
                  'Email',
                  style: TextStyle(
                    color: Color(0xFF2C2C2C),
                    fontSize: 14,
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
                    color: backgroundColor1,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: borderColor1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (emailtext) {
                      setState(() {
                        email = emailtext;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 0.0, bottom: screenHeight * 0.00625, left: 8.0),
                      border: InputBorder.none,
                      hintText: 'Enter your email',
                      hintStyle: const TextStyle(
                        color: Color(0xFF939393),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02375, left: 24),
                child: const Text(
                  'User name',
                  style: TextStyle(
                    color: Color(0xFF2C2C2C),
                    fontSize: 14,
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
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: borderColor2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: TextField(
                    onChanged: (usernametext) {
                      setState(() {
                        username = usernametext;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 0.0,
                          bottom: screenHeight * 0.00625,
                          left: screenWidth * 0.024),
                      border: InputBorder.none,
                      hintText: 'Username',
                      hintStyle: const TextStyle(
                        color: Color(0xFF939393),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02375, left: 24),
                child: const Text(
                  'Password',
                  style: TextStyle(
                    color: Color(0xFF2C2C2C),
                    fontSize: 14,
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
                    color: backgroundColor3,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: borderColor3,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: TextField(
                    obscureText: !_isPasswordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (passwordtext) {
                      setState(() {
                        password = passwordtext;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 0.0,
                          bottom: screenHeight * 0.00625,
                          left: screenWidth * 0.024),
                      border: InputBorder.none,
                      hintText: 'Enter your password',
                      hintStyle: const TextStyle(
                        color: Color(0xFF939393),
                        fontStyle: FontStyle.italic,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          _isPasswordVisible
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
                    left: 24, top: (screenHeight - notifi) * 0.06, right: 24),
                child: Container(
                  width: screenWidth,
                  height: (screenHeight - notifi) * 0.05,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        isDataEntered
                            ? const Color(0xFF9B9B9B)
                            : const Color(0xFF007AFF),
                      ),
                      minimumSize:
                          MaterialStateProperty.all(const Size(313, 50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      bool isRegisterSuccess =
                          await register(username, email, password);
                      if (isRegisterSuccess) {
                        context.push('/');
                      }
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: Text(
                      'Sign in',
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
        ),
      ),
    );
  }

  Future<bool> register(String username, String email, String password) async {
    bool isRegisterSuccess = false;
    if (!isValidEmail(email) || email.isEmpty || password.isEmpty) {
      ToastUtils.showToast('Please enter valid details');
      return false;
    }
    List<dynamic> response = await signUpApiCall(username, email, password);
    if (response[0]) {
      isRegisterSuccess = true;
      ToastUtils.showToast('Successfully  Created Account');
    } else {
      ToastUtils.showToast('Failed to Create Account');
    }
    return isRegisterSuccess;
  }
}
