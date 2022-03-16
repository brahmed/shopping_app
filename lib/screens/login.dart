import 'package:flutter/material.dart';
import 'package:shopping_app/config/images.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// Global variables
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Page header
            Container(
              padding: const EdgeInsets.all(25.0),
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Log In",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.grey.shade300,
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),

            /// Page body
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(18.0),

                  /// Login Form
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        /// App Logo
                        Image.asset(
                          appImage,
                          height: 180,
                        ),

                        /// Email textField
                        TextFormField(
                          decoration: const InputDecoration(
                              label: Text("Email"), hintText: "Email"),
                        ),

                        /// Spacing
                        const SizedBox(height: 20),

                        /// Password textField
                        TextFormField(
                          decoration: const InputDecoration(
                              label: Text("Password"), hintText: "Password"),
                        ),

                        /// Spacing
                        const SizedBox(height: 20),

                        /// Forget password text
                        GestureDetector(
                          onTap: null,
                          child: const Text(
                            "Forgot your password ? ",
                            textAlign: TextAlign.right,
                            softWrap: false,
                            style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        /// Spacing
                        const SizedBox(height: 20),

                        /// Login Button
                        GestureDetector(
                          onTap: null,
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                "Log In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),

                        /// Spacing
                        const SizedBox(height: 20),

                        /// Create a new account section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "New on this App ? ",
                              textAlign: TextAlign.right,
                              softWrap: false,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            GestureDetector(
                              onTap: null,
                              child: const Text(
                                " create a new account",
                                textAlign: TextAlign.right,
                                softWrap: false,
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// Spacing
                        const SizedBox(height: 20),

                        /// Divider section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "or",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),

                        /// Spacing
                        const SizedBox(height: 20),

                        /// Facebook button
                        Container(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 2,
                              color: Colors.blueAccent,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 23),
                                child: FlutterLogo(),
                              ),
                              Text(
                                "Continue with Meta",
                                textAlign: TextAlign.right,
                                softWrap: false,
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Spacing
                        const SizedBox(height: 20),

                        /// Google button
                        Container(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 2,
                              color: Colors.grey,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 23),
                                child: FlutterLogo(),
                              ),
                              Text(
                                "Continue with Google",
                                textAlign: TextAlign.right,
                                softWrap: false,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
