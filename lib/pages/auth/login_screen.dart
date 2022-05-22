import 'package:final_food_project/controllers/fb_auth_controller.dart';
import 'package:final_food_project/navigator.dart';
import 'package:final_food_project/pages/auth/create_account_screen.dart';
import 'package:final_food_project/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 0,
        title: const Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsetsDirectional.all(20),
        color: Colors.white,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: AlignmentDirectional.topStart,
        //     end: AlignmentDirectional.bottomEnd,
        //     colors: [
        //       Colors.blue.shade900,
        //       Colors.blue.shade300,
        //     ],
        //   ),
        // ),
        child: SafeArea(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 300,
                child:
                    Lottie.asset('assets/lottie/105631-jurupoles-login.json'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailTextController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'Email',
                  fillColor: Colors.white,
                  hintStyle: TextStyle(
                    color: Colors.black45,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _passwordTextController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  hintStyle: TextStyle(
                    color: Colors.black45,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  await performLogin();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                  // primary: Colors.white,
                ),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // ElevatedButton(
              //   onPressed: () {
              //     Get.offAll(
              //       CreateAccountScreen(),
              //       transition: Transition.fadeIn,
              //       duration: const Duration(seconds: 1),
              //     );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     minimumSize: const Size(double.infinity, 45),
              //     // primary: Colors.white,
              //   ),
              //   child: const Text(
              //     'CREATE ACCOUNT',
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await resetPassword();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                  // primary: Colors.white,
                ),
                child: const Text(
                  'RESET PASSWORD',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offAll(
                        CreateAccountScreen(),
                        transition: Transition.leftToRight,
                        duration: const Duration(seconds: 1),
                      );
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
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

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Enter required data!', error: true);
    return false;
  }

  Future<void> login() async {
    bool status = await FbAuthController().signIn(context,
        email: _emailTextController.text,
        password: _passwordTextController.text);
    if (status) {
      Get.to(MainNavigator());
    }
  }

  Future<void> resetPassword() async {
    bool status =
        await FbAuthController().passwordReset(_emailTextController.text);
    if (status) {
      showSnackBar(context, message: 'Password reset email sent successfully');
    }
  }
}
