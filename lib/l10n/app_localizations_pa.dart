// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class AppLocalizationsPa extends AppLocalizations {
  AppLocalizationsPa([String locale = 'pa']) : super(locale);

  @override
  String get aboutNeighbourCare =>
      'NeighbourCare ਕੈਲਗਰੀ ਦੇ ਗੁਆਂਢੀਆਂ ਨੂੰ ਲਾਭਦਾਇਕ ਸਥਾਨਕ ਜਾਣਕਾਰੀ ਅਤੇ ਭਾਈਚਾਰਕ ਸਰੋਤਾਂ ਦੇ ਨੇੜੇ ਲਿਆਉਂਦਾ ਹੈ।';

  @override
  String get account => 'ਖਾਤਾ';

  @override
  String get accountCreatedCheckEmail =>
      'ਖਾਤਾ ਬਣਾਇਆ ਗਿਆ। ਆਪਣਾ ਖਾਤਾ ਪੁਸ਼ਟੀ ਕਰਨ ਲਈ ਆਪਣੀ ਈਮੇਲ ਦੇਖੋ, ਫਿਰ ਸਾਈਨ ਇਨ ਕਰੋ।';

  @override
  String get accountCreatedCheckEmailReturn =>
      'ਖਾਤਾ ਬਣਾਇਆ ਗਿਆ। ਆਪਣਾ ਖਾਤਾ ਪੁਸ਼ਟੀ ਕਰਨ ਲਈ ਆਪਣੀ ਈਮੇਲ ਦੇਖੋ, ਫਿਰ ਸਾਈਨ ਇਨ ਕਰਨ ਲਈ ਇੱਥੇ ਵਾਪਸ ਆਓ।';

  @override
  String get accountCreatedSignedIn => 'ਖਾਤਾ ਬਣਾਇਆ ਗਿਆ ਅਤੇ ਸਾਈਨ ਇਨ ਹੋ ਗਿਆ।';

  @override
  String activeIncidentsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ਸਰਗਰਮ ਘਟਨਾਵਾਂ',
      one: '$countString ਸਰਗਰਮ ਘਟਨਾ',
    );
    return '$_temp0';
  }

  @override
  String get adminPortalTitle => 'ਐਡਮਿਨ ਪੋਰਟਲ';

  @override
  String get adminPortalTooltip => 'ਐਡਮਿਨ ਪੋਰਟਲ';

  @override
  String get alertTypeLabel => 'ਚੇਤਾਵਨੀ ਦੀ ਕਿਸਮ';

  @override
  String get all => 'ਸਾਰੇ';

  @override
  String amountValue(String amount) {
    return 'ਰਕਮ: $amount';
  }

  @override
  String get appName => 'NeighbourCare';

  @override
  String get applicationSubmittedPendingApproval =>
      'ਅਰਜ਼ੀ ਭੇਜੀ ਗਈ। ਤੁਹਾਡੇ ਕੰਮ ਲੈਣ ਤੋਂ ਪਹਿਲਾਂ ਇੱਕ ਐਡਮਿਨ ਨੂੰ ਤੁਹਾਡੀ ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਪ੍ਰੋਫਾਈਲ ਮਨਜ਼ੂਰ ਕਰਨੀ ਚਾਹੀਦੀ ਹੈ।';

  @override
  String get applyNow => 'ਹੁਣੇ ਅਰਜ਼ੀ ਦਿਓ';

  @override
  String get applyToBecomeProvider => 'ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਬਣਨ ਲਈ ਅਰਜ਼ੀ ਦਿਓ';

  @override
  String get approveButton => 'ਮਨਜ਼ੂਰ ਕਰੋ';

  @override
  String get assessedValueExplainer =>
      'ਅੰਦਾਜ਼ਨ ਮੁੱਲ ਜਾਇਦਾਦ ਦੇ ਮੁਲਾਂਕਣ ਅਤੇ ਟੈਕਸ ਲਈ ਵਰਤਿਆ ਜਾਂਦਾ ਹੈ। ਇਹ ਮੌਜੂਦਾ ਮਾਰਕੀਟ ਵਿਕਰੀ-ਕੀਮਤ ਅਨੁਮਾਨ ਵਰਗਾ ਨਹੀਂ ਹੈ।';

  @override
  String get assessedValueLookupTitle => 'ਸ਼ਹਿਰ ਦੇ ਅੰਦਾਜ਼ਨ-ਮੁੱਲ ਦੀ ਖੋਜ';

  @override
  String get assignButton => 'ਸੌਂਪੋ';

  @override
  String get backToSignIn => 'ਸਾਈਨ ਇਨ \'ਤੇ ਵਾਪਸ ਜਾਓ';

  @override
  String get becomeAProviderTitle => 'ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਬਣੋ';

  @override
  String get bestDealsThisWeek => 'ਇਸ ਹਫ਼ਤੇ ਦੀਆਂ ਸਭ ਤੋਂ ਵਧੀਆ ਡੀਲਾਂ';

  @override
  String get bookAHomeService => 'ਘਰੇਲੂ ਸੇਵਾ ਬੁੱਕ ਕਰੋ';

  @override
  String get bookServices => 'ਸੇਵਾਵਾਂ ਬੁੱਕ ਕਰੋ';

  @override
  String get bookingAssignedToProvider => 'ਬੁਕਿੰਗ ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਨੂੰ ਸੌਂਪੀ ਗਈ।';

  @override
  String bookingStartedFromPost(String title) {
    return 'ਇਹ ਬੁਕਿੰਗ ਭਾਈਚਾਰਕ ਪੋਸਟ ਤੋਂ ਸ਼ੁਰੂ ਹੋਈ: $title';
  }

  @override
  String bookingStatusUpdated(String status) {
    return 'ਬੁਕਿੰਗ ਸਥਿਤੀ $status ਵਿੱਚ ਅੱਪਡੇਟ ਕੀਤੀ ਗਈ।';
  }

  @override
  String bookingSubmittedSuccess(String id) {
    return 'ਬੁਕਿੰਗ ਸਫਲਤਾਪੂਰਵਕ ਭੇਜੀ ਗਈ।\nਬੁਕਿੰਗ ID: $id';
  }

  @override
  String get bookingsTitle => 'ਬੁਕਿੰਗਾਂ';

  @override
  String get browseGroceryDeals => 'ਕਰਿਆਨੇ ਦੀਆਂ ਡੀਲਾਂ ਵੇਖੋ';

  @override
  String get browseOpenings => 'ਖਾਲੀ ਥਾਵਾਂ ਵੇਖੋ';

  @override
  String get calgary => 'ਕੈਲਗਰੀ';

  @override
  String get calgaryAlberta => 'ਕੈਲਗਰੀ, ਐਲਬਰਟਾ';

  @override
  String get calgaryCommunityHub => 'ਕੈਲਗਰੀ ਭਾਈਚਾਰਕ ਹੱਬ';

  @override
  String get calgaryCommunityHubTraffic => 'ਕੈਲਗਰੀ ਭਾਈਚਾਰਕ ਹੱਬ - ਟ੍ਰੈਫਿਕ';

  @override
  String get calgaryHousingInfoTitle => 'ਕੈਲਗਰੀ ਹਾਊਸਿੰਗ ਜਾਣਕਾਰੀ';

  @override
  String get calgaryHousingPortalTitle => 'ਕੈਲਗਰੀ ਹਾਊਸਿੰਗ ਪੋਰਟਲ';

  @override
  String get calgaryHousingSnapshotTitle => 'ਕੈਲਗਰੀ ਹਾਊਸਿੰਗ ਝਲਕ';

  @override
  String get calgaryMarketVacancyRateLabel => 'ਕੈਲਗਰੀ ਮਾਰਕੀਟ ਕਿਰਾਏ ਦੀ ਖਾਲੀ ਦਰ';

  @override
  String get cancel => 'ਰੱਦ ਕਰੋ';

  @override
  String get categoryBeef => 'ਬੀਫ';

  @override
  String get categoryBreakfast => 'ਨਾਸ਼ਤਾ';

  @override
  String get categoryChicken => 'ਚਿਕਨ';

  @override
  String get categoryDairy => 'ਡੇਅਰੀ';

  @override
  String get categoryFish => 'ਮੱਛੀ';

  @override
  String get categoryOther => 'ਹੋਰ';

  @override
  String get categoryPork => 'ਪੋਰਕ';

  @override
  String categoryPostsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ਪੋਸਟਾਂ',
      one: '$countString ਪੋਸਟ',
    );
    return '$_temp0';
  }

  @override
  String get chooseTopicToPost => 'ਪੋਸਟ ਕਰਨ ਲਈ ਵਿਸ਼ਾ ਚੁਣੋ';

  @override
  String get citywideMedianPriceNote =>
      'ਇਹ ਇਮਾਰਤ ਦੀ ਕਿਸਮ ਅਨੁਸਾਰ ਸ਼ਹਿਰ-ਵਿਆਪੀ ਔਸਤ ਵਿਕਰੀ-ਕੀਮਤ ਤਬਦੀਲੀਆਂ ਹਨ। ਇਹ ਵਿਅਕਤੀਗਤ-ਜਾਇਦਾਦ ਮੁਲਾਂਕਣ ਨਹੀਂ ਹਨ।';

  @override
  String get claimJobButton => 'ਕੰਮ ਲਵੋ';

  @override
  String get claimUnassignedSubtitle =>
      'ਬਿਨਾਂ ਸੌਂਪੀ ਬੇਨਤੀ ਲਵੋ। ਪਹਿਲੀ ਸਫਲ ਦਾਅਵੇਦਾਰੀ ਜਿੱਤਦੀ ਹੈ।';

  @override
  String get claimingEllipsis => 'ਲਿਆ ਜਾ ਰਿਹਾ ਹੈ...';

  @override
  String get clientSignIn => 'ਕਲਾਇੰਟ ਸਾਈਨ ਇਨ';

  @override
  String get community => 'ਭਾਈਚਾਰਾ';

  @override
  String get communityFeeds => 'ਭਾਈਚਾਰਕ ਫੀਡਾਂ';

  @override
  String get communityForumTooltip => 'ਭਾਈਚਾਰਕ ਫੋਰਮ';

  @override
  String get communityPost => 'ਭਾਈਚਾਰਕ ਪੋਸਟ';

  @override
  String get completeButton => 'ਮੁਕੰਮਲ ਕਰੋ';

  @override
  String get confirmPasswordLabel => 'ਪਾਸਵਰਡ ਦੀ ਪੁਸ਼ਟੀ ਕਰੋ';

  @override
  String get confirmationEmailResent =>
      'ਇੱਕ ਨਵੀਂ ਪੁਸ਼ਟੀਕਰਨ ਈਮੇਲ ਭੇਜੀ ਗਈ ਹੈ। ਸਿਰਫ਼ ਨਵੀਨਤਮ ਲਿੰਕ ਵਰਤੋ, ਅਤੇ ਇਸਨੂੰ ਸਿਰਫ਼ ਇੱਕ ਵਾਰ ਖੋਲ੍ਹੋ।';

  @override
  String couldNotAssignProvider(String error) {
    return 'ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਸੌਂਪਿਆ ਨਹੀਂ ਜਾ ਸਕਿਆ: $error';
  }

  @override
  String couldNotClaimJob(String error) {
    return 'ਕੰਮ ਲਿਆ ਨਹੀਂ ਜਾ ਸਕਿਆ: $error';
  }

  @override
  String couldNotCreateAccount(String error) {
    return 'ਖਾਤਾ ਬਣਾਇਆ ਨਹੀਂ ਜਾ ਸਕਿਆ: $error';
  }

  @override
  String couldNotLaunchUrl(String url) {
    return '$url ਨਹੀਂ ਖੋਲ੍ਹਿਆ ਜਾ ਸਕਿਆ';
  }

  @override
  String couldNotLoadAdminData(String error) {
    return 'ਐਡਮਿਨ ਡਾਟਾ ਲੋਡ ਨਹੀਂ ਹੋ ਸਕਿਆ: $error';
  }

  @override
  String couldNotLoadBookings(String error) {
    return 'ਬੁਕਿੰਗਾਂ ਲੋਡ ਨਹੀਂ ਹੋ ਸਕੀਆਂ: $error';
  }

  @override
  String get couldNotLoadJobs => 'ਨੌਕਰੀਆਂ ਲੋਡ ਨਹੀਂ ਹੋ ਸਕੀਆਂ।';

  @override
  String couldNotLoadNotifications(String error) {
    return 'ਸੂਚਨਾਵਾਂ ਲੋਡ ਨਹੀਂ ਹੋ ਸਕੀਆਂ: $error';
  }

  @override
  String get couldNotLoadPosts => 'ਪੋਸਟਾਂ ਲੋਡ ਨਹੀਂ ਹੋ ਸਕੀਆਂ';

  @override
  String couldNotLoadPostsError(String error) {
    return 'ਪੋਸਟਾਂ ਲੋਡ ਨਹੀਂ ਹੋ ਸਕੀਆਂ: $error';
  }

  @override
  String couldNotLoadProfile(String error) {
    return 'ਪ੍ਰੋਫਾਈਲ ਲੋਡ ਨਹੀਂ ਹੋ ਸਕੀ: $error';
  }

  @override
  String couldNotLoadProviderPortal(String error) {
    return 'ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਪੋਰਟਲ ਲੋਡ ਨਹੀਂ ਹੋ ਸਕਿਆ: $error';
  }

  @override
  String couldNotLoadReplies(String error) {
    return 'ਜਵਾਬ ਲੋਡ ਨਹੀਂ ਹੋ ਸਕੇ: $error';
  }

  @override
  String couldNotMarkAsRead(String error) {
    return 'ਪੜ੍ਹਿਆ ਹੋਇਆ ਨਿਸ਼ਾਨ ਨਹੀਂ ਲੱਗ ਸਕਿਆ: $error';
  }

  @override
  String get couldNotOpenDirections => 'ਦਿਸ਼ਾਵਾਂ ਨਹੀਂ ਖੋਲ੍ਹੀਆਂ ਜਾ ਸਕੀਆਂ।';

  @override
  String get couldNotOpenTrafficReport =>
      'ਅਧਿਕਾਰਤ ਕੈਲਗਰੀ ਟ੍ਰੈਫਿਕ ਰਿਪੋਰਟ ਨਹੀਂ ਖੋਲ੍ਹੀ ਜਾ ਸਕੀ।';

  @override
  String couldNotPublish(String error) {
    return 'ਪ੍ਰਕਾਸ਼ਿਤ ਨਹੀਂ ਹੋ ਸਕਿਆ: $error';
  }

  @override
  String couldNotResendConfirmation(String error) {
    return 'ਪੁਸ਼ਟੀਕਰਨ ਈਮੇਲ ਦੁਬਾਰਾ ਨਹੀਂ ਭੇਜੀ ਜਾ ਸਕੀ: $error';
  }

  @override
  String couldNotSaveLoginName(String error) {
    return 'ਲੌਗਇਨ ਨਾਮ ਸੰਭਾਲਿਆ ਨਹੀਂ ਜਾ ਸਕਿਆ: $error';
  }

  @override
  String couldNotSendReply(String error) {
    return 'ਜਵਾਬ ਭੇਜਿਆ ਨਹੀਂ ਜਾ ਸਕਿਆ: $error';
  }

  @override
  String couldNotSignOut(String error) {
    return 'ਸਾਈਨ ਆਉਟ ਨਹੀਂ ਹੋ ਸਕਿਆ: $error';
  }

  @override
  String couldNotSubmitApplication(String error) {
    return 'ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਅਰਜ਼ੀ ਭੇਜੀ ਨਹੀਂ ਜਾ ਸਕੀ: $error';
  }

  @override
  String couldNotSubmitBooking(String error) {
    return 'ਬੁਕਿੰਗ ਭੇਜੀ ਨਹੀਂ ਜਾ ਸਕੀ: $error';
  }

  @override
  String couldNotUpdateBookingStatus(String error) {
    return 'ਬੁਕਿੰਗ ਸਥਿਤੀ ਅੱਪਡੇਟ ਨਹੀਂ ਹੋ ਸਕੀ: $error';
  }

  @override
  String couldNotUpdateJobStatus(String error) {
    return 'ਕੰਮ ਦੀ ਸਥਿਤੀ ਅੱਪਡੇਟ ਨਹੀਂ ਹੋ ਸਕੀ: $error';
  }

  @override
  String couldNotUpdateProfile(String error) {
    return 'ਪ੍ਰੋਫਾਈਲ ਅੱਪਡੇਟ ਨਹੀਂ ਹੋ ਸਕੀ: $error';
  }

  @override
  String couldNotUpdateProviderVerification(String error) {
    return 'ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਪ੍ਰਮਾਣਿਕਤਾ ਅੱਪਡੇਟ ਨਹੀਂ ਹੋ ਸਕੀ: $error';
  }

  @override
  String couldNotVerifyRole(String error) {
    return 'ਖਾਤੇ ਦੀ ਭੂਮਿਕਾ ਪ੍ਰਮਾਣਿਤ ਨਹੀਂ ਹੋ ਸਕੀ: $error';
  }

  @override
  String get createAccountTitle => 'ਖਾਤਾ ਬਣਾਓ';

  @override
  String get createClientAccountSubtitle =>
      'ਭਰੋਸੇਯੋਗ ਸਥਾਨਕ ਸੇਵਾਵਾਂ ਬੁੱਕ ਕਰਨ ਲਈ ਇੱਕ ਕਲਾਇੰਟ ਖਾਤਾ ਬਣਾਓ।';

  @override
  String get createPost => 'ਪੋਸਟ ਬਣਾਓ';

  @override
  String get creatingAccountEllipsis => 'ਖਾਤਾ ਬਣਾਇਆ ਜਾ ਰਿਹਾ ਹੈ...';

  @override
  String currentIncidentsShown(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ਸਰਗਰਮ ਘਟਨਾਵਾਂ ਦਿਖਾਈਆਂ ਗਈਆਂ।',
      one: '$countString ਸਰਗਰਮ ਘਟਨਾ ਦਿਖਾਈ ਗਈ।',
    );
    return '$_temp0';
  }

  @override
  String get dataSourcesLabel => 'ਡਾਟਾ ਸਰੋਤ';

  @override
  String get deals => 'ਡੀਲਾਂ';

  @override
  String get delete => 'ਮਿਟਾਓ';

  @override
  String get describeIssueHint =>
      'ਸਾਨੂੰ ਦੱਸੋ ਕਿ ਕੀ ਮੁਰੰਮਤ ਜਾਂ ਪੂਰਾ ਕਰਨ ਦੀ ਲੋੜ ਹੈ।';

  @override
  String get describeIssueLabel => 'ਸਮੱਸਿਆ ਦਾ ਵਰਣਨ ਕਰੋ';

  @override
  String get describeIssueValidator => 'ਸਮੱਸਿਆ ਦਾ ਵਰਣਨ ਕਰੋ';

  @override
  String get describeServiceSubtitle =>
      'ਕੈਲਗਰੀ ਵਿੱਚ ਤੁਹਾਨੂੰ ਲੋੜੀਂਦੀ ਸੇਵਾ ਦਾ ਵਰਣਨ ਕਰੋ।';

  @override
  String get developmentNearYouTitle => 'ਤੁਹਾਡੇ ਨੇੜੇ ਵਿਕਾਸ';

  @override
  String get dining => 'ਖਾਣ-ਪੀਣ';

  @override
  String get diningPost => 'ਖਾਣ-ਪੀਣ ਦੀ ਪੋਸਟ';

  @override
  String get diningPostsTitle => 'ਖਾਣ-ਪੀਣ ਦੀਆਂ ਪੋਸਟਾਂ';

  @override
  String get discussionFallback => 'ਚਰਚਾ';

  @override
  String discussionsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ਚਰਚਾਵਾਂ',
      one: '$countString ਚਰਚਾ',
    );
    return '$_temp0';
  }

  @override
  String get displayNameLabel => 'ਦਿਖਾਉਣ ਵਾਲਾ ਨਾਮ';

  @override
  String get diyHome => 'DIY ਅਤੇ ਘਰ';

  @override
  String get diyHomePost => 'DIY ਅਤੇ ਘਰ ਦੀ ਪੋਸਟ';

  @override
  String get diyHomeTitle => 'DIY ਅਤੇ ਘਰ';

  @override
  String get edit => 'ਸੋਧੋ';

  @override
  String get emailAddressLabel => 'ਈਮੇਲ ਪਤਾ';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get emailLabel => 'ਈਮੇਲ';

  @override
  String get enterAtLeast3Characters => 'ਘੱਟੋ-ਘੱਟ 3 ਅੱਖਰ ਦਰਜ ਕਰੋ।';

  @override
  String get enterDisplayName => 'ਐਪ ਵਿੱਚ ਦਿਖਾਉਣ ਲਈ ਇੱਕ ਨਾਮ ਦਰਜ ਕਰੋ।';

  @override
  String get enterEmailAddress => 'ਆਪਣਾ ਈਮੇਲ ਪਤਾ ਦਰਜ ਕਰੋ';

  @override
  String get enterEmailAndPassword => 'ਈਮੇਲ ਅਤੇ ਪਾਸਵਰਡ ਦੋਵੇਂ ਦਰਜ ਕਰੋ।';

  @override
  String get enterEmailFirstResend =>
      'ਪਹਿਲਾਂ ਈਮੇਲ ਪਤਾ ਦਰਜ ਕਰੋ, ਫਿਰ ਪੁਸ਼ਟੀਕਰਨ ਦੁਬਾਰਾ ਭੇਜੋ।';

  @override
  String get enterFirstName => 'ਆਪਣਾ ਪਹਿਲਾ ਨਾਮ ਦਰਜ ਕਰੋ।';

  @override
  String get enterFullName => 'ਆਪਣਾ ਪੂਰਾ ਨਾਮ ਦਰਜ ਕਰੋ';

  @override
  String get enterLastName => 'ਆਪਣਾ ਆਖਰੀ ਨਾਮ ਦਰਜ ਕਰੋ।';

  @override
  String get enterLocation => 'ਆਪਣਾ ਟਿਕਾਣਾ ਦਰਜ ਕਰੋ';

  @override
  String get enterLoginName => 'ਇੱਕ ਲੌਗਇਨ ਨਾਮ ਦਰਜ ਕਰੋ';

  @override
  String get enterNeighbourhood => 'ਇੱਕ ਆਂਢ-ਗੁਆਂਢ ਦਰਜ ਕਰੋ।';

  @override
  String get enterPhoneNumber => 'ਇੱਕ ਫ਼ੋਨ ਨੰਬਰ ਦਰਜ ਕਰੋ';

  @override
  String get enterServiceCategory => 'ਇੱਕ ਸੇਵਾ ਸ਼੍ਰੇਣੀ ਦਰਜ ਕਰੋ';

  @override
  String get enterSignupDetails =>
      'ਆਪਣਾ ਪੂਰਾ ਨਾਮ, ਫ਼ੋਨ ਨੰਬਰ, ਈਮੇਲ, ਅਤੇ ਪਾਸਵਰਡ ਦਰਜ ਕਰੋ।';

  @override
  String get enterValidEmailAddress => 'ਇੱਕ ਵੈਧ ਈਮੇਲ ਪਤਾ ਦਰਜ ਕਰੋ';

  @override
  String get enterYourNameHint => 'ਆਪਣਾ ਨਾਮ ਦਰਜ ਕਰੋ';

  @override
  String estimatedAmountValue(String amount) {
    return 'ਅਨੁਮਾਨਿਤ ਰਕਮ: $amount';
  }

  @override
  String get expiryDate => 'ਮਿਆਦ ਪੁੱਗਣ ਦੀ ਮਿਤੀ';

  @override
  String get exploreNeighbourCare => 'NeighbourCare ਦੀ ਪੜਚੋਲ ਕਰੋ';

  @override
  String get exploreSubtitle =>
      'ਲਾਭਦਾਇਕ ਕੈਲਗਰੀ ਜਾਣਕਾਰੀ, ਸਥਾਨਕ ਸੰਪਰਕ, ਅਤੇ ਰੋਜ਼ਾਨਾ ਸਰੋਤ ਇੱਕੋ ਥਾਂ \'ਤੇ।';

  @override
  String get filter => 'ਫਿਲਟਰ';

  @override
  String get filterAll => 'ਸਾਰੇ';

  @override
  String get filterLabelPrefix => 'ਫਿਲਟਰ: ';

  @override
  String get findAssessedValueNote =>
      'ਕੈਲਗਰੀ ਦੀ ਖਾਸ ਜਾਇਦਾਦ ਲਈ ਸ਼ਹਿਰ ਦਾ ਅੰਦਾਜ਼ਨ ਮੁੱਲ ਲੱਭੋ।';

  @override
  String get firstNameLabel => 'ਪਹਿਲਾ ਨਾਮ';

  @override
  String get fontSizeLarge => 'ਵੱਡਾ';

  @override
  String get fontSizeNormal => 'ਸਾਧਾਰਨ';

  @override
  String get fontSizeSmall => 'ਛੋਟਾ';

  @override
  String get forceAcceptButton => 'ਜ਼ਬਰਦਸਤੀ ਸਵੀਕਾਰ ਕਰੋ';

  @override
  String get forceDeclineButton => 'ਜ਼ਬਰਦਸਤੀ ਅਸਵੀਕਾਰ ਕਰੋ';

  @override
  String get fullNameHint => 'ਤੁਹਾਡਾ ਪਹਿਲਾ ਅਤੇ ਆਖਰੀ ਨਾਮ';

  @override
  String get fullNameLabel => 'ਪੂਰਾ ਨਾਮ';

  @override
  String get getDirections => 'ਦਿਸ਼ਾਵਾਂ ਲਵੋ';

  @override
  String groceryDealsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ਕਰਿਆਨੇ ਦੀਆਂ ਡੀਲਾਂ',
      one: '$countString ਕਰਿਆਨੇ ਦੀ ਡੀਲ',
    );
    return '$_temp0';
  }

  @override
  String get heroSubtitle =>
      'ਸਥਾਨਕ ਖ਼ਬਰਾਂ, ਟ੍ਰੈਫਿਕ, ਬੱਚਤਾਂ, ਹਾਊਸਿੰਗ, ਅਤੇ ਗੁਆਂਢੀਆਂ ਵੱਲੋਂ ਅੱਪਡੇਟ।';

  @override
  String get heroTitle => 'ਤੁਹਾਡਾ ਕੈਲਗਰੀ ਭਾਈਚਾਰਾ, ਇੱਕੋ ਥਾਂ \'ਤੇ।';

  @override
  String get hideReplies => 'ਜਵਾਬ ਲੁਕਾਓ';

  @override
  String get home => 'ਹੋਮ';

  @override
  String get homeRepairDiyHelp => 'ਘਰ ਦੀ ਮੁਰੰਮਤ / DIY ਮਦਦ';

  @override
  String get homeServiceFallback => 'ਘਰੇਲੂ ਸੇਵਾ';

  @override
  String get housing => 'ਹਾਊਸਿੰਗ';

  @override
  String get housingAndDevelopment => 'ਹਾਊਸਿੰਗ ਅਤੇ ਵਿਕਾਸ';

  @override
  String get housingDataRefreshed => 'ਹਾਊਸਿੰਗ ਡਾਟਾ ਤਾਜ਼ਾ ਹੋਇਆ।';

  @override
  String get housingDataSourcesText =>
      'ਹਾਊਸਿੰਗ ਅੰਕੜੇ ਕੈਲਗਰੀ ਸ਼ਹਿਰ ਦੀ ਹਾਊਸਿੰਗ ਖੋਜ ਅਤੇ CMHC ਮਾਰਕੀਟ ਜਾਣਕਾਰੀ ਤੋਂ ਲਏ ਗਏ ਹਨ। ਜਾਇਦਾਦ ਮੁਲਾਂਕਣ ਅਤੇ ਵਿਕਾਸ ਵੇਰਵੇ ਕੈਲਗਰੀ ਸ਼ਹਿਰ ਦੇ ਅਧਿਕਾਰਤ ਟੂਲਾਂ ਰਾਹੀਂ ਦਿੱਤੇ ਜਾਂਦੇ ਹਨ।';

  @override
  String get housingInfoDescription =>
      'ਕਿਰਾਏ-ਮਾਰਕੀਟ ਰੁਝਾਨ, ਹਾਲੀਆ ਘਰ-ਕੀਮਤ ਤਬਦੀਲੀਆਂ, ਅਧਿਕਾਰਤ ਜਾਇਦਾਦ ਮੁਲਾਂਕਣ, ਅਤੇ ਆਉਣ ਵਾਲੀ ਵਿਕਾਸ ਸਰਗਰਮੀ ਦੀ ਪੜਚੋਲ ਕਰੋ।';

  @override
  String get housingTypeApartment => 'ਅਪਾਰਟਮੈਂਟ';

  @override
  String get housingTypeDetached => 'ਵੱਖਰਾ ਘਰ';

  @override
  String get housingTypeRowTownhouse => 'ਰੋਅ / ਟਾਊਨਹਾਊਸ';

  @override
  String get housingTypeSemiDetached => 'ਸੈਮੀ-ਡਿਟੈਚਡ';

  @override
  String get jobAlreadyClaimed =>
      'ਇਹ ਕੰਮ ਪਹਿਲਾਂ ਹੀ ਕਿਸੇ ਹੋਰ ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਦੁਆਰਾ ਲਿਆ ਜਾ ਚੁੱਕਾ ਹੈ। ਸੂਚੀ ਹੁਣ ਤਾਜ਼ਾ ਹੋਵੇਗੀ।';

  @override
  String get jobClaimedSuccess => 'ਕੰਮ ਸਫਲਤਾਪੂਰਵਕ ਲਿਆ ਗਿਆ।';

  @override
  String get jobListings => 'ਨੌਕਰੀ ਸੂਚੀਆਂ';

  @override
  String jobOpeningsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ਖਾਲੀ ਥਾਵਾਂ',
      one: '$countString ਖਾਲੀ ਥਾਂ',
    );
    return '$_temp0';
  }

  @override
  String jobStatusChanged(String status) {
    return 'ਕੰਮ ਦੀ ਸਥਿਤੀ $status ਵਿੱਚ ਬਦਲੀ ਗਈ।';
  }

  @override
  String get jobs => 'ਨੌਕਰੀਆਂ';

  @override
  String get joinConversation => 'ਗੱਲਬਾਤ ਵਿੱਚ ਸ਼ਾਮਲ ਹੋਵੋ';

  @override
  String get joinNeighbourCare => 'NeighbourCare ਵਿੱਚ ਸ਼ਾਮਲ ਹੋਵੋ';

  @override
  String get lastNameLabel => 'ਆਖਰੀ ਨਾਮ';

  @override
  String lastRefreshedPrefix(String time) {
    return 'ਆਖਰੀ ਤਾਜ਼ਗੀ: $time';
  }

  @override
  String get listLabel => 'ਸੂਚੀ';

  @override
  String get live => 'ਲਾਈਵ';

  @override
  String get liveDealsSubtitle =>
      'ਭਾਗ ਲੈਣ ਵਾਲੇ ਸਥਾਨਕ ਸਟੋਰਾਂ ਦੀਆਂ ਲਾਈਵ ਡੀਲਾਂ। ਤਾਜ਼ਾ ਕਰਨ ਲਈ ਹੇਠਾਂ ਖਿੱਚੋ।';

  @override
  String get loading => 'ਲੋਡ ਹੋ ਰਿਹਾ ਹੈ...';

  @override
  String get loadingDeals => 'ਡੀਲਾਂ ਲੋਡ ਹੋ ਰਹੀਆਂ ਹਨ...';

  @override
  String get loadingDiscussions => 'ਚਰਚਾਵਾਂ ਲੋਡ ਹੋ ਰਹੀਆਂ ਹਨ...';

  @override
  String get loadingJobs => 'ਨੌਕਰੀਆਂ ਲੋਡ ਹੋ ਰਹੀਆਂ ਹਨ...';

  @override
  String get loadingLiveUpdates => 'ਲਾਈਵ ਅੱਪਡੇਟ ਲੋਡ ਹੋ ਰਹੇ ਹਨ...';

  @override
  String get loadingPosts => 'ਪੋਸਟਾਂ ਲੋਡ ਹੋ ਰਹੀਆਂ ਹਨ...';

  @override
  String get loadingTrafficUpdates => 'ਟ੍ਰੈਫਿਕ ਅੱਪਡੇਟ ਲੋਡ ਹੋ ਰਹੇ ਹਨ...';

  @override
  String get localSavings => 'ਸਥਾਨਕ ਬੱਚਤਾਂ';

  @override
  String localSavingsCouldNotUpdate(String error) {
    return 'ਲੋਕਲ ਸੇਵਿੰਗਜ਼ ਅੱਪਡੇਟ ਨਹੀਂ ਹੋ ਸਕੀ:\n\n$error';
  }

  @override
  String get localUpdateLabel => 'ਸਥਾਨਕ ਅੱਪਡੇਟ';

  @override
  String get locationHint => 'ਆਂਢ-ਗੁਆਂਢ ਜਾਂ ਡਾਕ ਕੋਡ';

  @override
  String get locationLabel => 'ਟਿਕਾਣਾ';

  @override
  String get locationRadiusNote =>
      'ਟਿਕਾਣਾ ਵਿਕਲਪਿਕ ਹੋਵੇਗਾ। ਸਮਰੱਥ ਹੋਣ \'ਤੇ, ਤੁਸੀਂ 2 ਕਿਲੋਮੀਟਰ, 5 ਕਿਲੋਮੀਟਰ, ਜਾਂ ਮੂਲ 10 ਕਿਲੋਮੀਟਰ ਖੋਜ ਘੇਰਾ ਚੁਣ ਸਕਦੇ ਹੋ।';

  @override
  String get locationUnavailable => 'ਟਿਕਾਣਾ ਉਪਲਬਧ ਨਹੀਂ';

  @override
  String locationValue(String location) {
    return 'ਟਿਕਾਣਾ: $location';
  }

  @override
  String get loginNameHint => 'ਹੋਰ ਮੈਂਬਰ ਤੁਹਾਨੂੰ ਕਿਵੇਂ ਵੇਖਣਗੇ';

  @override
  String get loginNameLabel => 'ਲੌਗਇਨ ਨਾਮ';

  @override
  String get loginNameMinLength =>
      'ਲੌਗਇਨ ਨਾਮ ਘੱਟੋ-ਘੱਟ 3 ਅੱਖਰਾਂ ਦਾ ਹੋਣਾ ਚਾਹੀਦਾ ਹੈ';

  @override
  String get loginNameTaken =>
      'ਇਹ ਲੌਗਇਨ ਨਾਮ ਪਹਿਲਾਂ ਹੀ ਲਿਆ ਜਾ ਚੁੱਕਾ ਹੈ। ਕਿਰਪਾ ਕਰਕੇ ਕੋਈ ਹੋਰ ਚੁਣੋ।';

  @override
  String get mapLabel => 'ਨਕਸ਼ਾ';

  @override
  String get markAsReadTooltip => 'ਪੜ੍ਹਿਆ ਹੋਇਆ ਨਿਸ਼ਾਨ ਲਗਾਓ';

  @override
  String get markCompletedButton => 'ਮੁਕੰਮਲ ਵਜੋਂ ਨਿਸ਼ਾਨ ਲਗਾਓ';

  @override
  String get marketMetricsSubtitle => 'ਮਾਰਕੀਟ ਮੈਟ੍ਰਿਕਸ ਅਤੇ ਵਿਕਾਸ ਪਰਮਿਟ';

  @override
  String get marketPriceTrendsTitle => 'ਮਾਰਕੀਟ ਕੀਮਤ ਰੁਝਾਨ';

  @override
  String get marketplace => 'ਬਾਜ਼ਾਰ';

  @override
  String get marketplaceSubtitle => 'ਖਰੀਦੋ, ਵੇਚੋ, ਅਤੇ ਸਾਂਝਾ ਕਰੋ';

  @override
  String get medianHomePricesTitle => 'ਇਮਾਰਤ ਦੀ ਕਿਸਮ ਅਨੁਸਾਰ ਔਸਤ ਘਰ ਕੀਮਤਾਂ';

  @override
  String get memberFallback => 'ਮੈਂਬਰ';

  @override
  String get myAssignedJobsTitle => 'ਮੇਰੇ ਸੌਂਪੇ ਗਏ ਕੰਮ';

  @override
  String get myBookings => 'ਮੇਰੀਆਂ ਬੁਕਿੰਗਾਂ';

  @override
  String get myProfileTitle => 'ਮੇਰੀ ਪ੍ਰੋਫਾਈਲ';

  @override
  String get neighbourCareCalgaryTitle => 'NeighbourCare ਕੈਲਗਰੀ';

  @override
  String get neighbourCareCommunity => 'NeighbourCare ਭਾਈਚਾਰਾ';

  @override
  String get neighbourCareServicesTitle => 'NeighbourCare ਸੇਵਾਵਾਂ';

  @override
  String get neighbourhoodExampleHint => 'ਉਦਾਹਰਨ: Beltline';

  @override
  String get neighbourhoodHint => 'ਉਦਾਹਰਨ ਲਈ: Beltline ਜਾਂ Tuscany';

  @override
  String get neighbourhoodLabel => 'ਆਂਢ-ਗੁਆਂਢ';

  @override
  String get neighbourhoodOptionalLabel => 'ਕੈਲਗਰੀ ਆਂਢ-ਗੁਆਂਢ (ਵਿਕਲਪਿਕ)';

  @override
  String get newToNeighbourCareSignUp =>
      'NeighbourCare ਲਈ ਨਵੇਂ ਹੋ? ਸਾਈਨ ਅੱਪ ਕਰੋ';

  @override
  String get newestApplicationsNote =>
      'ਨਵੀਨਤਮ ਕੈਲਗਰੀ-ਵਿਆਪੀ ਅਰਜ਼ੀਆਂ ਇੱਥੇ ਪਹਿਲਾਂ ਦਿਖਾਈ ਦੇਣਗੀਆਂ।';

  @override
  String get news => 'ਖ਼ਬਰਾਂ';

  @override
  String get noActiveDealsMatch =>
      'ਇਸ ਖੋਜ ਜਾਂ ਸ਼੍ਰੇਣੀ ਨਾਲ ਕੋਈ ਸਰਗਰਮ ਡੀਲ ਮੇਲ ਨਹੀਂ ਖਾਂਦੀ।';

  @override
  String get noActiveIncidents => 'ਕੋਈ ਸਰਗਰਮ ਘਟਨਾਵਾਂ ਨਹੀਂ';

  @override
  String get noActiveIncidentsListed => 'ਕੋਈ ਸਰਗਰਮ ਘਟਨਾਵਾਂ ਸੂਚੀਬੱਧ ਨਹੀਂ ਹਨ।';

  @override
  String get noBookingsYet =>
      'ਅਜੇ ਤੱਕ ਕੋਈ ਬੁਕਿੰਗ ਨਹੀਂ। ਆਪਣੀ ਪਹਿਲੀ ਸੇਵਾ ਬੇਨਤੀ ਭੇਜੋ।';

  @override
  String get noClaimedJobsYet => 'ਤੁਸੀਂ ਅਜੇ ਤੱਕ ਕੋਈ ਕੰਮ ਨਹੀਂ ਲਿਆ।';

  @override
  String get noCommunityPosts => 'ਅਜੇ ਤੱਕ ਕੋਈ ਭਾਈਚਾਰਕ ਪੋਸਟਾਂ ਨਹੀਂ।';

  @override
  String get noCurrentDeals => 'ਕੋਈ ਮੌਜੂਦਾ ਡੀਲਾਂ ਨਹੀਂ';

  @override
  String get noCurrentTrafficIncidents =>
      'ਕੋਈ ਸਰਗਰਮ ਟ੍ਰੈਫਿਕ ਘਟਨਾਵਾਂ ਸੂਚੀਬੱਧ ਨਹੀਂ ਹਨ।';

  @override
  String get noDealsAvailable => 'ਇਸ ਸਮੇਂ ਕੋਈ ਡੀਲਾਂ ਉਪਲਬਧ ਨਹੀਂ ਹਨ।';

  @override
  String get noEmailAvailable => 'ਕੋਈ ਈਮੇਲ ਉਪਲਬਧ ਨਹੀਂ';

  @override
  String get noJobsFound => 'ਕੋਈ ਨੌਕਰੀਆਂ ਨਹੀਂ ਮਿਲੀਆਂ।';

  @override
  String get noNotifications => 'ਕੋਈ ਸੂਚਨਾਵਾਂ ਨਹੀਂ।';

  @override
  String get noOpenRequests => 'ਇਸ ਸਮੇਂ ਕੋਈ ਖੁੱਲ੍ਹੀਆਂ ਬੇਨਤੀਆਂ ਉਪਲਬਧ ਨਹੀਂ ਹਨ।';

  @override
  String get noPostsShareFirst =>
      'ਅਜੇ ਤੱਕ ਕੋਈ ਪੋਸਟ ਨਹੀਂ। ਸਾਂਝਾ ਕਰਨ ਵਾਲੇ ਪਹਿਲੇ ਬਣੋ।';

  @override
  String get noProviderApplicationsFound =>
      'ਕੋਈ ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਅਰਜ਼ੀਆਂ ਨਹੀਂ ਮਿਲੀਆਂ।';

  @override
  String get noProviderProfileLinked =>
      'ਇਸ ਖਾਤੇ ਨਾਲ ਕੋਈ ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਪ੍ਰੋਫਾਈਲ ਜੁੜੀ ਨਹੀਂ ਹੈ। ਇਸ ਵਰਤੋਂਕਾਰ ਦੇ Auth UUID ਦੀ ਵਰਤੋਂ ਕਰਕੇ ਇੱਕ providers ਕਤਾਰ ਬਣਾਓ।';

  @override
  String get noRecentDiscussions => 'ਕੋਈ ਹਾਲੀਆ ਚਰਚਾਵਾਂ ਨਹੀਂ।';

  @override
  String get noRecentPosts => 'ਕੋਈ ਹਾਲੀਆ ਪੋਸਟਾਂ ਨਹੀਂ।';

  @override
  String get noRepliesYet => 'ਅਜੇ ਤੱਕ ਕੋਈ ਜਵਾਬ ਨਹੀਂ।';

  @override
  String get noVerifiedPriceReductions =>
      'ਇਸ ਸਮੇਂ ਕੋਈ ਪ੍ਰਮਾਣਿਤ ਕੀਮਤ ਘਟਾਓ ਸਰਗਰਮ ਨਹੀਂ ਹੈ।';

  @override
  String get notAvailable => 'ਉਪਲਬਧ ਨਹੀਂ';

  @override
  String get notProvided => 'ਪ੍ਰਦਾਨ ਨਹੀਂ ਕੀਤਾ';

  @override
  String notesValue(String notes) {
    return 'ਨੋਟਸ: $notes';
  }

  @override
  String get notificationFallback => 'ਸੂਚਨਾ';

  @override
  String get notificationsTitle => 'ਸੂਚਨਾਵਾਂ';

  @override
  String get officialSourceLabel => 'ਅਧਿਕਾਰਤ ਸਰੋਤ';

  @override
  String get openCalgaryDevelopmentMap => 'ਕੈਲਗਰੀ ਵਿਕਾਸ ਨਕਸ਼ਾ ਖੋਲ੍ਹੋ';

  @override
  String get openCalgaryMyTax => 'ਕੈਲਗਰੀ ਸ਼ਹਿਰ ਦਾ myTax ਖੋਲ੍ਹੋ';

  @override
  String get openCityTrafficReport => 'ਸ਼ਹਿਰ ਦੀ ਟ੍ਰੈਫਿਕ ਰਿਪੋਰਟ ਖੋਲ੍ਹੋ';

  @override
  String get openRequestsTitle => 'ਖੁੱਲ੍ਹੀਆਂ ਬੇਨਤੀਆਂ';

  @override
  String get optionsTooltip => 'ਵਿਕਲਪ';

  @override
  String get otherLocalAssistance => 'ਹੋਰ ਸਥਾਨਕ ਸਹਾਇਤਾ';

  @override
  String get passwordHelperText => 'ਘੱਟੋ-ਘੱਟ 8 ਅੱਖਰ ਵਰਤੋ।';

  @override
  String get passwordLabel => 'ਪਾਸਵਰਡ';

  @override
  String get passwordMinLength => 'ਪਾਸਵਰਡ ਵਿੱਚ ਘੱਟੋ-ਘੱਟ 6 ਅੱਖਰ ਹੋਣੇ ਚਾਹੀਦੇ ਹਨ।';

  @override
  String get passwordMinLength8 =>
      'ਪਾਸਵਰਡ ਘੱਟੋ-ਘੱਟ 8 ਅੱਖਰਾਂ ਦਾ ਹੋਣਾ ਚਾਹੀਦਾ ਹੈ।';

  @override
  String get passwordTooShort => 'ਘੱਟੋ-ਘੱਟ 8 ਅੱਖਰ ਵਰਤੋ';

  @override
  String get passwordsDoNotMatch => 'ਪਾਸਵਰਡ ਮੇਲ ਨਹੀਂ ਖਾਂਦੇ';

  @override
  String get permitFeedComingNext => 'ਪਰਮਿਟ ਫੀਡ ਅਗਲੇ ਵਿੱਚ ਆ ਰਹੀ ਹੈ';

  @override
  String get phoneNumberLabel => 'ਫ਼ੋਨ ਨੰਬਰ';

  @override
  String get postFallback => 'ਪੋਸਟ';

  @override
  String get posted => 'ਪੋਸਟ ਕੀਤਾ';

  @override
  String postedOn(String date) {
    return '$date ਨੂੰ ਪੋਸਟ ਕੀਤਾ';
  }

  @override
  String get preferredTimeHint => 'ਅੱਜ ਸ਼ਾਮ 5-7 ਵਜੇ ਜਾਂ ਸ਼ਨੀਵਾਰ ਸਵੇਰ';

  @override
  String get preferredTimeLabel => 'ਪਸੰਦੀਦਾ ਸਮਾਂ';

  @override
  String preferredTimeValue(String time) {
    return 'ਪਸੰਦੀਦਾ ਸਮਾਂ: $time';
  }

  @override
  String get price => 'ਕੀਮਤ';

  @override
  String get pricesTermsMayChange =>
      'ਕੀਮਤਾਂ, ਸਟਾਕ, ਮੈਂਬਰਸ਼ਿਪ ਲੋੜਾਂ, ਅਤੇ ਪ੍ਰੋਮੋਸ਼ਨ ਸ ਼ਰਤਾਂ ਬਦਲ ਸਕਦੀਆਂ ਹਨ। ਜਾਣ ਤੋਂ ਪਹਿਲਾਂ ਸਟੋਰ ਨਾਲ ਸਿੱਧਾ ਪੁਸ਼ਟੀ ਕਰੋ।';

  @override
  String get privacyReminderText =>
      'ਘਰ ਦੇ ਪਤੇ, ਚਿਹਰੇ, ਲਾਇਸੰਸ ਪਲੇਟਾਂ, ਫ਼ੋਨ ਨੰਬਰ, ਜਾਂ ਹੋਰ ਨਿੱਜੀ ਜਾਣਕਾਰੀ ਸ਼ਾਮਲ ਨਾ ਕਰੋ।';

  @override
  String get profileUpdatedSuccess => 'ਪ੍ਰੋਫਾਈਲ ਸਫਲਤਾਪੂਰਵਕ ਅੱਪਡੇਟ ਕੀਤੀ ਗਈ।';

  @override
  String get providerApplicationTitle => 'ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਅਰਜ਼ੀ';

  @override
  String get providerApprovalTitle => 'ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਮਨਜ਼ੂਰੀ';

  @override
  String get providerApprovedSuccess => 'ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਸਫਲਤਾਪੂਰਵਕ ਮਨਜ਼ੂਰ ਹੋਇਆ।';

  @override
  String providerIdFallback(String id) {
    return 'ਸੇਵਾ ਪ੍ਰਦਾਤਾ $id';
  }

  @override
  String get providerLabelPrefix => 'ਸੇਵਾ ਪ੍ਰਦਾਤਾ: ';

  @override
  String get providerNotVerified =>
      'ਤੁਹਾਡੀ ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਪ੍ਰੋਫਾਈਲ ਅਜੇ ਪ੍ਰਮਾਣਿਤ ਨਹੀਂ ਹੋਈ। ਕਿਸੇ ਐਡਮਿਨ ਨੂੰ pvsc_verified ਨੂੰ true ਸੈੱਟ ਕਰਨ ਲਈ ਕਹੋ।';

  @override
  String get providerPortal => 'ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਪੋਰਟਲ';

  @override
  String get providerPortalTitle => 'ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਪੋਰਟਲ';

  @override
  String get providerPortalTooltip => 'ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਪੋਰਟਲ';

  @override
  String get providerVerificationRemoved =>
      'ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਦੀ ਪ੍ਰਮਾਣਿਕਤਾ ਹਟਾ ਦਿੱਤੀ ਗਈ।';

  @override
  String get publishReportButton => 'ਰਿਪੋਰਟ ਪ੍ਰਕਾਸ਼ਿਤ ਕਰੋ';

  @override
  String get publishingEllipsis => 'ਪ੍ਰਕਾਸ਼ਿਤ ਹੋ ਰਿਹਾ ਹੈ…';

  @override
  String get rankedByVerifiedSavings =>
      'ਪ੍ਰਮਾਣਿਤ ਬੱਚਤ ਪ੍ਰਤੀਸ਼ਤ ਅਨੁਸਾਰ ਦਰਜਾਬੰਦੀ';

  @override
  String ratingValue(String rating) {
    return 'ਰੇਟਿੰਗ: $rating';
  }

  @override
  String get refreshBookings => 'ਬੁਕਿੰਗਾਂ ਤਾਜ਼ਾ ਕਰੋ';

  @override
  String get refreshTooltip => 'ਤਾਜ਼ਾ ਕਰੋ';

  @override
  String get refreshTraffic => 'ਟ੍ਰੈਫਿਕ ਤਾਜ਼ਾ ਕਰੋ';

  @override
  String get regularPrice => 'ਆਮ ਕੀਮਤ';

  @override
  String regularPriceValue(String price) {
    return 'ਆਮ ਕੀਮਤ: $price';
  }

  @override
  String get rentalAvailabilityChangesNote =>
      'ਕੈਲਗਰੀ ਕਿਰਾਏ ਦੀ ਉਪਲਬਧਤਾ ਅਤੇ ਹਾਲੀਆ ਔਸਤ ਘਰ-ਕੀਮਤ ਤਬਦੀਲੀਆਂ।';

  @override
  String get rentalMarketVacancyRateTitle => 'ਕਿਰਾਏ ਮਾਰਕੀਟ ਖਾਲੀ ਦਰ';

  @override
  String get rentalVacancyRateLabel => 'ਕਿਰਾਏ ਦੀ ਖਾਲੀ ਦਰ';

  @override
  String get replyAction => 'ਜਵਾਬ ਦਿਓ';

  @override
  String get reportLocalConditionsTitle => 'ਸਥਾਨਕ ਹਾਲਾਤ ਦੀ ਰਿਪੋਰਟ ਕਰੋ';

  @override
  String get requestHelp => 'ਮਦਦ ਦੀ ਬੇਨਤੀ ਕਰੋ';

  @override
  String requestedFromCommunityPost(String title) {
    return 'ਭਾਈਚਾਰਕ ਪੋਸਟ ਤੋਂ ਬੇਨਤੀ ਕੀਤੀ: $title\n\nਕਿਰਪਾ ਕਰਕੇ ਲੋੜੀਂਦੀ ਮਦਦ ਦਾ ਵਰਣਨ ਕਰੋ:';
  }

  @override
  String get resendConfirmationEmail => 'ਪੁਸ਼ਟੀਕਰਨ ਈਮੇਲ ਦੁਬਾਰਾ ਭੇਜੋ';

  @override
  String get retry => 'ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get save => 'ਸੰਭਾਲੋ';

  @override
  String get saveOnGroceriesTitle => 'ਕੈਲਗਰੀ ਵਿੱਚ ਕਰਿਆਨੇ \'ਤੇ ਬੱਚਤ ਕਰੋ';

  @override
  String get saveProfileButton => 'ਪ੍ਰੋਫਾਈਲ ਸੰਭਾਲੋ';

  @override
  String get savingEllipsis => 'ਸੰਭਾਲਿਆ ਜਾ ਰਿਹਾ ਹੈ...';

  @override
  String get savings => 'ਬੱਚਤਾਂ';

  @override
  String get search => 'ਖੋਜੋ';

  @override
  String get searchByProductOrStore => 'ਉਤਪਾਦ ਜਾਂ ਸਟੋਰ ਦੁਆਰਾ ਖੋਜੋ';

  @override
  String get serviceCategoryHint => 'ਪਲੰਬਿੰਗ, ਭੱਠੀ, ਬਰਫ਼ ਹਟਾਉਣਾ...';

  @override
  String get serviceCategoryLabel => 'ਸੇਵਾ ਸ਼੍ਰੇਣੀ';

  @override
  String get serviceFallback => 'ਸੇਵਾ';

  @override
  String get shareAnUpdate => 'ਇੱਕ ਅੱਪਡੇਟ ਸਾਂਝਾ ਕਰੋ';

  @override
  String get shareFactualConditionsHint => 'ਅਸਲੀ, ਮੌਜੂਦਾ ਹਾਲਾਤ ਸਾਂਝੇ ਕਰੋ।';

  @override
  String get shareLocalConditionsWarning =>
      'ਮੌਜੂਦਾ ਸਥਾਨਕ ਹਾਲਾਤ ਸਾਂਝੇ ਕਰੋ। ਤੁਰੰਤ ਐਮਰਜੈਂਸੀ ਲਈ, 911 \'ਤੇ ਕਾਲ ਕਰੋ।';

  @override
  String get showList => 'ਸੂਚੀ ਵਿਖਾਓ';

  @override
  String get showMap => 'ਨਕਸ਼ਾ ਵਿਖਾਓ';

  @override
  String get signIn => 'ਸਾਈਨ ਇਨ';

  @override
  String get signInAsProvider => 'ਕਿਰਪਾ ਕਰਕੇ ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਵਜੋਂ ਸਾਈਨ ਇਨ ਕਰੋ।';

  @override
  String get signInBeforeBooking =>
      'ਬੁਕਿੰਗ ਭੇਜਣ ਤੋਂ ਪਹਿਲਾਂ ਕਿਰਪਾ ਕਰਕੇ ਸਾਈਨ ਇਨ ਕਰੋ।';

  @override
  String get signInBeforePosting =>
      'ਪੋਸਟ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਕਿਰਪਾ ਕਰਕੇ ਸਾਈਨ ਇਨ ਕਰੋ।';

  @override
  String get signInBeforeUpdatingProfile =>
      'ਆਪਣੀ ਪ੍ਰੋਫਾਈਲ ਅੱਪਡੇਟ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਕਿਰਪਾ ਕਰਕੇ ਸਾਈਨ ਇਨ ਕਰੋ।';

  @override
  String signInFailed(String error) {
    return 'ਸਾਈਨ-ਇਨ ਅਸਫਲ: $error';
  }

  @override
  String get signInRequired => 'ਸਾਈਨ ਇਨ ਲੋੜੀਂਦਾ ਹੈ';

  @override
  String get signInSubtitle =>
      'ਘਰੇਲੂ ਸੇਵਾਵਾਂ ਬੁੱਕ ਕਰਨ ਅਤੇ ਪ੍ਰਬੰਧਿਤ ਕਰਨ ਲਈ ਸਾਈਨ ਇਨ ਕਰੋ।';

  @override
  String get signInToCreatePost =>
      'ਭਾਈਚਾਰਕ ਪੋਸਟ ਬਣਾਉਣ ਤੋਂ ਪਹਿਲਾਂ ਕਲਾਇੰਟ ਜਾਂ ਸੇਵਾ ਪ੍ਰਦਾਤਾ ਵਜੋਂ ਸਾਈਨ ਇਨ ਕਰੋ।';

  @override
  String get signInToReply => 'ਜਵਾਬ ਦੇਣ ਲਈ ਸਾਈਨ ਇਨ ਕਰੋ।';

  @override
  String get signInToRequestHelp =>
      'ਭਾਈਚਾਰਕ ਪੋਸਟ ਤੋਂ ਮਦਦ ਦੀ ਬੇਨਤੀ ਕਰਨ ਲਈ ਸਾਈਨ ਇਨ ਕਰੋ।';

  @override
  String get signInToViewBookings =>
      'ਆਪਣੀਆਂ ਬੁਕਿੰਗਾਂ ਵੇਖਣ ਲਈ ਕਿਰਪਾ ਕਰਕੇ ਸਾਈਨ ਇਨ ਕਰੋ।';

  @override
  String get signInToViewNotifications =>
      'ਆਪਣੀਆਂ ਸੂਚਨਾਵਾਂ ਵੇਖਣ ਲਈ ਕਿਰਪਾ ਕਰਕੇ ਸਾਈਨ ਇਨ ਕਰੋ।';

  @override
  String get signInToViewProfile =>
      'ਆਪਣੀ ਪ੍ਰੋਫਾਈਲ ਵੇਖਣ ਲਈ ਕਿਰਪਾ ਕਰਕੇ ਸਾਈਨ ਇਨ ਕਰੋ।';

  @override
  String get signOut => 'ਸਾਈਨ ਆਉਟ';

  @override
  String get signOutTooltip => 'ਸਾਈਨ ਆਉਟ';

  @override
  String get signedInFallback => 'ਸਾਈਨ ਇਨ ਹੋਇਆ';

  @override
  String get signedInMember => 'ਸਾਈਨ ਇਨ ਕੀਤਾ ਮੈਂਬਰ';

  @override
  String get sourceCalgaryOpenData => 'ਸਰੋਤ: ਕੈਲਗਰੀ ਸ਼ਹਿਰ ਦਾ ਖੁੱਲ੍ਹਾ ਡਾਟਾ।';

  @override
  String get startJobButton => 'ਕੰਮ ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String get statusAccepted => 'ਸਵੀਕਾਰ ਕੀਤਾ';

  @override
  String get statusAssigned => 'ਸੌਂਪਿਆ';

  @override
  String get statusCancelled => 'ਰੱਦ ਕੀਤਾ';

  @override
  String get statusCompleted => 'ਮੁਕੰਮਲ';

  @override
  String get statusDeclined => 'ਅਸਵੀਕਾਰ ਕੀਤਾ';

  @override
  String get statusInProgress => 'ਜਾਰੀ ਹੈ';

  @override
  String get statusPending => 'ਬਾਕੀ';

  @override
  String statusValue(String status) {
    return 'ਸਥਿਤੀ: $status';
  }

  @override
  String get store => 'ਸਟੋਰ';

  @override
  String get submit => 'ਭੇਜੋ';

  @override
  String get submitApplicationButton => 'ਅਰਜ਼ੀ ਭੇਜੋ';

  @override
  String get submitApplicationSubtitle => 'ਐਡਮਿਨ ਮਨਜ਼ੂਰੀ ਲਈ ਆਪਣੀ ਅਰਜ਼ੀ ਭੇਜੋ।';

  @override
  String get submitBookingButton => 'ਬੁਕਿੰਗ ਭੇਜੋ';

  @override
  String get submittingEllipsis => 'ਭੇਜਿਆ ਜਾ ਰਿਹਾ ਹੈ...';

  @override
  String get suspendButton => 'ਮੁਅੱਤਲ ਕਰੋ';

  @override
  String get textSizeLabel => 'ਟੈਕਸਟ ਦਾ ਆਕਾਰ';

  @override
  String get traffic => 'ਟ੍ਰੈਫਿਕ';

  @override
  String get trafficDetailsWarning =>
      'ਟ੍ਰੈਫਿਕ ਵੇਰਵੇ ਤੇਜ਼ੀ ਨਾਲ ਬਦਲ ਸਕਦੇ ਹਨ। ਸਫ਼ਰ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਬੰਦ ਹੋਣ, ਰਸਤੇ ਬਦਲਣ, ਕੈਮਰਿਆਂ, ਅਤੇ ਰੂਟ ਅੱਪਡੇਟਾਂ ਲਈ ਕੈਲਗਰੀ ਸ਼ਹਿਰ ਦੀ ਰਿਪੋਰਟ ਵੇਖੋ।';

  @override
  String get trafficIncidentFallback => 'ਟ੍ਰੈਫਿਕ ਘਟਨਾ';

  @override
  String get trafficIncidentReported => 'ਟ੍ਰੈਫਿਕ ਘਟਨਾ ਦੀ ਰਿਪੋਰਟ ਕੀਤੀ ਗਈ।';

  @override
  String get trafficRoadConditions => 'ਸੜਕ ਦੀ ਹਾਲਤ';

  @override
  String get trafficSourceNote =>
      'ਟ੍ਰੈਫਿਕ ਸਰੋਤ: ਕੈਲਗਰੀ ਸ਼ਹਿਰ ਦਾ ਖੁੱਲ੍ਹਾ ਡਾਟਾ। ਸਫ਼ਰ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਹਾਲਾਤ ਦੀ ਪੁਸ਼ਟੀ ਕਰੋ।';

  @override
  String get trafficUpdatesUnavailable => 'ਟ੍ਰੈਫਿਕ ਅੱਪਡੇਟ ਉਪਲਬਧ ਨਹੀਂ ਹਨ।';

  @override
  String get tryAgainButton => 'ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get unassigned => 'ਨਾ-ਸੌਂਪਿਆ';

  @override
  String get updateTimeUnavailable => 'ਅੱਪਡੇਟ ਸਮਾਂ ਉਪਲਬਧ ਨਹੀਂ';

  @override
  String updatedPrefix(String time) {
    return 'ਅੱਪਡੇਟ ਕੀਤਾ: $time';
  }

  @override
  String get vacancyRate2025Note =>
      '2025 ਵਿੱਚ ਕੈਲਗਰੀ ਮਾਰਕੀਟ ਦੀ ਖਾਲੀ ਦਰ, 2024 ਦੇ 4.6% ਤੋਂ ਵਧੀ।';

  @override
  String get vacancyRateExplainer =>
      'ਵੱਧ ਖਾਲੀ ਦਰ ਦਾ ਮਤਲਬ ਹੋ ਸਕਦਾ ਹੈ ਵਧੇਰੇ ਕਿਰਾਏ ਦੇ ਵਿਕਲਪ, ਪਰ ਉਪਲਬਧਤਾ ਅਤੇ ਕਿਰਾਇਆ ਅਜੇ ਵੀ ਆਂਢ-ਗੁਆਂਢ ਅਤੇ ਘਰ ਦੀ ਕਿਸਮ ਅਨੁਸਾਰ ਵੱਖ-ਵੱਖ ਹੁੰਦਾ ਹੈ।';

  @override
  String get vacancyRateIncreaseNote =>
      'ਮਾਰਕੀਟ ਖਾਲੀ ਦਰ 2023 ਵਿੱਚ 1.4% ਤੋਂ 2025 ਵਿੱਚ 5.1% ਤੱਕ ਵਧੀ।';

  @override
  String get verifiedLabel => 'ਪ੍ਰਮਾਣਿਤ';

  @override
  String get viewAllGroceryDeals => 'ਸਾਰੀਆਂ ਕਰਿਆਨੇ ਦੀਆਂ ਡੀਲਾਂ ਵੇਖੋ';

  @override
  String get viewCityHousingTrends => 'ਸ਼ਹਿਰ ਦੇ ਹਾਊਸਿੰਗ ਰੁਝਾਨ ਵੇਖੋ';

  @override
  String get viewDetails => 'ਵੇਰਵੇ ਵੇਖੋ';

  @override
  String get viewLatestStatistics => 'ਨਵੀਨਤਮ ਅੰਕੜੇ ਵੇਖੋ';

  @override
  String get viewModeLabel => 'ਦ੍ਰਿਸ਼ ਮੋਡ';

  @override
  String get weather => 'ਮੌਸਮ';

  @override
  String get weatherRelatedHomeHelp => 'ਮੌਸਮ ਨਾਲ ਸਬੰਧਤ ਘਰੇਲੂ ਮਦਦ';

  @override
  String get weatherUpdate => 'ਮੌਸਮ ਅੱਪਡੇਟ';

  @override
  String get weatherUpdatePublished => 'ਮੌਸਮ ਅੱਪਡੇਟ ਪ੍ਰਕਾਸ਼ਿਤ ਹੋਈ।';

  @override
  String get weatherUpdatesTitle => 'ਮੌਸਮ ਅੱਪਡੇਟ';

  @override
  String get welcomeToNeighbourCare => 'NeighbourCare ਵਿੱਚ ਜੀ ਆਇਆਂ ਨੂੰ';

  @override
  String get whatIsHappeningLabel => 'ਕੀ ਹੋ ਰਿਹਾ ਹੈ?';

  @override
  String get writeAReplyHint => 'ਇੱਕ ਜਵਾਬ ਲਿਖੋ...';

  @override
  String get yourAccountTitle => 'ਤੁਹਾਡਾ ਖਾਤਾ';

  @override
  String get yoyChangeQ22026 => 'ਸਾਲ-ਦਰ-ਸਾਲ ਤਬਦੀਲੀ, Q2 2026';

  @override
  String get updatingWeather => 'मौसम اپ ڈیٹ ہو رہا ہے...';

  @override
  String weatherUpdateUnavailable(String error) {
    return 'मौसम اپ ڈیٹ دستیاب نہیں ہے: $error';
  }

  @override
  String get weatherAlertIssued => 'موسمی الرٹ جاری کیا گیا';

  @override
  String get calgaryIntlAirport => 'کیلگری انٹرنیشنل ایئرپورٹ';

  @override
  String weatherHumidity(String humidity) {
    return 'نمی: $humidity%';
  }

  @override
  String weatherWind(String wind) {
    return 'ہوا: $wind';
  }

  @override
  String weatherVisPres(String visibility, String pressure) {
    return 'حد نگاہ: $visibility • دباؤ: $pressure';
  }

  @override
  String get hideForecast => 'پیشن گوئی چھپائیں';

  @override
  String get showFullForecast => '24 گھنٹے اور کئی دنوں کی پیشن گوئی دکھائیں';

  @override
  String get hourlyForecastTitle => '24 گھنٹے کی پیشن گوئی';

  @override
  String get multiDayOutlookTitle => 'کئی دنوں کا آؤٹ لک';

  @override
  String weatherHigh(String temp) {
    return 'زیادہ سے زیادہ $temp';
  }

  @override
  String weatherLow(String temp) {
    return 'کم از کم $temp';
  }
}
