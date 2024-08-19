import 'package:chating_app/services/auth/login_and_register_firebase.dart';
import 'package:chating_app/custom/input_textfeilds.dart';
import 'package:chating_app/custom/login_button.dart';
import 'package:chating_app/services/backend/userstoring_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  final LoginAndRegisterFirebase _firebaseLogOrReg = LoginAndRegisterFirebase();
  final StoringFirestore _firestore = StoringFirestore();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void signUpOrSignIn(String email, String password, String? confirmPassword) async {
    if (isLogin) {
      if (email.isNotEmpty &&
          email.contains("@") == true &&
          password.isNotEmpty &&
          (password.length > 8)) {
        try {
          _firebaseLogOrReg.loginUser(email, password);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'email-already-in-use') {}
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "The following error occured ${e.code}: ${e.message!}")));
        }
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please enter Valid email address and Password")));
      }
    }
    else {
      if (email.isNotEmpty &&
          email.contains("@") == true &&
          password.isNotEmpty &&
          (password.length > 8) == true &&
          confirmPassword != null &&
          password == confirmPassword) {
        try {
          final registeredUser = await _firebaseLogOrReg.registerUser(email, password);
          if(registeredUser.user != null){
            print("object-1");
            print("object-1");
            print("object-1");
            final docId = registeredUser.user!. uid;
            final data = {
              'email' : registeredUser.user!.email,
              "date" : DateTime.now(),
              'id' : registeredUser.user!.uid,
            };
            await _firestore.setUserDetails(docId, data);
          }
            print("object");
            print("object");
            print("object");
            print("object");
            print("object");
            print("object");
        } on FirebaseAuthException catch (e) {
          print(e.code);
          if (e.code == 'email-already-in-use') {}
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "The following error occured ${e.code}: ${e.message!}")));
        }
      }else {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please enter Valid email address and matching passwords")));
      }
    }
  }
  // try {
  //   if (isLogin) {
  //     if (email.isEmpty ||
  //         email.contains("@") == false && password.isEmpty ||
  //         (password.length < 8) == true) {
  //       ScaffoldMessenger.of(context).clearSnackBars();
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //           content: Text("Please enter Valid email address with @")));
  //     }
  //     _firebaseLogOrReg.loginUser(email, password);
  //   } else {
  //     if (email.isEmpty ||
  //         email.contains("@") == false && password.isEmpty ||
  //         (password.length < 8) == true && confirmPassword == null ||
  //         confirmPassword!.isEmpty ||
  //         !(confirmPassword == password)) {
  //       ScaffoldMessenger.of(context).clearSnackBars();
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //           content: Text("Please enter Valid email address with @")));
  //     }
  //     _firebaseLogOrReg.registerUser(email, password);
  //     setState(() {
  //       isLogin = !isLogin;
  //     });
  //   }
  // } on FirebaseAuthException catch (e) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text("${e.code} : Please Enter valid Email and Password"),
  //       duration: const Duration(seconds: 5),
  //     ),
  //   );
  // }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Icon(
                    Icons.message_rounded,
                    color: Theme.of(context).colorScheme.tertiary,
                    size: 100,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  isLogin
                      ? "Welcome back you've been missed!"
                      : "Sign Up and start chatting with your friends!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                InputTextfeilds(
                  hintText: "Email",
                  textController: emailController,
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                isLogin
                    ? InputTextfeilds(
                        hintText: "Password",
                        textController: passwordController,
                        obscureText: true,
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: InputTextfeilds(
                              hintText: "Password",
                              textController: passwordController,
                              obscureText: true,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: InputTextfeilds(
                              hintText: "Confirm Password",
                              textController: confirmPasswordController,
                              obscureText: true,
                            ),
                          )
                        ],
                      ),
                const SizedBox(
                  height: 10,
                ),
                if (isLogin)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      )
                    ],
                  ),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                    onTap: () => signUpOrSignIn(
                          emailController.text,
                          passwordController.text,
                          confirmPasswordController.text,
                        ),
                    child: LoginButton(title: isLogin ? "Login" : "Register")),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin ? "Not a memeber?" : "Already have an account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(
                        isLogin ? "Register Now" : "Sign In",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
