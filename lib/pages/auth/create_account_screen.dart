import 'package:final_food_project/controllers/fb_auth_controller.dart';
import 'package:final_food_project/pages/auth/login_screen.dart';
import 'package:final_food_project/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with Helpers {
  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameTextController.dispose();
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
        elevation: 0,
        title: const Text(
          'CREATE ACCOUNT',
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
                child: Lottie.asset('assets/lottie/register.json'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameTextController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Name',
                  fillColor: Colors.white,
                  hintStyle: const TextStyle(
                    color: Colors.black45,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _emailTextController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
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
                style: const TextStyle(color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  hintStyle: const TextStyle(
                    color: Colors.black45,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  await performCreateAccount();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text(
                  'CREATE',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              // const SizedBox(height: 10),
              // ElevatedButton(
              //   onPressed: () {
              //     Get.offAll(
              //       LoginScreen(),
              //       transition: Transition.zoom,
              //       duration: const Duration(seconds: 1),
              //     );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     minimumSize: const Size(double.infinity, 45),
              //   ),
              //   child: const Text(
              //     'LOGIN',
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Do you already have an account ?',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offAll(
                        LoginScreen(),
                        transition: Transition.zoom,
                        duration: const Duration(seconds: 1),
                      );
                    },
                    child: const Text(
                      'Sign in',
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

  Future<void> performCreateAccount() async {
    if (checkData()) {
      await createAccount();
    }
  }

  bool checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Enter required data!', error: true);
    return false;
  }

  Future<void> createAccount() async {
    bool status = await FbAuthController().createAccount(
      context,
      name: _nameTextController.text,
      email: _emailTextController.text,
      password: _passwordTextController.text,
    );
    if (status) {
      showSnackBar(context, message: 'Created Successfully');
    }
  }
}
