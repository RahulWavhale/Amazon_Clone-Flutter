import 'package:amzon_clone/Controller/authController.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var signUpKey = GlobalKey<FormState>();
  var signInKey = GlobalKey<FormState>();
  var passwordvisible = false;

  void _SignUpsubmit(String email, String password, String name) {
    final isValid = signUpKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    signUpKey.currentState!.save();
    AuthController().signUpUser(
        email: email, password: password, name: name, context: context);
  }


  void _SignInsubmit(String email, String password) {
    final isValid = signInKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    signInKey.currentState!.save();
    AuthController()
        .signInUser(context: context, email: email, password: password);
  }

  RegExp regexp = RegExp(
      r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[*.!@$%^&(){}[]:;<>,.?/~_+-=|\]).{6,32}$');

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoginEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: isLoginEnabled
                ? Column(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 20),
                          child: Image.asset(
                            'assets/img/amazon_logo.png',
                            width: 130,
                          )),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 30),
                        child: const Text(
                          "Sign In to ABC Using Amazon \n Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12, fontFamily: 'AmazonEmberMedium'),
                        ),
                      ),
                      Form(
                        key: signInKey,
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 30, left: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Sign in",
                                  style: TextStyle(
                                    fontFamily: 'AmazonEmberBold',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Forgot Password ?",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'AmazonEmberMedium'),
                                    ))
                              ]),
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hoverColor: Colors.orange,
                            hintStyle: TextStyle(
                                fontFamily: 'AmazonEmberMedium', fontSize: 12),
                            hintText: "Enter Email/Phone Number",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        obscureText: !passwordvisible,
                        controller: passwordController,
                        decoration: const InputDecoration(
                            hoverColor: Colors.orange,
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontFamily: 'AmazonEmberMedium', fontSize: 12),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      CheckboxListTile(
                        value:
                            passwordvisible, // Reflects the current state of password visibility
                        onChanged: (value) {
                          setState(() {
                            passwordvisible =
                                value!; // Update the state based on checkbox value
                          });
                        },
                        title: const Text(
                          "Show Password",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'AmazonEmberMedium',
                          ),
                        ),
                      ),
                      CheckboxListTile(
                        value: false,
                        onChanged: (value) {},
                        title: const Text(
                          "Keep me Sign In",
                          style: TextStyle(
                              fontSize: 12, fontFamily: 'AmazonEmberMedium'),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _SignInsubmit(
                              emailController.text, passwordController.text);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              shape: BoxShape.rectangle,
                              color: Colors.orange),
                          width: 500,
                          height: 50,
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'AmazonEmberMedium'),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const Text(
                        "New To Amazon ?",
                        style: TextStyle(
                            fontSize: 12, fontFamily: 'AmazonEmberMedium'),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLoginEnabled = false;
                            });
                          },
                          child: const Text(
                            "Create a New Amazon Account ",
                            style: TextStyle(
                                fontSize: 12, fontFamily: 'AmazonEmberMedium'),
                          )),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Conditions of Use Privacy Notice",
                            style: TextStyle(
                                fontSize: 12, fontFamily: 'AmazonEmberMedium'),
                          ))
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Form(
                      key: signUpKey,
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 20),
                              child: Image.asset(
                                'assets/img/amazon_logo.png',
                                width: 130,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Create Account",
                                style: TextStyle(
                                  fontFamily: 'AmazonEmberBold',
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Your Name",
                                style: TextStyle(
                                  fontFamily: 'AmazonEmberMedium',
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 45,
                                child: TextFormField(
                                  controller: nameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Name is required";
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black))),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Email",
                                style: TextStyle(
                                  fontFamily: 'AmazonEmberMedium',
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 45,
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                                            .hasMatch(value)) {
                                      return "Enter Valid Email";
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black))),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Password",
                                style: TextStyle(
                                  fontFamily: 'AmazonEmberMedium',
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 45,
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: passwordvisible,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Password Not be Empty";
                                    } else {
                                      if (value.length < 6) {
                                        return "Password should contain at least one uppercase letter, one lowercase letter, one number, and one special character";
                                      } else {
                                        return null;
                                      }
                                    }
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              passwordvisible =
                                                  !passwordvisible;
                                            });
                                          },
                                          icon: Icon(passwordvisible
                                              ? Icons.visibility
                                              : Icons.visibility_off)),
                                      errorBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red)),
                                      hintText: "At Least 6 Characters",
                                      hintStyle: const TextStyle(
                                          fontFamily: "AmazonEmberMedium",
                                          fontSize: 10),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black))),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Re-enter Password",
                                style: TextStyle(
                                  fontFamily: 'AmazonEmberMedium',
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 45,
                                child: TextFormField(
                                  obscureText: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Password Not be Empty";
                                    } else {
                                      if (value != passwordController.text) {
                                        return "Passwords do not match ";
                                      } else {
                                        return null;
                                      }
                                    }
                                  },
                                  decoration: const InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black))),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () => _SignUpsubmit(emailController.text,
                                passwordController.text, nameController.text),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  shape: BoxShape.rectangle,
                                  color: Colors.orange),
                              width: 500,
                              height: 50,
                              child: const Text(
                                "Continue",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'AmazonEmberMedium'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    "By Creating Account, you Agree to Amazon's",
                                    style: TextStyle(
                                      fontFamily: 'AmazonEmberMedium',
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Conditions of use",
                                        style: TextStyle(
                                          fontFamily: 'AmazonEmberMedium',
                                          fontSize: 10,
                                        ),
                                      )),
                                  const Text(
                                    "And",
                                    style: TextStyle(
                                      fontFamily: 'AmazonEmberMedium',
                                      fontSize: 10,
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Privacy Notice",
                                        style: TextStyle(
                                          fontFamily: 'AmazonEmberMedium',
                                          fontSize: 10,
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                          const Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row(
                              //   mainAxisSize: MainAxisSize.min,
                              //   children: [
                              //     const Text(
                              //       "Already Have an Account ? ",
                              //       style: TextStyle(
                              //         fontFamily: 'AmazonEmberMedium',
                              //         fontSize: 10,
                              //       ),
                              //     ),
                              //     TextButton(
                              //         onPressed: () {
                              //           setState(() {
                              //             isLoginEnabled = true;
                              //           });
                              //         },
                              //         child: const Text(
                              //           " Sign In",
                              //           style: TextStyle(
                              //             fontFamily: 'AmazonEmberMedium',
                              //             fontSize: 10,
                              //           ),
                              //         ))
                              //   ],
                              // ),
                              // Row(
                              //   mainAxisSize: MainAxisSize.min,
                              //   children: [
                              //     const Text(
                              //       "Buying for work ? ",
                              //       style: TextStyle(
                              //         fontFamily: 'AmazonEmberMedium',
                              //         fontSize: 10,
                              //       ),
                              //     ),
                              //     TextButton(
                              //         onPressed: () {},
                              //         child: const Text(
                              //           "Create a free Business Account",
                              //           style: TextStyle(
                              //             fontFamily: 'AmazonEmberMedium',
                              //             fontSize: 10,
                              //           ),
                              //         )),
                              //   ],
                              // )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ));
  }
}
