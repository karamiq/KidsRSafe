import 'package:app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/utils/constants/sizes.dart';

class VerificationPendingPage extends ConsumerStatefulWidget {
  const VerificationPendingPage({super.key});

  @override
  ConsumerState<VerificationPendingPage> createState() => _VerificationPendingPageState();
}

class _VerificationPendingPageState extends ConsumerState<VerificationPendingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Pending'),
      ),
      body: Center(
        child: Padding(
          padding: Insets.largeAll,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.hourglass_empty,
                size: 80,
                color: Colors.orange,
              ),
              const SizedBox(height: Insets.large),
              const Text(
                'Account Verification Pending',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Insets.medium),
              const Text(
                'Your account is currently being reviewed by our moderators. This process usually takes 24-48 hours.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Insets.extraLarge),
              const CircularProgressIndicator(),
              const SizedBox(height: Insets.large),
              TextButton(
                onPressed: () {
                  context.go(RoutesDocument.login);
                },
                child: const Text('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
