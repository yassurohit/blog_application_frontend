import 'dart:convert';
import 'package:blog_flutter/auth/send_otp_api.dart';
import 'package:blog_flutter/auth/verify_otp.dart';
import 'package:blog_flutter/helpers/sharedPref_helper.dart';
import 'package:blog_flutter/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  _State createState() => _State();
}

class _State extends State<OTPPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  Color backgroundColor1 = const Color(0xFFF1F1F1);
  Color backgroundColor2 = const Color(0xFFF1F1F1);
  String _email = '';
  Color borderColor1 = const Color(0x7F484848);
  Color borderColor2 = const Color(0x7F484848);
  bool isPasswordVisible = false;
  bool isOTPSended = false;
  String _otp = '';

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
              if (isOTPSended)
                Padding(
                  padding:
                      EdgeInsets.only(top: screenHeight * 0.0275, left: 24),
                  child: const Text(
                    'Enter OTP',
                    style: TextStyle(
                      color: Color(0xFF2C2C2C),
                      fontSize: 16,
                      fontFamily: 'Satoshi Variable',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              if (isOTPSended)
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
                      controller: otpController,
                      onChanged: (otp) {
                        setState(() {
                          _otp = otp;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            top: 0.0,
                            bottom: screenHeight * 0.00625,
                            left: 8.0),
                        border: InputBorder.none,
                        hintText: 'Enter OTP',
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
                padding: EdgeInsets.only(
                    left: 24, top: (screenHeight - notifi) * 0.120, right: 24),
                child: SizedBox(
                  width: screenWidth,
                  height: (screenHeight - notifi) * 0.05,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: _email.isNotEmpty
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
                      if (!isOTPSended) {
                        sendOtp(_email);
                      } else {
                        bool isSuccess = await verifyOTP(_email, _otp);
                        if (isSuccess) {
                          if (mounted) {
                            context.push('/blog');
                          }
                        }
                      }
                    },
                    child: Text(
                      isOTPSended ? 'verify OTP' : 'Send OTP',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> sendOtp(String email) async {
    bool isLoginSuccess = false;
    if (!isValidEmail(email)) {
      ToastUtils.showToast('Please enter valid email');
      return false;
    }
    print("before Calling api");
    List<dynamic> response = await sendOTPApiCall(email);
    print("after Calling api");
    if (response[0]) {
      isLoginSuccess = true;
      setState(() {
        isOTPSended = true;
      });
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

  Future<bool> verifyOTP(String email, String otp) async {
    bool isLoginSuccess = false;
    if (!isValidEmail(email)) {
      ToastUtils.showToast('Please enter valid email');
      return false;
    }
    List<dynamic> response = await verifyOTPApicall(email, otp);
    if (response[0]) {
      isLoginSuccess = true;
      setState(() {
        isOTPSended = true;
      });
      var responseJson = response[1];
      String token = responseJson['access'];
      String email = responseJson['email'];
      print("email:$email");
      print("token:$token");
      SharedPrefsHelper().saveString('token', token);
      SharedPrefsHelper().saveString('email', email);
      ToastUtils.showToast('Successfully Logged In');
    } else {
      ToastUtils.showToast('Invalid Credentials.Failed to Login');
    }
    return isLoginSuccess;
  }
}
