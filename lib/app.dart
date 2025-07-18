import 'package:app/common_lib.dart';
import 'package:app/data/providers/firebase_provider.dart';
import 'package:app/main.dart';
import 'package:app/router/app_router.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/core/utils/extensions.dart';
import 'package:app/core/utils/snackbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:flutter_kurdish_localization/kurdish_material_localization_delegate.dart';
//import 'package:flutter_kurdish_localization/kurdish_widget_localization_delegate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:app/core/services/local_notifications_services.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/services.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LocalNotificationsServices.initialize();
      ref.read(firebaseMessegingServiceProvider).initialize();
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationsServices.showNotification(message);
      final data = message.data;
      context.push(data['route']);
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.scheduleFrameCallback((timeStamp) async {
  //     await ref
  //         .read(getIsarInstanceProvider(const [PostSchemeSchema]).future)
  //         .then((isar) {
  //       debugPrint("this is isar instance: ${isar.path}");
  //       CacheManager().clearCacheAndDatabase(isar);
  //     }); // Open the Isar instance
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme();
    return MaterialApp.router(
      title: appName,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      scaffoldMessengerKey: Utils.messengerKey,
      locale: const Locale('en'),
      onGenerateTitle: (context) => context.l10n.appName,
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        //KurdishMaterialLocalizations.delegate,
        //KurdishWidgetLocalizations.delegate,
      ],

      supportedLocales: AppLocalizations.supportedLocales,
      // Theme
      themeMode: ThemeMode.light,
      darkTheme: theme.buildDarkTheme(),
      theme: theme.buildLightTheme(),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const ProviderScope(child: App()));
}
