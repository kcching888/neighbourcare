import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'l10n/app_localizations.dart';
import 'pages/weather_forum_page.dart';
import 'pages/discover_calgary_page.dart';

import 'services/auth_service.dart';
import 'services/locale_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jvesmtshgajflaaxdxen.supabase.co',
    publishableKey: 'sb_publishable_1BOExDsqgxSmPv-RpJtNuw_5zvTl-A_',
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.implicit,
    ),
  );

  //runApp(
  //  ChangeNotifierProvider(
  //    create: (_) => AuthService(),
  //    child: const MyApp(),
  //  ),
  //);

  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthService()),
      ChangeNotifierProvider(create: (_) => LocaleProvider()),
    ],
    child: const MyApp(),
  ),
);


}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  // Allow descendant widgets to change locale easily
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Inside MyApp build():
    final localeProvider = Provider.of<LocaleProvider>(context);
    
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.calgaryCommunityHub,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      locale: localeProvider.locale, // Pass the custom locale here (null defaults to system)
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: const DiscoverCalgaryPage(),
    );
  }
}