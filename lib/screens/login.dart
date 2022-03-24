import 'package:flutter/material.dart';
import 'package:shopping_app/config/images.dart';
import 'package:shopping_app/widgets/buttons/app_filled_button.dart';
import 'package:shopping_app/widgets/buttons/app_outlined_button.dart';
import 'package:shopping_app/widgets/page_app_bar.dart';

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
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const PageAppBar(title: "Login"),
      body: SafeArea(
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
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
                    color: Theme.of(context).iconTheme.color,
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
                  AppButtonFilled(
                    onClick: () {},
                    text: "Login",
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

                  /// Login with Facebook
                  AppButtonOutlined(
                    onClick: () {},
                    text: "Continue with Facebook",
                    icon: Image.network(
                      facebookLogo,
                      height: 30,
                    ),
                  ),

                  /// Spacing
                  const SizedBox(height: 20),

                  /// Login with Google
                  AppButtonOutlined(
                    onClick: () {},
                    text: "Continue with Google",
                    icon: Image.network(
                      googleLogo,
                      height: 30,
                    ),
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
