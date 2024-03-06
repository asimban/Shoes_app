import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oxyboots/appfunctions/customtextformfield.dart';
import 'package:oxyboots/auth/signup_page.dart';
import 'package:oxyboots/ui/home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  dynamic size, height, width;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Hello Again!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 50,),
                  const Row(
                    children: [
                      Text(
                        "Email Address",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  CustomTextFormField(
                    controller: emailController,
                    validator: (input) =>
                    input!.isValidEmail() ? null : "example@gmail.com",
                    hintText: "Enter Your Email",
                  ),
                  const SizedBox(height: 30,),
                  const Row(
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  CustomTextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please Enter Password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    hintText: "Enter your password",
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.visibility),
                    ),
                  ),
                  const SizedBox(height: 10,), // Added space
                  const SizedBox(height: 40,),
                  GestureDetector(
                    onTap: isLoading
                        ? null
                        : () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: emailController.text.toString(),
                          password: passwordController.text.toString(),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Homepage(),
                          ),
                        );
                        setState(() {
                          isLoading = false;
                        });
                      } on FirebaseAuthException catch (e) {
                        String errorMessage =
                            "Incorrect password or Email not found. Please try again.";

                        switch (e.code) {
                          case 'user-not-found':
                            errorMessage =
                            "Email not found. Please check your email.";
                            break;
                          case 'wrong-password':
                            errorMessage =
                            "Incorrect password. Please try again.";
                            break;
                          case 'network-request-failed':
                            errorMessage =
                            "Please check your internet connection and try again.";
                            break;
                          default:
                            print("Unhandled authentication error: $e");
                            break;
                        }

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Sign-In Failed"),
                              content: Text(errorMessage),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                        setState(() {
                          isLoading = false;
                        });
                      } catch (e) {
                        print("Unhandled error: $e");
                      }
                    },
                    child: Container(
                      height: height / 15,
                      width: width / 1,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: isLoading
                            ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        )
                            : const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Container(
                    height: height / 15,
                    width: width / 1,
                    color: Colors.white,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/google.png"),
                          const Text("Sign in with Google"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Sign Up for free",
                        style: TextStyle(
                          color: Color(0xff5B9EE1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
