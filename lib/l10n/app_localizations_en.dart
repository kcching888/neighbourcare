// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'NeighbourCare';

  @override
  String get home => 'Home';

  @override
  String get community => 'Community';

  @override
  String get traffic => 'Traffic';

  @override
  String get trafficRoadConditions => 'Traffic & Road Conditions';

  @override
  String get deals => 'Deals';

  @override
  String get housing => 'Housing';

  @override
  String get news => 'News';

  @override
  String get calgaryCommunityHub => 'Calgary Community Hub';

  @override
  String get heroTitle => 'Your Calgary community, all in one place.';

  @override
  String get heroSubtitle =>
      'Local news, traffic, savings, housing, and neighbour-led updates.';

  @override
  String get showMap => 'Show map';

  @override
  String get showList => 'Show list';

  @override
  String get refreshTraffic => 'Refresh traffic';

  @override
  String get getDirections => 'Get directions';
}
