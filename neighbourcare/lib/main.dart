import 'package:flutter/foundation.dart';
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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
    // Watching providers ensures MyApp and its builder/ MaterialApp rebuild instantly when locale or font size changes
    final localeProvider = context.watch<LocaleProvider>();
    final fontSizeProvider = context.watch<FontSizeProvider>();


    /*
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 700;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FontSizeProvider>().initForScreenSize(screenWidth);
    });
*/
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
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        
        // Detect mobile based on platform target or narrower screen widths
        final bool isMobilePlatform = defaultTargetPlatform == TargetPlatform.iOS || 
                                     defaultTargetPlatform == TargetPlatform.android;
        final bool isNarrowScreen = mediaQuery.size.width < 600;
        final bool isMobile = isMobilePlatform || isNarrowScreen;
        
        double scale = fontSizeProvider.scaleFactor;
        if (isMobile && scale < 1.2) {
          scale = 1.2; // Automatically boost font size floor on mobile environments
        }

        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: TextScaler.linear(scale),
          ),
          child: InitWrapper(child: child ?? const SizedBox.shrink()),
        );
      },
      home: const DiscoverCalgaryPage(),
    );
  }
}

/// Helper widget to initialize screen-size dependent settings after post-frame binding
class InitWrapper extends StatefulWidget {
  final Widget child;
  const InitWrapper({super.key, required this.child});

  @override
  State<InitWrapper> createState() => _InitWrapperState();
}

class _InitWrapperState extends State<InitWrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final screenWidth = MediaQuery.of(context).size.width;
        context.read<FontSizeProvider>().initForScreenSize(screenWidth);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

}