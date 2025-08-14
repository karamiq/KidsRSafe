import 'package:app/common_lib.dart';
import 'package:app/core/services/clients/_clients.dart';
import 'package:flutter/material.dart';
import '../data/providers/auth_provider.dart';
import '../core/utils/widgets/buttons/filled_loading_button.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final authState = ref.watch(authProvider);

    void handleLogin() async {
      if (!formKey.currentState!.validate()) return;
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final result = await ref.read(authProvider.notifier).login(email, password);
      result.whenDataOrError(data: (d) {
        context.push(RoutesDocument.home);
      }, error: (e, t) {
        Utils.showErrorSnackBar(e.toString());
        print('Login error: $e, $t');
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: Insets.largeAll,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  controller: emailController,
                  labelText: 'Email',
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: context.validator.email().required().build(),
                ),
                const SizedBox(height: Insets.medium),
                CustomTextFormField(
                  controller: passwordController,
                  labelText: 'Password',
                  hintText: 'Password',
                  obscureText: true,
                  validator: context.validator.required().minLength(8).build(),
                ),
                const SizedBox(height: Insets.large),
                SizedBox(
                  width: double.infinity,
                  child: FilledLoadingButton(
                    isLoading: authState.isLoading,
                    onPressed: handleLogin,
                    child: const Text('Login'),
                  ),
                ),
                TextButton(
                  onPressed: () => context.go(RoutesDocument.register),
                  child: const Text('Don\'t have an account? Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
