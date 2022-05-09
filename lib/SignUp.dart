import 'package:app/mainPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUP extends StatefulWidget {
  const SignUP({Key? key}) : super(key: key);

  @override
  _SignUPState createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  var confirmPassword = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User SignUp"),
      ),
      body: Column(
        children: [
          // Visibility(
          //   visible: Provider.of<InternetConnectionStatus>(context) ==
          //       InternetConnectionStatus.disconnected,
          //   child: const InternetNotAvailable(),
          // ),
          /* Stack(children: [
            // Container(
            //   alignment: Alignment.bottomRight,
            //   child: Text("Register",style: TextStyle(color: Colors.white60,fontSize: 30)),
            // ),
            Container(
              color:Colors.purple.shade900,
              // color: Colors.black54,
              child: Container(
                height: size.height,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(180),
                      bottomRight: Radius.circular(180)),
                  color: Colors.pinkAccent,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      // color: Colors.grey.shade200,
                        color:Colors.purple.shade900,
                        offset: const Offset(2, 4),
                        blurRadius: 5,
                        spreadRadius: 2)
                  ],
                  // gradient: LinearGradient(colors: [
                  //   Colors.accents.first,
                  //   Colors.amber,
                  //   Colors.limeAccent,
                  //   Colors.amberAccent,
                  //   Colors.accents.last
                  // ])
                ),
              ),
            ),
          ]),*/
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColorLight
                  ])),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            autofocus: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              filled: true,
                              suffixIcon: Icon(Icons.email_outlined, size: 30),
                              fillColor: Colors.white,
                              hintText: "Email",
                              labelText: "Email",
                              labelStyle: TextStyle(fontSize: 20.0),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15),
                            ),
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                // return 'Please Enter Email';
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.blue,
                                    content: Text(
                                      "Please Enter Email ..",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                );
                              } else if (!value.contains('@')) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.blue,
                                    content: Text(
                                      "Please Enter Valid Email ..",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                );
                                // return 'Please Enter Valid Email';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            autofocus: false,
                            obscureText: true,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              filled: true,
                              suffixIcon: Icon(Icons.visibility_off, size: 30),
                              fillColor: Colors.white,
                              hintText: "Password",
                              labelStyle: TextStyle(fontSize: 20.0),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15),
                            ),
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                // return 'Please Enter Password';
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.blue,
                                    content: Text(
                                      "Please Enter Password ..",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                );
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            autofocus: false,
                            obscureText: true,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              filled: true,
                              suffixIcon: Icon(Icons.visibility_off, size: 30),
                              fillColor: Colors.white,
                              labelText: "Confirm Password",
                              hintText: 'Confirm Password: ',
                              labelStyle: TextStyle(fontSize: 20.0),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15),
                            ),
                            controller: confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                // return 'Please Enter Password';
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.blue,
                                    content: Text(
                                      "Please Enter Confirm Password ..",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                );
                              }
                              return null;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () {
                                  // print("Button press");
                                  // Validate returns true if the form is valid, otherwise false.
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      email = emailController.text;
                                      password = passwordController.text;
                                      confirmPassword =
                                          confirmPasswordController.text;
                                    });
                                    registration();
                                  }
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an Account? "),
                            TextButton(
                                onPressed: () => {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                                  animation2) =>
                                              const MainPage(),
                                          transitionDuration:
                                              const Duration(seconds: 0),
                                        ),
                                      )
                                    },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 17.0, color: Colors.white),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void registration() async {
    if (password == confirmPassword) {
      // print("Valid Password");
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text(
              "Registered Successfully. Please Login..",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Password Provided is too weak..",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Account Already exists..",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
        }
      }
    } else {
      if (kDebugMode) {
        print("Password and Confirm Password doesn't match");
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Password and Confirm Password doesn't match",
            style: TextStyle(fontSize: 14.0, color: Colors.black),
          ),
        ),
      );
    }
  }
}
