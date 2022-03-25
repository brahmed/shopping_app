import 'package:flutter/material.dart';

import '../../../config/images.dart';
import '../../../navigation/routes.dart';
import '../../../widgets/app/app_logo.dart';
import '../../../widgets/buttons/app_filled_button.dart';
import '../../../widgets/buttons/app_outlined_button.dart';
import '../../../widgets/cards/app_page_container.dart';
import '../../../widgets/form/app_text_field.dart';
import '../../../widgets/form/auth_redirection_text.dart';
import '../../../widgets/form/gesture_text.dart';
import '../../../widgets/page_app_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// Global variables
  late GlobalKey<FormState> _formKey;
  late GlobalKey _emailFieldKey;
  late GlobalKey _passwordFieldKey;

  /// Focus Nodes
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  /// Text Editing Controllers
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailFieldKey = GlobalKey();
    _passwordFieldKey = GlobalKey();

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: "Login"),
      body: SafeArea(
        child: AppPageContainer(
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
                  const AppLogo(),

                  /// Email textField
                  AppTextField(
                    key: _emailFieldKey,
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    label: const Text("Email"),
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                  ),

                  /// Spacing
                  const SizedBox(height: 20),

                  /// Password textField
                  AppTextField(
                    key: _passwordFieldKey,
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    label: const Text("Password"),
                    hintText: "Password",
                    obscureText: true,
                  ),

                  /// Spacing
                  const SizedBox(height: 20),

                  /// Forget password text
                  GestureText(
                    text: "Forgot your password ?",
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(Routes.register),
                  ),

                  /// Spacings
                  const SizedBox(height: 20),

                  /// Login Button
                  AppButtonFilled(
                    onClick: () {},
                    text: "Login",
                  ),

                  /// Spacing
                  const SizedBox(height: 20),

                  /// Create a new account section
                  AuthRedirectionText(
                    staticText: "New on this App?",
                    clickableText: "Create an account",
                    redirectionRouteName: Routes.register,
                  ),

                  /// Spacing
                  const SizedBox(height: 20),

                  /// Divider section
                  dividerRow(),

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

  /// Divider widget
  Widget dividerRow() => Row(
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
      );
}
