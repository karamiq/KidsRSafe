import 'package:app/core/services/shared_preference/preferences.dart';
import 'package:app/src/add/images_selecting_page.dart';
import 'package:app/src/add/post_selected_media_page.dart';
import 'package:app/src/add/video_selecting_page.dart';
import 'package:app/src/entry_point.dart';
import 'package:app/src/home/home_page.dart';
import 'package:app/src/inbox/chats/chats_page.dart';
import 'package:app/src/profile/profile_page.dart';
import 'package:app/src/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../src/login_page.dart';
import '../src/register_page.dart';
import '../src/verification_pending_page.dart';
import 'package:app/src/inbox/inbox_page.dart';
import 'package:app/src/inbox/chats/chat_detail_page.dart';
import 'package:app/data/models/chat_model.dart';

final Provider<GoRouter> routerProvider = Provider((ref) => router);

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

// GoRouter configuration
final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: RoutesDocument.home,
  navigatorKey: _rootNavigatorKey,
  redirect: (context, state) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final authenticationRaw = sharedPreferences.getString(Preferences.authentication);

    // Check both SharedPreferences and Firebase Auth
    final firebaseUser = FirebaseAuth.instance.currentUser;

    // Allow access to login and register pages even when not authenticated
    if (state.matchedLocation == RoutesDocument.login || state.matchedLocation == RoutesDocument.register) {
      return null;
    }

    if (authenticationRaw == null && firebaseUser == null) {
      return RoutesDocument.login;
    }

    // If Firebase Auth user exists but no SharedPreferences, redirect to login
    if (authenticationRaw == null && firebaseUser != null) {
      // Sign out from Firebase Auth to maintain consistency
      await FirebaseAuth.instance.signOut();
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
          pageBuilder: (context, state) => instanTransition(
            state,
            const HomePage(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: RoutesDocument.profile,
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: RoutesDocument.search,
          builder: (context, state) => const SearchPage(),
          parentNavigatorKey: _shellNavigatorKey,
        ),
        GoRoute(
          path: RoutesDocument.inbox,
          builder: (context, state) => const InboxPage(),
          parentNavigatorKey: _shellNavigatorKey,
          routes: [
            GoRoute(
              path: 'chats',
              builder: (context, state) => const ChatsPage(),
              routes: [
                GoRoute(
                  path: ':chatId',
                  builder: (context, state) {
                    final chat = state.extra as ChatModel;
                    return ChatDetailPage(chat: chat);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    GoRoute(path: RoutesDocument.videoSelecting, builder: (context, state) => const VideoSelectingPage()),
    GoRoute(
      path: RoutesDocument.postSelectedMedia,
      builder: (context, state) => const PostSelectedMediaPage(),
    ),
    GoRoute(
      path: RoutesDocument.imagesSelecting,
      builder: (context, state) => const ImagesSelectingPage(),
    ),
  ],
);

class RoutesDocument {
  const RoutesDocument._();
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String search = '/search';
  static const String profile = '/profile';
  static const String inbox = '/inbox';
  static const String chats = '$inbox/chats';
  static String chatDetail(String chatId) => '$chats/$chatId';

  // sub- selecting media to post  pages
  static const String videoSelecting = '/video-selecting';
  static const String postSelectedMedia = '/post-selected-media';
  static const String imagesSelecting = '/image-selecting';

  static const String verificationPending = '/verification-pending';

  // // Product
  // static String productDetails(String id) => 'product-details/$id';
}

// final encodedItemId = getEncodedComponent(item.id);
// context.push(
//     "${RoutesDocument.pharmacyHome}/${RoutesDocument.productDetails(encodedItemId)}");

CustomTransitionPage<void> instanTransition(GoRouterState state, Widget page,
    {Duration duration = const Duration(milliseconds: 0)}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    restorationId: state.pageKey.value,
    child: page,
    transitionDuration: duration,
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) =>
        FadeTransition(
      opacity: animation,
      child: page,
    ),
  );
}
