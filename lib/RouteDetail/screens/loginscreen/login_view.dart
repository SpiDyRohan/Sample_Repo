import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_sample/RouteDetail/screens/loginscreen/login_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:http/http.dart' as http;

import '../../routes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;
  final controller = Get.put(LoginController());

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _password = "6000ac4bc22ce6ea4adcae78b0ff87412d05e4c35912c38a740ff6db659";
      var response = await http.post(
        Uri.parse('https://apiv2stg.promilo.com/user/oauth/token'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body:
            'email=$_email&password=${_sha256(_password)}&grant_type=password',
      );
      print("response " + response.body);
      if (response.statusCode == 200) {
        // API call successful, handle response
      } else {
        // API call failed, display error message
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Invalid ID Password'),
              actions: [
                ElevatedButton(
                  child: Text('OK'),
                  onPressed: () {
                    Get.toNamed(Routes.secondScreen);
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  String _sha256(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text("Promilo"),
                  SizedBox(
                    height: 50,
                  ),
                  Text("Hi! Welcome Back",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Please Sign in to Continue ")),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black45)),
                    child: TextFormField(
                      controller: controller.emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                      onChanged: (value) {
                        if (value.length > 0) {
                          controller.isemailFilled.value = true;
                        } else {
                          controller.isemailFilled.value = false;
                        }
                      },
                      decoration: InputDecoration(
                          hintText: 'Email', border: InputBorder.none),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Sign in with OTP",
                        style: TextStyle(color: Color(0xFF4472c4)),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Align(alignment: Alignment.centerLeft, child: Text("Password")),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black45)),
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length > 0) {
                          controller.isPasswordFilled.value = true;
                        } else {
                          controller.isPasswordFilled.value = false;
                        }
                      },
                      controller: controller.passwordController,
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Please enter your password';
                      //   }
                      //   return null;
                      // },
                      onSaved: (value) {
                        _password = value!;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password', border: InputBorder.none),
                    ),
                  ),
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          activeColor: Colors.grey,
                          value: controller.isChecked.value,
                          onChanged: (value) {
                            controller.isChecked.value =
                                !controller.isChecked.value;
                          },
                        ),
                      ),
                      Text("Remember Me"),
                      Spacer(),
                      Text(
                        "Forget Password",
                        style: TextStyle(color: Color(0xFF4472c4)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      onTap: _login,
                      child: Obx(
                        () => Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 2,
                                color:Color(0xFF4472c4)
                              ),
                              color: controller.isemailFilled.value &&
                                      controller.isPasswordFilled.value
                                  ? Color(0xFF4472c4)
                                  : Color(0xFF4472c4).withOpacity(.5)),
                          child: Center(
                            child: Text("Submit",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 1,
                        width: Get.width / 2.4,
                        color: Colors.black26,
                      ),
                      Text("or"),
                      Container(
                        height: 1,
                        width: Get.width / 2.4,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/google.png",
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "assets/images/linkedin.png",
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "assets/images/facebook.png",
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "assets/images/instagram.png",
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "assets/images/whatsapp.png",
                        height: 30,
                        width: 30,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Business User?"),
                      Text("Don't Have an Account"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Login Here",
                          style: TextStyle(color: Color(0xFF4472c4))),
                      Text("Sign Up", style: TextStyle(color: Color(0xFF4472c4))),
                    ],
                  ),
                  SizedBox(
                    height: Get.height/6.5,
                  ),
                  Text(
                    "By Continuing, you agree to\n Promilo's Terms of use & Privacy Policy",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
