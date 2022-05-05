import 'package:app/AppProvider.dart';
import 'package:app/Home.dart';
import 'package:app/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var otpCodeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AppProvider>(context, listen: false).setvisibility();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size / 3;
    return Consumer<AppProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("User LogIn"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme
                                  .of(context)
                                  .primaryColor,
                              Theme
                                  .of(context)
                                  .primaryColorLight
                            ])),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          Center(
                            child: value.boolval == false
                                ? Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: TextFormField(
                                              autofocus: false,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration: const InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                suffixIcon: Icon(
                                                    Icons.email_outlined,
                                                    size: 30),
                                                hintText: "Email",
                                                labelText: "Email",
                                                labelStyle:
                                                    TextStyle(fontSize: 20.0),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                errorStyle: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 15),
                                              ),
                                              controller: emailController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      backgroundColor:
                                                          Colors.blue,
                                                      content: Text(
                                                        "Please Enter Email ..",
                                                        style: TextStyle(
                                                            fontSize: 20.0),
                                                      ),
                                                    ),
                                                  );
                                                  // return 'Please Enter Email';
                                                } else if (!value
                                                    .contains('@')) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      backgroundColor:
                                                          Colors.blue,
                                                      content: Text(
                                                        "Please Enter Valid Email ..",
                                                        style: TextStyle(
                                                            fontSize: 20.0),
                                                      ),
                                                    ),
                                                  );
                                                  // return 'Please Enter Valid Email';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: TextFormField(
                                              autofocus: false,
                                              obscureText: true,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                labelText: 'Password',
                                                suffixIcon: Icon(
                                                    Icons.visibility_off,
                                                    size: 30),
                                                filled: true,
                                                fillColor: Colors.white,
                                                hintText: "Password",
                                                labelStyle:
                                                    TextStyle(fontSize: 20.0),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                errorStyle: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 15),
                                              ),
                                              controller: passwordController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      backgroundColor:
                                                          Colors.blue,
                                                      content: Text(
                                                        "Please Enter Password ..",
                                                        style: TextStyle(
                                                            fontSize: 20.0),
                                                      ),
                                                    ),
                                                  );
                                                  // return 'Please Enter Password';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ])
                                : Column(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: SizedBox(
                                                height: 60,
                                                width: 200,
                                                // color: Colors.white,
                                                child: CountryCodePicker(
                                                  initialSelection: '+91',
                                                  onChanged: (countryCode) {
                                                    value.setCountryCode(
                                                        countryCode);
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: TextFormField(
                                                autofocus: false,
                                                keyboardType:
                                                    TextInputType.number,
                                                // maxLength: 10,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                  // labelText: 'Phone Number',
                                                  filled: true,
                                                  // border: InputBorder.none,
                                                  fillColor: Colors.white,
                                                  hintText: "Phone Number",
                                                  labelStyle: const TextStyle(
                                                      fontSize: 20.0),
                                                  errorStyle: const TextStyle(
                                                      color: Colors.redAccent,
                                                      fontSize: 15),
                                                ),
                                                controller: phoneController,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        backgroundColor:
                                                            Colors.red,
                                                        content: Text(
                                                          "Please Enter Phone Number ..",
                                                          style: TextStyle(
                                                              fontSize: 20.0),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Visibility(
                                        visible: value.otpCodeVisible,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 40, right: 40),
                                          child: TextField(
                                            controller: otpCodeController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "OTP",
                                              counter: Container(),
                                            ),
                                            autofillHints: const [
                                              AutofillHints.oneTimeCode
                                            ],
                                            maxLength: 6,
                                            // maxLengthEnforced: false,
                                            style: const TextStyle(
                                                fontSize: 32,
                                                letterSpacing: 15),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (value.boolval == true) {
                                value.GetBoolVal();
                              } else {
                                value.GetBoolVal();
                              }
                            },
                            child: value.boolval == false
                                ? const Text(
                                    'Phone Number       SMS verification',
                                    style: TextStyle(fontSize: 18,color: Colors.white),
                                  )
                                : const Text(
                                    'User ID / Email',
                                    style: TextStyle(fontSize: 18,color: Colors.white),
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
                                    if (_formKey.currentState!.validate()) {
                                      if (value.boolval == true) {
                                        value.setPhoneNumber(
                                            phoneController.text);
                                        emailController.clear();
                                        passwordController.clear();
                                      } else {
                                        phoneController.clear();
                                        value.setEmail(emailController.text);
                                        value.setEmailPassword(
                                            passwordController.text);
                                      }
                                      if (value.otpCodeVisible) {
                                        // print("ElseMethod call");
                                        verifyCode();
                                      } else {
                                        value.boolval == false
                                            ? userEmailLogin()
                                            : userPhoneLogin();
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: value.otpCodeVisible == true
                                        ? const Text(
                                            'Verify',
                                            style: TextStyle(fontSize: 20.0,color: Colors.white),
                                          )
                                        : const Text(
                                            'Login',
                                            style: TextStyle(fontSize: 20.0,color: Colors.white),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an Account? "),
                              TextButton(
                                onPressed: () => {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, a, b) =>
                                            const SignUP(),
                                        transitionDuration:
                                            const Duration(seconds: 0),
                                      ),
                                      (route) => false),
                                },
                                child: const Text(
                                  'Signup',
                                  style: TextStyle(fontSize: 18,color: Colors.white),
                                ),
                              ),
                              // TextButton(
                              //   onPressed: () => {
                              //     Navigator.pushAndRemoveUntil(
                              //         context,
                              //         PageRouteBuilder(
                              //           pageBuilder: (context, a, b) => UserMain(),
                              //           transitionDuration: Duration(seconds: 0),
                              //         ),
                              //         (route) => false)
                              //   },
                              //   child: Text('Dashboard'),
                              // ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      );
    });
  }

  userEmailLogin() async {
    final getProvider = Provider.of<AppProvider>(context, listen: false);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: getProvider.email.toString().trim(),
          password: getProvider.password);
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Home()));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emailController.clear();
        passwordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "No User Found for that Email ...",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        passwordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
      }

      if (kDebugMode) {
        print("Exception ${e.message}");
      }
    }
  }

  userPhoneLogin() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final getProvider = Provider.of<AppProvider>(context, listen: false);
    try {
      if (kDebugMode) {
        print(getProvider.phoneNumber);
      }
      FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: getProvider.phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential).then((value) {
              if (kDebugMode) {
                print("You are logged successfully");
              }
            });
          },
          verificationFailed: (FirebaseAuthException exception) {
            // print(exception.message);
            if (exception.code == 'invalid-phone-number') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text(
                    "he provided phone number is not valid.",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              );
            }
          },
          codeSent: (String verificationID, int? resendToken) {
            getProvider.setverificationId(verificationID);
            getProvider.setVisibility();
            // print("verificationID$verificationID");
            // print("resendToken$resendToken");
            // getProvider.verificationId = verificationID;
            // getProvider.otpCodeVisible = true;
            // print("finds$otpCodeVisible");
            // phoneController.clear();
          },
          timeout: const Duration(seconds: 90),
          codeAutoRetrievalTimeout: (String verificationID) {});
    } catch (e) {
      if (kDebugMode) {
        print("catch block");
      }
    }
  }

  void verifyCode() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final getProvider = Provider.of<AppProvider>(context, listen: false);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: getProvider.verificationId,
        smsCode: otpCodeController.text);
    await auth.signInWithCredential(credential).then((value) {
      if (kDebugMode) {
        print("You are logged in successfully");
      }
      otpCodeController.clear();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Home()));
      emailController.clear();
      passwordController.clear();
      passwordController.clear();
    });
  }

}
