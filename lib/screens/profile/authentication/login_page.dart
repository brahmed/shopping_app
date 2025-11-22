import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../config/images.dart';
import '../../../navigation/app_router.dart';
import '../../../providers/user_provider_riverpod.dart';
import '../../../widgets/app/app_logo.dart';
import '../../../widgets/buttons/app_filled_button.dart';
import '../../../widgets/buttons/app_outlined_button.dart';
import '../../../widgets/cards/app_page_container.dart';
import '../../../widgets/form/app_text_field.dart';
import '../../../widgets/form/auth_redirection_text_riverpod.dart';
import '../../../widgets/form/gesture_text_riverpod.dart';
import '../../../widgets/page_app_bar.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
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
    final l = AppLocalizations.of(context)!;

    return Semantics(
      label: 'Login screen',
      child: Scaffold(
        appBar: PageAppBar(title: l.login),
        body: SafeArea(
          child: AppPageContainer(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18.0),

              /// Login Form
              child: Semantics(
                label: 'Login form',
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// App Logo
                      const ExcludeSemantics(child: AppLogo()),

                      /// Email textField
                      AppTextField(
                        key: _emailFieldKey,
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        label: Text(l.email),
                        hintText: l.email,
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
                        label: Text(l.password),
                        hintText: l.password,
                        obscureText: true,
                        semanticLabel: 'Password',
                        textInputAction: TextInputAction.done,
                      ),

                      /// Spacing
                      const SizedBox(height: 20),

                      /// Forget password text
                      GestureTextRiverpod(
                        text: l.forgotPassword,
                        semanticLabel: "Forgot password",
                        semanticHint: "Double tap to reset your password",
                        onTap: () => context.go(AppRoutes.register),
                      ),

                      /// Spacings
                      const SizedBox(height: 20),

                      /// Login Button
                      AppButtonFilled(
                        text: l.login,
                        semanticLabel: "Login button",
                        semanticHint: "Double tap to login with email and password",
                        onClick: () {
                          ref.read(userProvider.notifier).loginUser();
                          context.go(AppRoutes.tabs);
                        },
                      ),

                      /// Spacing
                      const SizedBox(height: 20),

                      /// Create a new account section
                      AuthRedirectionTextRiverpod(
                        staticText: l.newOnThisApp,
                        clickableText: l.createAccount,
                        semanticLabel: "Create an account",
                        redirectionRoute: AppRoutes.register,
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
                        text: l.continueWithFacebook,
                        semanticLabel: "Continue with Facebook",
                        semanticHint: "Double tap to login using Facebook account",
                        icon: ExcludeSemantics(
                          child: CachedNetworkImage(
                            imageUrl: facebookLogo,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.email_outlined),
                          ),
                        ),
                      ),

                      /// Spacing
                      const SizedBox(height: 20),

                      /// Login with Google
                      AppButtonOutlined(
                        onClick: () {},
                        text: l.continueWithGoogle,
                        semanticLabel: "Continue with Google",
                        semanticHint: "Double tap to login using Google account",
                        icon: ExcludeSemantics(
                          child: CachedNetworkImage(
                            imageUrl: googleLogo,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.email_outlined),
                          ),
                        ),
                      ),
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

  /// Divider widget
  Widget dividerRow() {
    final l = AppLocalizations.of(context)!;

    return Semantics(
      label: l.or,
      readOnly: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: ExcludeSemantics(
              child: Divider(
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ExcludeSemantics(
              child: Text(
                l.or,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const Expanded(
            child: ExcludeSemantics(
              child: Divider(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
