import 'package:app/core/services/shared_preference/preferences.dart';
import 'package:app/src/add/add_page.dart';
import 'package:app/src/entry_point.dart';
import 'package:app/src/home/home_page.dart';
import 'package:app/src/profile/profile_page.dart';
import 'package:app/src/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../src/login_page.dart';
import '../src/register_page.dart';
import '../src/verification_pending_page.dart';

final Provider<GoRouter> routerProvider = Provider((ref) => router);

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

// GoRouter configuration
final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: RoutesDocument.register,
  navigatorKey: _rootNavigatorKey,
  redirect: (context, state) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final authenticationRaw = sharedPreferences.getString(Preferences.authentication);
    if (authenticationRaw == null) {
      return RoutesDocument.login;
    }
    return null;
  },
  routes: [
    // GoRoute(
    //   parentNavigatorKey: _rootNavigatorKey,
    //   path: RoutesDocument.home,
    //   builder: (context, state) => const HomePage(),
    // ),
    GoRoute(
      path: RoutesDocument.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: RoutesDocument.register,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: RoutesDocument.verificationPending,
      builder: (context, state) => const VerificationPendingPage(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return EntryPoint(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: RoutesDocument.home,
            builder: (context, state) => const HomePage(),
            routes: [
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: RoutesDocument.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ]),
        GoRoute(
          path: RoutesDocument.add,
          builder: (context, state) => const AddPage(),
          parentNavigatorKey: _shellNavigatorKey,
        ),
        GoRoute(
          path: RoutesDocument.search,
          builder: (context, state) => const SearchPage(),
          parentNavigatorKey: _shellNavigatorKey,
        ),
      ],
    ),
  ],
);

class RoutesDocument {
  const RoutesDocument._();
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String add = '/add';
  static const String search = '/search';
  static const String profile = '/profile';

  static const String verificationPending = '/verification-pending';

  // // Product
  // static String productDetails(String id) => 'product-details/$id';
}

  // final encodedItemId = getEncodedComponent(item.id);
  // context.push(
  //     "${RoutesDocument.pharmacyHome}/${RoutesDocument.productDetails(encodedItemId)}");
