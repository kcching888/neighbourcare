// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

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

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get appName => 'NeighbourCare';

  @override
  String get home => '首頁';

  @override
  String get community => '社區';

  @override
  String get traffic => '交通';

  @override
  String get deals => '優惠';

  @override
  String get housing => '住房';

  @override
  String get news => '新聞';

  @override
  String get calgaryCommunityHub => '卡加利社區資訊平台';

  @override
  String get heroTitle => '卡加利社區生活資訊，一站掌握。';

  @override
  String get heroSubtitle => '本地新聞、交通、優惠、住房與鄰里即時動態。';
}
