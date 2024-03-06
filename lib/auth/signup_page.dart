import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:oxyboots/appfunctions/custom_button.dart';
import 'package:oxyboots/appfunctions/customtextformfield.dart';
import 'package:oxyboots/auth/signIn-page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  dynamic size,height,width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Create Account",style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600
                  ),),
                  const SizedBox(height: 50,),
                  const Row(
                    children: [
                      Text("Your Name",style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),),

                    ],

                  ),
                  const SizedBox(height: 10,),
                  CustomTextFormField(

                    validator: MinLengthValidator(4, errorText: "Please Enter Name"),
                    hintText: "Enter Your Name",
                    controller: nameController,
                  ),
                  const SizedBox(height: 30,),
                  const Row(
                    children: [
                      Text("Email Address",style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),),

                    ],

                  ),
                  const SizedBox(height: 10,),
                  CustomTextFormField(
                      validator: (input) =>
                      input!.isValidEmail() ? null : "example@gmail.com",
                    controller: emailController,
                    hintText: "Enter your Email"
                  ),
                  const SizedBox(height: 30,),
                  const Row(
                    children: [
                      Text("Password",style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),),

                    ],

                  ),
                  const SizedBox(height: 10,),
                  CustomTextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please Enter Password';
                      } else if (val.length < 8) {
                        return "Password must be atleast 8 characters long";
                      }
                      return null;
                    },
                    controller: passwordController,
                    hintText: "Enter your password",
                    suffixIcon: IconButton(
                        onPressed: (){

                        },
                        icon: const Icon(Icons.visibility)
                    ),
                  ),
                  const SizedBox(height: 50,),
                  CustomButton(buttonText: "Sign up",
                      onPressed: () async {
                        if(!formKey.currentState!.validate()){
                          return;
                        }
                        try{
                           FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: emailController.text.toString(),
                            password: passwordController.text.toString(),
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInPage()));

                        } catch (e) {
                          print("..........error$e");
                        }
                  }
                  ),
                  const SizedBox(height: 30,),
                  Container(
                    height:height/15 ,
                    width: width/1,
                    color: Colors.white,
                    child:   Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/google.png"),
                        const Text("Sign in with Google"),

                      ],
                    )),

                  ),
                  const SizedBox(height: 30,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?",style: TextStyle(
                        color: Colors.grey,
                      ),),
                      InkWell(
                        child: const Text("Sign in",style: TextStyle(
                          color: Color(0xff5B9EE1),
                        )
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInPage()));
                        },
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
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
