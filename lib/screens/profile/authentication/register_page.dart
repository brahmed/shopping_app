import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/user_provider.dart';

import '../../../navigation/routes.dart';
import '../../../widgets/app/app_logo.dart';
import '../../../widgets/buttons/app_filled_button.dart';
import '../../../widgets/cards/app_page_container.dart';
import '../../../widgets/form/app_text_field.dart';
import '../../../widgets/form/auth_redirection_text.dart';
import '../../../widgets/page_app_bar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  /// Global variables
  late GlobalKey<FormState> _formKey;
  late GlobalKey _firstNameFieldKey;
  late GlobalKey _lastNameFieldKey;
  late GlobalKey _emailFieldKey;
  late GlobalKey _passwordFieldKey;

  /// Focus Nodes
  late FocusNode _firstNameFocusNode;
  late FocusNode _lastNameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  /// Text Editing Controllers
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _firstNameFieldKey = GlobalKey();
    _lastNameFieldKey = GlobalKey();
    _emailFieldKey = GlobalKey();
    _passwordFieldKey = GlobalKey();

    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: "Register"),
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

                  /// FirstName textField
                  AppTextField(
                    key: _firstNameFieldKey,
                    controller: _firstNameController,
                    focusNode: _firstNameFocusNode,
                    label: const Text("First Name"),
                    hintText: "First Name",
                  ),

                  /// Spacing
                  const SizedBox(height: 20),

                  /// LastName textField
                  AppTextField(
                    key: _lastNameFieldKey,
                    controller: _lastNameController,
                    focusNode: _lastNameFocusNode,
                    label: const Text("Last Name"),
                    hintText: "Last Name",
                    obscureText: true,
                  ),

                  /// Spacing
                  const SizedBox(height: 20),

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

                  /// Register Button
                  AppButtonFilled(
                    text: "Register",
                    onClick: () {
                      Provider.of<UserProvider>(context, listen: false)
                          .loginUser();
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.tabs, (route) => false);
                    },
                  ),

                  /// Spacing
                  const SizedBox(height: 20),

                  /// Log in to your account section
                  AuthRedirectionText(
                    staticText: "Do you have an account?",
                    clickableText: "log in",
                    redirectionRouteName: Routes.login,
                  ),

                  /// Spacing
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
