import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../navigation/app_router.dart';
import '../../../providers/user_provider_riverpod.dart';
import '../../../widgets/app/app_logo.dart';
import '../../../widgets/buttons/app_filled_button.dart';
import '../../../widgets/cards/app_page_container.dart';
import '../../../widgets/form/app_text_field.dart';
import '../../../widgets/form/auth_redirection_text.dart';
import '../../../widgets/page_app_bar.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
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
    return Semantics(
      label: 'Register screen',
      child: Scaffold(
        appBar: const PageAppBar(title: "Register"),
        body: SafeArea(
          child: AppPageContainer(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18.0),

              /// Registration Form
              child: Semantics(
                label: 'Registration form',
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// App Logo
                      const ExcludeSemantics(child: AppLogo()),

                      /// FirstName textField
                      AppTextField(
                        key: _firstNameFieldKey,
                        controller: _firstNameController,
                        focusNode: _firstNameFocusNode,
                        label: const Text("First Name"),
                        hintText: "First Name",
                        semanticLabel: 'First name',
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          _lastNameFocusNode.requestFocus();
                        },
                      ),

                      /// Spacing
                      const SizedBox(height: 20),

                      /// LastName textField (Fixed obscureText bug)
                      AppTextField(
                        key: _lastNameFieldKey,
                        controller: _lastNameController,
                        focusNode: _lastNameFocusNode,
                        label: const Text("Last Name"),
                        hintText: "Last Name",
                        semanticLabel: 'Last name',
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          _emailFocusNode.requestFocus();
                        },
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
                        semanticLabel: 'Email address',
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          _passwordFocusNode.requestFocus();
                        },
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
                        semanticLabel: 'Password',
                        textInputAction: TextInputAction.done,
                      ),

                      /// Spacing
                      const SizedBox(height: 20),

                      /// Register Button
                      AppButtonFilled(
                        text: "Register",
                        semanticLabel: "Register button",
                        semanticHint:
                            "Double tap to create account with provided information",
                        onClick: () {
                          ref.read(userProvider.notifier).loginUser();
                          context.go(AppRoutes.tabs);
                        },
                      ),

                      /// Spacing
                      const SizedBox(height: 20),

                      /// Log in to your account section
                      AuthRedirectionText(
                        staticText: "Do you have an account?",
                        clickableText: "log in",
                        redirectionRouteName: AppRoutes.login,
                      ),

                      /// Spacing
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
