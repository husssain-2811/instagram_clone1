import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
// import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signupUser() async {
    setState(
      () {
        _isLoading = true;
      },
    );
    String res = await AuthMethods().SignupUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    if (res != 'Signup Successful!!') {
      showSnackBar(res, context);
      setState(
        () {
          _isLoading = false;
        },
      );
    } else {
      Get.to(
        const ResponsiveLayout(
          webScreenLayout: WebScreenLayout(),
          mobileScreenLayout: MobileScreenLayout(),
        ),
      );
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const ResponsiveLayout(
      //         webScreenLayout: WebScreenLayout(),
      //         mobileScreenLayout: MobileScreenLayout()),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 500,
            child: Column(
              children: [
                Flexible(
                  // Replace Expanded with Flexible
                  fit: FlexFit.loose, // Set fit to FlexFit.loose
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(flex: 2, child: Container()),
                          const SizedBox(height: 12), // Spacer
                          Image.asset(
                            'assets/images/logo_name.png',
                            height: 100,
                          ),
                          const SizedBox(height: 5),
                          Stack(
                            children: [
                              if (_image == null)
                                const CircleAvatar(
                                  radius: 54,
                                  backgroundImage:
                                      AssetImage('assets/images/logo.png'),
                                )
                              else
                                CircleAvatar(
                                  radius: 54,
                                  backgroundImage: MemoryImage(_image!),
                                ),
                              Positioned(
                                bottom: -10,
                                left: 60,
                                child: IconButton(
                                  onPressed: () {
                                    selectImage();
                                  },
                                  icon: const Icon(Icons.add_a_photo),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextFieldInput(
                            hintText: 'Enter your Username',
                            textEditingController: _usernameController,
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(height: 12),
                          TextFieldInput(
                            hintText: 'Enter your email',
                            textEditingController: _emailController,
                            textInputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 12),
                          TextFieldInput(
                            hintText: 'Enter your password',
                            textInputType: TextInputType.text,
                            textEditingController: _passwordController,
                            isPass: true,
                          ),
                          const SizedBox(height: 12),
                          TextFieldInput(
                            hintText: 'Enter your bio',
                            textEditingController: _bioController,
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(height: 12),
                          InkWell(
                            onTap: () => signupUser(),
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: const ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                color: Colors.blue,
                              ),
                              child: _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: primaryColor,
                                      ),
                                    )
                                  : const Text('Sign up'),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: const Text('Already have an account?'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    const LoginScreen(),
                                  );
                                  // Navigator.of(context).pushReplacement(
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const LoginScreen(),
                                  //   ),
                                  // );
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: const Text(
                                    ' Login',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Flexible(flex: 2, child: Container()), // Spacer
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
