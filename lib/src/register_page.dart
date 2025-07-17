import 'dart:io';

import 'package:app/common_lib.dart';
import 'package:app/core/services/clients/_clients.dart';
import 'package:app/core/utils/widgets/buttons/filled_loading_button.dart';
import 'package:app/core/utils/widgets/form_fields/image_form_field.dart';
import 'package:app/data/providers/auth_provider.dart';
import 'package:flutter/material.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'karam@gmail.com');
  final _passwordController = TextEditingController(text: '12345678');
  final _displayNameController = TextEditingController(text: 'Karam Rasheed');
  final _userNameController = TextEditingController(text: 'grand_master');
  final _parentEmailController = TextEditingController(text: 'kkkkkk@gmail.com');
  DateTime _selectedDateOfBirth = DateTime(2010, 1, 1);
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider).isLoading;
    void register() async {
      if (!_formKey.currentState!.validate()) return;

      if (_selectedImage == null) {
        context.showErrorSnackBar('Please select a profile picture');
        return;
      }
      final file = File(_selectedImage!.path);
      if (!await file.exists()) {
        context.showErrorSnackBar('Image file no longer exists. Please re-select.');
        return;
      }

      final result = await ref.read(authProvider.notifier).register(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            displayName: _displayNameController.text.trim(),
            userName: _userNameController.text.trim(),
            dateOfBirth: _selectedDateOfBirth,
            parentEmail: _parentEmailController.text.trim(),
            profilePicture: file,
          );

      result.whenDataOrError(data: (d) {
        context.go(RoutesDocument.home);
      }, error: (e, t) {
        context.showErrorSnackBar(e.toString());
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: SingleChildScrollView(
          padding: Insets.largeAll,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageFormField(
                  dimension: 100,
                  image: _selectedImage,
                  onChanged: (v) {
                    setState(() => _selectedImage = v);
                  },
                  text: 'Profile Picture',
                ),
                const SizedBox(height: Insets.large),
                CustomTextFormField(
                  controller: _displayNameController,
                  labelText: 'Display Name',
                  hintText: 'Display Name',
                  validator: context.validator.required().build(),
                ),
                const SizedBox(height: Insets.medium),
                CustomTextFormField(
                  controller: _userNameController,
                  labelText: 'Username',
                  hintText: 'Username',
                  validator: context.validator.required().build(),
                ),
                const SizedBox(height: Insets.medium),
                CustomTextFormField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: context.validator.email().required().build(),
                ),
                const SizedBox(height: Insets.medium),
                CustomTextFormField(
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: 'Password',
                  obscureText: true,
                  validator: context.validator.required().minLength(8).build(),
                ),
                const SizedBox(height: Insets.medium),
                CustomTextFormField(
                  controller: _parentEmailController,
                  labelText: 'Parent Email',
                  hintText: 'Parent Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: context.validator.email().required().build(),
                ),
                const SizedBox(height: Insets.medium),
                CustomTextFormField(
                  controller: TextEditingController(
                    text: _selectedDateOfBirth == null
                        ? ''
                        : _selectedDateOfBirth.toLocal().toString().split(' ')[0],
                  ),
                  labelText: 'Date of Birth',
                  hintText: 'Select Date of Birth',
                  readOnly: true,
                  suffixIcon: const Icon(Icons.calendar_today),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2010, 1, 1),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedDateOfBirth = picked;
                      });
                    }
                  },
                  validator: (_) => _selectedDateOfBirth == null ? context.l10n.validatorRequired : null,
                ),
                const SizedBox(height: Insets.large),
                SizedBox(
                  width: double.infinity,
                  child: FilledLoadingButton(
                    isLoading: isLoading,
                    onPressed: register,
                    child: const Text('Register'),
                  ),
                ),
                TextButton(
                  onPressed: () => context.go(RoutesDocument.login),
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
