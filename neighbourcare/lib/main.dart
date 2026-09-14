import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'l10n/app_localizations.dart';
import 'pages/discover_calgary_page.dart';
import 'pages/login_page.dart';

import 'services/auth_service.dart';
import 'services/locale_provider.dart';
import 'services/font_size_provider.dart';
// Note: You no longer need to import top_banner_widget.dart here

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/* ThemeData(
  textTheme: GoogleFonts.notoSansTextTheme(
          Theme.of(context).textTheme,
        )
);
*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jvesmtshgajflaaxdxen.supabase.co',
    publishableKey: 'sb_publishable_1BOExDsqgxSmPv-RpJtNuw_5zvTl-A_',
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.implicit,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => FontSizeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);
    return MaterialApp(
      navigatorKey: navigatorKey,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.calgaryCommunityHub,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.notoSansTextTheme(),
        fontFamilyFallback: const ['AppFallbackFont', 'Roboto', 'sans-serif'],
      ),
      locale: localeProvider.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      
      // ✅ CORRECTED: Only wrap the Navigator (child) with MediaQuery scaling.
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(fontSizeProvider.scaleFactor),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const DiscoverCalgaryPage(),
    );
  }
}