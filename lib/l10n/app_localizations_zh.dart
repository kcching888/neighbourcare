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
  String get deals => 'Deals';

  @override
  String get housing => 'Housing';

  @override
  String get news => 'News';

  @override
  String get calgary => 'Calgary';

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

  @override
  String get neighbourCareCommunity => 'NeighbourCare Community';

  @override
  String get weather => 'Weather';

  @override
  String get dining => 'Dining';

  @override
  String get diyHome => 'DIY & Home';

  @override
  String get communityFeeds => 'Community Feeds';

  @override
  String get createPost => 'Create post';

  @override
  String get chooseTopicToPost => 'Choose a topic to post';

  @override
  String get weatherUpdate => 'Weather update';

  @override
  String get diningPost => 'Dining post';

  @override
  String get diyHomePost => 'DIY & Home post';

  @override
  String get signInRequired => 'Sign in required';

  @override
  String get signInToCreatePost =>
      'Sign in as a client or provider before creating a community post.';

  @override
  String get cancel => 'Cancel';

  @override
  String get signIn => 'Sign in';

  @override
  String get clientSignIn => 'Client sign in';

  @override
  String get providerPortal => 'Provider portal';

  @override
  String get account => 'Account';

  @override
  String get signedInMember => 'Signed-in member';

  @override
  String get bookServices => 'Book services';

  @override
  String get signOut => 'Sign out';

  @override
  String get couldNotLoadPosts => 'Could not load posts';

  @override
  String get noCommunityPosts => 'No community posts yet.';

  @override
  String get posted => 'Posted';

  @override
  String get requestHelp => 'Request help';

  @override
  String get signInToRequestHelp =>
      'Sign in to request help from a community post.';

  @override
  String get communityPost => 'Community post';
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
