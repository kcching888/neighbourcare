import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('pa'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
  ];

  ///
  ///
  /// In en, this message translates to:
  /// **'NeighbourCare brings Calgary neighbours closer to useful local information and community resources.'**
  String get aboutNeighbourCare;

  ///
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  ///
  ///
  /// In en, this message translates to:
  /// **'Account created. Check your email to confirm your account, then sign in.'**
  String get accountCreatedCheckEmail;

  ///
  ///
  /// In en, this message translates to:
  /// **'Account created. Check your email to confirm your account, then return here to sign in.'**
  String get accountCreatedCheckEmailReturn;

  ///
  ///
  /// In en, this message translates to:
  /// **'Account created and signed in.'**
  String get accountCreatedSignedIn;

  /// No description provided for @activeIncidentsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} active incident} other{{count} active incidents}}'**
  String activeIncidentsCount(num count);

  ///
  ///
  /// In en, this message translates to:
  /// **'Admin Portal'**
  String get adminPortalTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Admin portal'**
  String get adminPortalTooltip;

  ///
  ///
  /// In en, this message translates to:
  /// **'Alert type'**
  String get alertTypeLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @amountValue.
  ///
  /// In en, this message translates to:
  /// **'Amount: {amount}'**
  String amountValue(String amount);

  ///
  ///
  /// In en, this message translates to:
  /// **'NeighbourCare'**
  String get appName;

  ///
  ///
  /// In en, this message translates to:
  /// **'Application submitted. An administrator must approve your provider profile before you can claim jobs.'**
  String get applicationSubmittedPendingApproval;

  ///
  ///
  /// In en, this message translates to:
  /// **'Apply Now'**
  String get applyNow;

  ///
  ///
  /// In en, this message translates to:
  /// **'Apply to become a provider'**
  String get applyToBecomeProvider;

  ///
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approveButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'An assessed value is used for property assessment and tax. It is not the same as a current market sale-price estimate.'**
  String get assessedValueExplainer;

  ///
  ///
  /// In en, this message translates to:
  /// **'City assessed-value lookup'**
  String get assessedValueLookupTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Assign'**
  String get assignButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get backToSignIn;

  ///
  ///
  /// In en, this message translates to:
  /// **'Become a Provider'**
  String get becomeAProviderTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Best deals this week'**
  String get bestDealsThisWeek;

  ///
  ///
  /// In en, this message translates to:
  /// **'Book a home service'**
  String get bookAHomeService;

  ///
  ///
  /// In en, this message translates to:
  /// **'Book services'**
  String get bookServices;

  ///
  ///
  /// In en, this message translates to:
  /// **'Booking assigned to provider.'**
  String get bookingAssignedToProvider;

  /// No description provided for @bookingStartedFromPost.
  ///
  /// In en, this message translates to:
  /// **'This booking started from the community post: {title}'**
  String bookingStartedFromPost(String title);

  /// No description provided for @bookingStatusUpdated.
  ///
  /// In en, this message translates to:
  /// **'Booking status updated to {status}.'**
  String bookingStatusUpdated(String status);

  /// No description provided for @bookingSubmittedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Booking submitted successfully.\\nBooking ID: {id}'**
  String bookingSubmittedSuccess(String id);

  ///
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookingsTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Browse grocery deals'**
  String get browseGroceryDeals;

  ///
  ///
  /// In en, this message translates to:
  /// **'Browse openings'**
  String get browseOpenings;

  ///
  ///
  /// In en, this message translates to:
  /// **'Calgary'**
  String get calgary;

  ///
  ///
  /// In en, this message translates to:
  /// **'CALGARY, ALBERTA'**
  String get calgaryAlberta;

  ///
  ///
  /// In en, this message translates to:
  /// **'Calgary Community Hub'**
  String get calgaryCommunityHub;

  ///
  ///
  /// In en, this message translates to:
  /// **'Calgary Community Hub - Traffic'**
  String get calgaryCommunityHubTraffic;

  ///
  ///
  /// In en, this message translates to:
  /// **'Calgary housing information'**
  String get calgaryHousingInfoTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Calgary Housing Portal'**
  String get calgaryHousingPortalTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Calgary housing snapshot'**
  String get calgaryHousingSnapshotTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Calgary market rental vacancy rate'**
  String get calgaryMarketVacancyRateLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Beef'**
  String get categoryBeef;

  ///
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get categoryBreakfast;

  ///
  ///
  /// In en, this message translates to:
  /// **'Chicken'**
  String get categoryChicken;

  ///
  ///
  /// In en, this message translates to:
  /// **'Dairy'**
  String get categoryDairy;

  ///
  ///
  /// In en, this message translates to:
  /// **'Fish'**
  String get categoryFish;

  ///
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  ///
  ///
  /// In en, this message translates to:
  /// **'Pork'**
  String get categoryPork;

  /// No description provided for @categoryPostsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} post} other{{count} posts}}'**
  String categoryPostsCount(num count);

  ///
  ///
  /// In en, this message translates to:
  /// **'Choose a topic to post'**
  String get chooseTopicToPost;

  ///
  ///
  /// In en, this message translates to:
  /// **'These are citywide median sale-price changes by building type. They are not individual-property valuations.'**
  String get citywideMedianPriceNote;

  ///
  ///
  /// In en, this message translates to:
  /// **'Claim job'**
  String get claimJobButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'Claim an unassigned request. The first successful claim wins.'**
  String get claimUnassignedSubtitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Claiming...'**
  String get claimingEllipsis;

  ///
  ///
  /// In en, this message translates to:
  /// **'Client sign in'**
  String get clientSignIn;

  ///
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community;

  ///
  ///
  /// In en, this message translates to:
  /// **'Community Feeds'**
  String get communityFeeds;

  ///
  ///
  /// In en, this message translates to:
  /// **'Community Forum'**
  String get communityForumTooltip;

  ///
  ///
  /// In en, this message translates to:
  /// **'Community post'**
  String get communityPost;

  ///
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get completeButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'A new confirmation email has been sent. Use only the newest link, and open it once.'**
  String get confirmationEmailResent;

  /// No description provided for @couldNotAssignProvider.
  ///
  /// In en, this message translates to:
  /// **'Could not assign provider: {error}'**
  String couldNotAssignProvider(String error);

  /// No description provided for @couldNotClaimJob.
  ///
  /// In en, this message translates to:
  /// **'Could not claim job: {error}'**
  String couldNotClaimJob(String error);

  /// No description provided for @couldNotCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Could not create account: {error}'**
  String couldNotCreateAccount(String error);

  /// No description provided for @couldNotLaunchUrl.
  ///
  /// In en, this message translates to:
  /// **'Could not launch {url}'**
  String couldNotLaunchUrl(String url);

  /// No description provided for @couldNotLoadAdminData.
  ///
  /// In en, this message translates to:
  /// **'Could not load admin data: {error}'**
  String couldNotLoadAdminData(String error);

  /// No description provided for @couldNotLoadBookings.
  ///
  /// In en, this message translates to:
  /// **'Could not load bookings: {error}'**
  String couldNotLoadBookings(String error);

  ///
  ///
  /// In en, this message translates to:
  /// **'Could not load jobs.'**
  String get couldNotLoadJobs;

  /// No description provided for @couldNotLoadNotifications.
  ///
  /// In en, this message translates to:
  /// **'Could not load notifications: {error}'**
  String couldNotLoadNotifications(String error);

  ///
  ///
  /// In en, this message translates to:
  /// **'Could not load posts'**
  String get couldNotLoadPosts;

  /// No description provided for @couldNotLoadPostsError.
  ///
  /// In en, this message translates to:
  /// **'Could not load posts: {error}'**
  String couldNotLoadPostsError(String error);

  /// No description provided for @couldNotLoadProfile.
  ///
  /// In en, this message translates to:
  /// **'Could not load profile: {error}'**
  String couldNotLoadProfile(String error);

  /// No description provided for @couldNotLoadProviderPortal.
  ///
  /// In en, this message translates to:
  /// **'Could not load Provider Portal: {error}'**
  String couldNotLoadProviderPortal(String error);

  /// No description provided for @couldNotLoadReplies.
  ///
  /// In en, this message translates to:
  /// **'Could not load replies: {error}'**
  String couldNotLoadReplies(String error);

  /// No description provided for @couldNotMarkAsRead.
  ///
  /// In en, this message translates to:
  /// **'Could not mark as read: {error}'**
  String couldNotMarkAsRead(String error);

  ///
  ///
  /// In en, this message translates to:
  /// **'Could not open directions.'**
  String get couldNotOpenDirections;

  ///
  ///
  /// In en, this message translates to:
  /// **'Could not open the official Calgary traffic report.'**
  String get couldNotOpenTrafficReport;

  /// No description provided for @couldNotPublish.
  ///
  /// In en, this message translates to:
  /// **'Could not publish: {error}'**
  String couldNotPublish(String error);

  /// No description provided for @couldNotResendConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Could not resend confirmation email: {error}'**
  String couldNotResendConfirmation(String error);

  /// No description provided for @couldNotSaveLoginName.
  ///
  /// In en, this message translates to:
  /// **'Could not save login name: {error}'**
  String couldNotSaveLoginName(String error);

  /// No description provided for @couldNotSendReply.
  ///
  /// In en, this message translates to:
  /// **'Could not send reply: {error}'**
  String couldNotSendReply(String error);

  /// No description provided for @couldNotSignOut.
  ///
  /// In en, this message translates to:
  /// **'Could not sign out: {error}'**
  String couldNotSignOut(String error);

  /// No description provided for @couldNotSubmitApplication.
  ///
  /// In en, this message translates to:
  /// **'Could not submit provider application: {error}'**
  String couldNotSubmitApplication(String error);

  /// No description provided for @couldNotSubmitBooking.
  ///
  /// In en, this message translates to:
  /// **'Could not submit booking: {error}'**
  String couldNotSubmitBooking(String error);

  /// No description provided for @couldNotUpdateBookingStatus.
  ///
  /// In en, this message translates to:
  /// **'Could not update booking status: {error}'**
  String couldNotUpdateBookingStatus(String error);

  /// No description provided for @couldNotUpdateJobStatus.
  ///
  /// In en, this message translates to:
  /// **'Could not update job status: {error}'**
  String couldNotUpdateJobStatus(String error);

  /// No description provided for @couldNotUpdateProfile.
  ///
  /// In en, this message translates to:
  /// **'Could not update profile: {error}'**
  String couldNotUpdateProfile(String error);

  /// No description provided for @couldNotUpdateProviderVerification.
  ///
  /// In en, this message translates to:
  /// **'Could not update provider verification: {error}'**
  String couldNotUpdateProviderVerification(String error);

  /// No description provided for @couldNotVerifyRole.
  ///
  /// In en, this message translates to:
  /// **'Could not verify account role: {error}'**
  String couldNotVerifyRole(String error);

  ///
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccountTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Create a client account to book trusted local services.'**
  String get createClientAccountSubtitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Create post'**
  String get createPost;

  ///
  ///
  /// In en, this message translates to:
  /// **'Creating account...'**
  String get creatingAccountEllipsis;

  /// No description provided for @currentIncidentsShown.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} current incident shown.} other{{count} current incidents shown.}}'**
  String currentIncidentsShown(num count);

  ///
  ///
  /// In en, this message translates to:
  /// **'Data sources'**
  String get dataSourcesLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Deals'**
  String get deals;

  ///
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  ///
  ///
  /// In en, this message translates to:
  /// **'Tell us what needs to be repaired or completed.'**
  String get describeIssueHint;

  ///
  ///
  /// In en, this message translates to:
  /// **'Describe the issue'**
  String get describeIssueLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Describe the issue'**
  String get describeIssueValidator;

  ///
  ///
  /// In en, this message translates to:
  /// **'Describe the service you need in Calgary.'**
  String get describeServiceSubtitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Development near you'**
  String get developmentNearYouTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Dining'**
  String get dining;

  ///
  ///
  /// In en, this message translates to:
  /// **'Dining post'**
  String get diningPost;

  ///
  ///
  /// In en, this message translates to:
  /// **'Dining posts'**
  String get diningPostsTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Discussion'**
  String get discussionFallback;

  /// No description provided for @discussionsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} discussion} other{{count} discussions}}'**
  String discussionsCount(num count);

  ///
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get displayNameLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'DIY & Home'**
  String get diyHome;

  ///
  ///
  /// In en, this message translates to:
  /// **'DIY & Home post'**
  String get diyHomePost;

  ///
  ///
  /// In en, this message translates to:
  /// **'DIY & Home'**
  String get diyHomeTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  ///
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddressLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get emailHint;

  ///
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter at least 3 characters.'**
  String get enterAtLeast3Characters;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter a name to display in the app.'**
  String get enterDisplayName;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterEmailAddress;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter both email and password.'**
  String get enterEmailAndPassword;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter the email address first, then resend confirmation.'**
  String get enterEmailFirstResend;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter your first name.'**
  String get enterFirstName;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterFullName;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter your last name.'**
  String get enterLastName;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter your location'**
  String get enterLocation;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter a login name'**
  String get enterLoginName;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter a neighbourhood.'**
  String get enterNeighbourhood;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter a phone number'**
  String get enterPhoneNumber;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter a service category'**
  String get enterServiceCategory;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter your full name, phone number, email, and password.'**
  String get enterSignupDetails;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get enterValidEmailAddress;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourNameHint;

  /// No description provided for @estimatedAmountValue.
  ///
  /// In en, this message translates to:
  /// **'Estimated amount: {amount}'**
  String estimatedAmountValue(String amount);

  ///
  ///
  /// In en, this message translates to:
  /// **'Expiry date'**
  String get expiryDate;

  ///
  ///
  /// In en, this message translates to:
  /// **'Explore NeighbourCare'**
  String get exploreNeighbourCare;

  ///
  ///
  /// In en, this message translates to:
  /// **'Helpful Calgary information, local connections, and everyday resources in one place.'**
  String get exploreSubtitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  ///
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  ///
  ///
  /// In en, this message translates to:
  /// **'Filter: '**
  String get filterLabelPrefix;

  ///
  ///
  /// In en, this message translates to:
  /// **'Find the City-assessed value for a specific Calgary property.'**
  String get findAssessedValueNote;

  ///
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstNameLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get fontSizeLarge;

  ///
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get fontSizeNormal;

  ///
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get fontSizeSmall;

  ///
  ///
  /// In en, this message translates to:
  /// **'Force accept'**
  String get forceAcceptButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'Force decline'**
  String get forceDeclineButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your first and last name'**
  String get fullNameHint;

  ///
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullNameLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Get directions'**
  String get getDirections;

  /// No description provided for @groceryDealsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} grocery deal} other{{count} grocery deals}}'**
  String groceryDealsCount(num count);

  ///
  ///
  /// In en, this message translates to:
  /// **'Local news, traffic, savings, housing, and neighbour-led updates.'**
  String get heroSubtitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your Calgary community, all in one place.'**
  String get heroTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Hide replies'**
  String get hideReplies;

  ///
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  ///
  ///
  /// In en, this message translates to:
  /// **'Home repair / DIY help'**
  String get homeRepairDiyHelp;

  ///
  ///
  /// In en, this message translates to:
  /// **'Home service'**
  String get homeServiceFallback;

  ///
  ///
  /// In en, this message translates to:
  /// **'Housing'**
  String get housing;

  ///
  ///
  /// In en, this message translates to:
  /// **'Housing and Development'**
  String get housingAndDevelopment;

  ///
  ///
  /// In en, this message translates to:
  /// **'Housing data refreshed.'**
  String get housingDataRefreshed;

  ///
  ///
  /// In en, this message translates to:
  /// **'Housing statistics are sourced from City of Calgary housing research and CMHC market information. Property assessments and development details are provided through official City of Calgary tools.'**
  String get housingDataSourcesText;

  ///
  ///
  /// In en, this message translates to:
  /// **'Explore rental-market trends, recent home-price changes, official property assessments, and upcoming development activity.'**
  String get housingInfoDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get housingTypeApartment;

  ///
  ///
  /// In en, this message translates to:
  /// **'Detached'**
  String get housingTypeDetached;

  ///
  ///
  /// In en, this message translates to:
  /// **'Row / townhouse'**
  String get housingTypeRowTownhouse;

  ///
  ///
  /// In en, this message translates to:
  /// **'Semi-detached'**
  String get housingTypeSemiDetached;

  ///
  ///
  /// In en, this message translates to:
  /// **'This job was already claimed by another provider. The list will now refresh.'**
  String get jobAlreadyClaimed;

  ///
  ///
  /// In en, this message translates to:
  /// **'Job claimed successfully.'**
  String get jobClaimedSuccess;

  ///
  ///
  /// In en, this message translates to:
  /// **'Job Listings'**
  String get jobListings;

  /// No description provided for @jobOpeningsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} opening} other{{count} openings}}'**
  String jobOpeningsCount(num count);

  /// No description provided for @jobStatusChanged.
  ///
  /// In en, this message translates to:
  /// **'Job status changed to {status}.'**
  String jobStatusChanged(String status);

  ///
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get jobs;

  ///
  ///
  /// In en, this message translates to:
  /// **'Join the conversation'**
  String get joinConversation;

  ///
  ///
  /// In en, this message translates to:
  /// **'Join NeighbourCare'**
  String get joinNeighbourCare;

  ///
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastNameLabel;

  /// No description provided for @lastRefreshedPrefix.
  ///
  /// In en, this message translates to:
  /// **'Last refreshed: {time}'**
  String lastRefreshedPrefix(String time);

  ///
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get listLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'LIVE'**
  String get live;

  ///
  ///
  /// In en, this message translates to:
  /// **'Live deals from participating local stores. Pull down to refresh.'**
  String get liveDealsSubtitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  ///
  ///
  /// In en, this message translates to:
  /// **'Loading deals...'**
  String get loadingDeals;

  ///
  ///
  /// In en, this message translates to:
  /// **'Loading discussions...'**
  String get loadingDiscussions;

  ///
  ///
  /// In en, this message translates to:
  /// **'Loading jobs...'**
  String get loadingJobs;

  ///
  ///
  /// In en, this message translates to:
  /// **'Loading live updates...'**
  String get loadingLiveUpdates;

  ///
  ///
  /// In en, this message translates to:
  /// **'Loading posts...'**
  String get loadingPosts;

  ///
  ///
  /// In en, this message translates to:
  /// **'Loading traffic updates...'**
  String get loadingTrafficUpdates;

  ///
  ///
  /// In en, this message translates to:
  /// **'Local Savings'**
  String get localSavings;

  /// No description provided for @localSavingsCouldNotUpdate.
  ///
  /// In en, this message translates to:
  /// **'Local Savings could not be updated:\n\n{error}'**
  String localSavingsCouldNotUpdate(String error);

  ///
  ///
  /// In en, this message translates to:
  /// **'Local update'**
  String get localUpdateLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Neighbourhood or postal code'**
  String get locationHint;

  ///
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Location will be optional. When enabled, you can choose 2 km, 5 km, or a default 10 km search radius.'**
  String get locationRadiusNote;

  ///
  ///
  /// In en, this message translates to:
  /// **'Location unavailable'**
  String get locationUnavailable;

  /// No description provided for @locationValue.
  ///
  /// In en, this message translates to:
  /// **'Location: {location}'**
  String locationValue(String location);

  ///
  ///
  /// In en, this message translates to:
  /// **'How other members will see you'**
  String get loginNameHint;

  ///
  ///
  /// In en, this message translates to:
  /// **'Login name'**
  String get loginNameLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Login name must be at least 3 characters'**
  String get loginNameMinLength;

  ///
  ///
  /// In en, this message translates to:
  /// **'That login name is already taken. Please choose another.'**
  String get loginNameTaken;

  ///
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get mapLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Mark as read'**
  String get markAsReadTooltip;

  ///
  ///
  /// In en, this message translates to:
  /// **'Mark completed'**
  String get markCompletedButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'Market metrics & development permits'**
  String get marketMetricsSubtitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Market price trends'**
  String get marketPriceTrendsTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Marketplace'**
  String get marketplace;

  ///
  ///
  /// In en, this message translates to:
  /// **'Buy, sell, and share'**
  String get marketplaceSubtitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Median home prices by building type'**
  String get medianHomePricesTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Member'**
  String get memberFallback;

  ///
  ///
  /// In en, this message translates to:
  /// **'My assigned jobs'**
  String get myAssignedJobsTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'My bookings'**
  String get myBookings;

  ///
  ///
  /// In en, this message translates to:
  /// **'My profile'**
  String get myProfileTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'NeighbourCare Calgary'**
  String get neighbourCareCalgaryTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'NeighbourCare Community'**
  String get neighbourCareCommunity;

  ///
  ///
  /// In en, this message translates to:
  /// **'NeighbourCare Services'**
  String get neighbourCareServicesTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Example: Beltline'**
  String get neighbourhoodExampleHint;

  ///
  ///
  /// In en, this message translates to:
  /// **'For example: Beltline or Tuscany'**
  String get neighbourhoodHint;

  ///
  ///
  /// In en, this message translates to:
  /// **'Neighbourhood'**
  String get neighbourhoodLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Calgary neighbourhood (optional)'**
  String get neighbourhoodOptionalLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'New to NeighbourCare? Sign up'**
  String get newToNeighbourCareSignUp;

  ///
  ///
  /// In en, this message translates to:
  /// **'Newest Calgary-wide applications will appear here first.'**
  String get newestApplicationsNote;

  ///
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  ///
  ///
  /// In en, this message translates to:
  /// **'No active deals match this search or category.'**
  String get noActiveDealsMatch;

  ///
  ///
  /// In en, this message translates to:
  /// **'No active incidents'**
  String get noActiveIncidents;

  ///
  ///
  /// In en, this message translates to:
  /// **'No active incidents listed.'**
  String get noActiveIncidentsListed;

  ///
  ///
  /// In en, this message translates to:
  /// **'No bookings yet. Submit your first service request.'**
  String get noBookingsYet;

  ///
  ///
  /// In en, this message translates to:
  /// **'You have not claimed any jobs yet.'**
  String get noClaimedJobsYet;

  ///
  ///
  /// In en, this message translates to:
  /// **'No community posts yet.'**
  String get noCommunityPosts;

  ///
  ///
  /// In en, this message translates to:
  /// **'No current deals'**
  String get noCurrentDeals;

  ///
  ///
  /// In en, this message translates to:
  /// **'No current traffic incidents are listed.'**
  String get noCurrentTrafficIncidents;

  ///
  ///
  /// In en, this message translates to:
  /// **'No deals available right now.'**
  String get noDealsAvailable;

  ///
  ///
  /// In en, this message translates to:
  /// **'No email available'**
  String get noEmailAvailable;

  ///
  ///
  /// In en, this message translates to:
  /// **'No jobs found.'**
  String get noJobsFound;

  ///
  ///
  /// In en, this message translates to:
  /// **'No notifications.'**
  String get noNotifications;

  ///
  ///
  /// In en, this message translates to:
  /// **'No open requests are available right now.'**
  String get noOpenRequests;

  ///
  ///
  /// In en, this message translates to:
  /// **'No posts yet. Be the first to share.'**
  String get noPostsShareFirst;

  ///
  ///
  /// In en, this message translates to:
  /// **'No provider applications found.'**
  String get noProviderApplicationsFound;

  ///
  ///
  /// In en, this message translates to:
  /// **'No provider profile is linked to this account. Create a providers row using this user’s Auth UUID.'**
  String get noProviderProfileLinked;

  ///
  ///
  /// In en, this message translates to:
  /// **'No recent discussions.'**
  String get noRecentDiscussions;

  ///
  ///
  /// In en, this message translates to:
  /// **'No recent posts.'**
  String get noRecentPosts;

  ///
  ///
  /// In en, this message translates to:
  /// **'No replies yet.'**
  String get noRepliesYet;

  ///
  ///
  /// In en, this message translates to:
  /// **'No verified price reductions are active right now.'**
  String get noVerifiedPriceReductions;

  ///
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get notAvailable;

  ///
  ///
  /// In en, this message translates to:
  /// **'Not provided'**
  String get notProvided;

  /// No description provided for @notesValue.
  ///
  /// In en, this message translates to:
  /// **'Notes: {notes}'**
  String notesValue(String notes);

  ///
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notificationFallback;

  ///
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Official source'**
  String get officialSourceLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Open Calgary Development Map'**
  String get openCalgaryDevelopmentMap;

  ///
  ///
  /// In en, this message translates to:
  /// **'Open City of Calgary myTax'**
  String get openCalgaryMyTax;

  ///
  ///
  /// In en, this message translates to:
  /// **'Open City traffic report'**
  String get openCityTrafficReport;

  ///
  ///
  /// In en, this message translates to:
  /// **'Open requests'**
  String get openRequestsTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get optionsTooltip;

  ///
  ///
  /// In en, this message translates to:
  /// **'Other local assistance'**
  String get otherLocalAssistance;

  ///
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters.'**
  String get passwordHelperText;

  ///
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 6 characters.'**
  String get passwordMinLength;

  ///
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters.'**
  String get passwordMinLength8;

  ///
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters'**
  String get passwordTooShort;

  ///
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  ///
  ///
  /// In en, this message translates to:
  /// **'Permit feed coming next'**
  String get permitFeedComingNext;

  ///
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumberLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get postFallback;

  ///
  ///
  /// In en, this message translates to:
  /// **'Posted'**
  String get posted;

  /// No description provided for @postedOn.
  ///
  /// In en, this message translates to:
  /// **'Posted {date}'**
  String postedOn(String date);

  ///
  ///
  /// In en, this message translates to:
  /// **'Today 5–7 PM or Saturday morning'**
  String get preferredTimeHint;

  ///
  ///
  /// In en, this message translates to:
  /// **'Preferred time'**
  String get preferredTimeLabel;

  /// No description provided for @preferredTimeValue.
  ///
  /// In en, this message translates to:
  /// **'Preferred time: {time}'**
  String preferredTimeValue(String time);

  ///
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  ///
  ///
  /// In en, this message translates to:
  /// **'Prices, stock, membership requirements, and promotion terms may change. Confirm directly with the store before visiting.'**
  String get pricesTermsMayChange;

  ///
  ///
  /// In en, this message translates to:
  /// **'Do not include home addresses, faces, licence plates, phone numbers, or other private information.'**
  String get privacyReminderText;

  ///
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully.'**
  String get profileUpdatedSuccess;

  ///
  ///
  /// In en, this message translates to:
  /// **'Provider application'**
  String get providerApplicationTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Provider approval'**
  String get providerApprovalTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Provider approved successfully.'**
  String get providerApprovedSuccess;

  /// No description provided for @providerIdFallback.
  ///
  /// In en, this message translates to:
  /// **'Provider {id}'**
  String providerIdFallback(String id);

  ///
  ///
  /// In en, this message translates to:
  /// **'Provider: '**
  String get providerLabelPrefix;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your provider profile is not verified yet. Ask an administrator to set pvsc_verified to true.'**
  String get providerNotVerified;

  ///
  ///
  /// In en, this message translates to:
  /// **'Provider portal'**
  String get providerPortal;

  ///
  ///
  /// In en, this message translates to:
  /// **'Provider Portal'**
  String get providerPortalTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Provider portal'**
  String get providerPortalTooltip;

  ///
  ///
  /// In en, this message translates to:
  /// **'Provider verification was removed.'**
  String get providerVerificationRemoved;

  ///
  ///
  /// In en, this message translates to:
  /// **'Publish report'**
  String get publishReportButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'Publishing…'**
  String get publishingEllipsis;

  ///
  ///
  /// In en, this message translates to:
  /// **'Ranked by verified percentage saved'**
  String get rankedByVerifiedSavings;

  /// No description provided for @ratingValue.
  ///
  /// In en, this message translates to:
  /// **'rating: {rating}'**
  String ratingValue(String rating);

  ///
  ///
  /// In en, this message translates to:
  /// **'Refresh bookings'**
  String get refreshBookings;

  ///
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refreshTooltip;

  ///
  ///
  /// In en, this message translates to:
  /// **'Refresh traffic'**
  String get refreshTraffic;

  ///
  ///
  /// In en, this message translates to:
  /// **'Regular price'**
  String get regularPrice;

  /// No description provided for @regularPriceValue.
  ///
  /// In en, this message translates to:
  /// **'Regular price \${price}'**
  String regularPriceValue(String price);

  ///
  ///
  /// In en, this message translates to:
  /// **'Calgary rental availability and recent median home-price changes.'**
  String get rentalAvailabilityChangesNote;

  ///
  ///
  /// In en, this message translates to:
  /// **'Rental market vacancy rate'**
  String get rentalMarketVacancyRateTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Rental vacancy rate'**
  String get rentalVacancyRateLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get replyAction;

  ///
  ///
  /// In en, this message translates to:
  /// **'Report local conditions'**
  String get reportLocalConditionsTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Request help'**
  String get requestHelp;

  /// No description provided for @requestedFromCommunityPost.
  ///
  /// In en, this message translates to:
  /// **'Requested from community post: {title}\\n\\nPlease describe the help needed:'**
  String requestedFromCommunityPost(String title);

  ///
  ///
  /// In en, this message translates to:
  /// **'Resend confirmation email'**
  String get resendConfirmationEmail;

  ///
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  ///
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  ///
  ///
  /// In en, this message translates to:
  /// **'Save on groceries in Calgary'**
  String get saveOnGroceriesTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Save profile'**
  String get saveProfileButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get savingEllipsis;

  ///
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get savings;

  ///
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  ///
  ///
  /// In en, this message translates to:
  /// **'Search by product or store'**
  String get searchByProductOrStore;

  ///
  ///
  /// In en, this message translates to:
  /// **'Plumbing, furnace, snow removal...'**
  String get serviceCategoryHint;

  ///
  ///
  /// In en, this message translates to:
  /// **'Service category'**
  String get serviceCategoryLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get serviceFallback;

  ///
  ///
  /// In en, this message translates to:
  /// **'Share an update'**
  String get shareAnUpdate;

  ///
  ///
  /// In en, this message translates to:
  /// **'Share factual, current conditions.'**
  String get shareFactualConditionsHint;

  ///
  ///
  /// In en, this message translates to:
  /// **'Share current local conditions. For an immediate emergency, call 911.'**
  String get shareLocalConditionsWarning;

  ///
  ///
  /// In en, this message translates to:
  /// **'Show list'**
  String get showList;

  ///
  ///
  /// In en, this message translates to:
  /// **'Show map'**
  String get showMap;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  ///
  ///
  /// In en, this message translates to:
  /// **'Please sign in as a provider.'**
  String get signInAsProvider;

  ///
  ///
  /// In en, this message translates to:
  /// **'Please sign in before submitting a booking.'**
  String get signInBeforeBooking;

  ///
  ///
  /// In en, this message translates to:
  /// **'Please sign in before posting.'**
  String get signInBeforePosting;

  ///
  ///
  /// In en, this message translates to:
  /// **'Please sign in before updating your profile.'**
  String get signInBeforeUpdatingProfile;

  /// No description provided for @signInFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign-in failed: {error}'**
  String signInFailed(String error);

  ///
  ///
  /// In en, this message translates to:
  /// **'Sign in required'**
  String get signInRequired;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sign in to book and manage home services.'**
  String get signInSubtitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sign in as a client or provider before creating a community post.'**
  String get signInToCreatePost;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sign in to reply.'**
  String get signInToReply;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sign in to request help from a community post.'**
  String get signInToRequestHelp;

  ///
  ///
  /// In en, this message translates to:
  /// **'Please sign in to view your bookings.'**
  String get signInToViewBookings;

  ///
  ///
  /// In en, this message translates to:
  /// **'Please sign in to view notifications.'**
  String get signInToViewNotifications;

  ///
  ///
  /// In en, this message translates to:
  /// **'Please sign in to view your profile.'**
  String get signInToViewProfile;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOutTooltip;

  ///
  ///
  /// In en, this message translates to:
  /// **'Signed in'**
  String get signedInFallback;

  ///
  ///
  /// In en, this message translates to:
  /// **'Signed-in member'**
  String get signedInMember;

  ///
  ///
  /// In en, this message translates to:
  /// **'Source: City of Calgary Open Data.'**
  String get sourceCalgaryOpenData;

  ///
  ///
  /// In en, this message translates to:
  /// **'Start job'**
  String get startJobButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get statusAccepted;

  ///
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get statusAssigned;

  ///
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  ///
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  ///
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get statusDeclined;

  ///
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get statusInProgress;

  ///
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusValue.
  ///
  /// In en, this message translates to:
  /// **'Status: {status}'**
  String statusValue(String status);

  ///
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get store;

  ///
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  ///
  ///
  /// In en, this message translates to:
  /// **'Submit application'**
  String get submitApplicationButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'Submit your application for admin approval.'**
  String get submitApplicationSubtitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Submit booking'**
  String get submitBookingButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'Submitting...'**
  String get submittingEllipsis;

  ///
  ///
  /// In en, this message translates to:
  /// **'Suspend'**
  String get suspendButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'Text Size'**
  String get textSizeLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Traffic'**
  String get traffic;

  ///
  ///
  /// In en, this message translates to:
  /// **'Traffic details can change quickly. Check the City of Calgary report for closures, detours, cameras, and route updates before travelling.'**
  String get trafficDetailsWarning;

  ///
  ///
  /// In en, this message translates to:
  /// **'Traffic incident'**
  String get trafficIncidentFallback;

  ///
  ///
  /// In en, this message translates to:
  /// **'Traffic incident reported.'**
  String get trafficIncidentReported;

  ///
  ///
  /// In en, this message translates to:
  /// **'Road Conditions'**
  String get trafficRoadConditions;

  ///
  ///
  /// In en, this message translates to:
  /// **'Traffic source: City of Calgary Open Data. Confirm conditions before travelling.'**
  String get trafficSourceNote;

  ///
  ///
  /// In en, this message translates to:
  /// **'Traffic updates are unavailable.'**
  String get trafficUpdatesUnavailable;

  ///
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgainButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'Unassigned'**
  String get unassigned;

  ///
  ///
  /// In en, this message translates to:
  /// **'Update time unavailable'**
  String get updateTimeUnavailable;

  /// No description provided for @updatedPrefix.
  ///
  /// In en, this message translates to:
  /// **'Updated: {time}'**
  String updatedPrefix(String time);

  ///
  ///
  /// In en, this message translates to:
  /// **'Calgary market vacancy rate in 2025, up from 4.6% in 2024.'**
  String get vacancyRate2025Note;

  ///
  ///
  /// In en, this message translates to:
  /// **'A higher vacancy rate can mean more rental options, but availability and rent still vary by neighbourhood and home type.'**
  String get vacancyRateExplainer;

  ///
  ///
  /// In en, this message translates to:
  /// **'The market vacancy rate increased from 1.4% in 2023 to 5.1% in 2025.'**
  String get vacancyRateIncreaseNote;

  ///
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verifiedLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'View all grocery deals'**
  String get viewAllGroceryDeals;

  ///
  ///
  /// In en, this message translates to:
  /// **'View City housing trends'**
  String get viewCityHousingTrends;

  ///
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get viewDetails;

  ///
  ///
  /// In en, this message translates to:
  /// **'View the latest statistics'**
  String get viewLatestStatistics;

  ///
  ///
  /// In en, this message translates to:
  /// **'View Mode'**
  String get viewModeLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get weather;

  ///
  ///
  /// In en, this message translates to:
  /// **'Weather-related home help'**
  String get weatherRelatedHomeHelp;

  ///
  ///
  /// In en, this message translates to:
  /// **'Weather update'**
  String get weatherUpdate;

  ///
  ///
  /// In en, this message translates to:
  /// **'Weather update published.'**
  String get weatherUpdatePublished;

  ///
  ///
  /// In en, this message translates to:
  /// **'Weather updates'**
  String get weatherUpdatesTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Welcome to NeighbourCare'**
  String get welcomeToNeighbourCare;

  ///
  ///
  /// In en, this message translates to:
  /// **'What is happening?'**
  String get whatIsHappeningLabel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Write a reply...'**
  String get writeAReplyHint;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your account'**
  String get yourAccountTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Year-over-year change, Q2 2026'**
  String get yoyChangeQ22026;

  /// Loading text while fetching weather data
  ///
  /// In en, this message translates to:
  /// **'Updating Weather...'**
  String get updatingWeather;

  /// No description provided for @weatherUpdateUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Weather update unavailable: {error}'**
  String weatherUpdateUnavailable(String error);

  /// No description provided for @weatherAlertIssued.
  ///
  /// In en, this message translates to:
  /// **'Weather Alert Issued'**
  String get weatherAlertIssued;

  /// No description provided for @calgaryIntlAirport.
  ///
  /// In en, this message translates to:
  /// **'Calgary Int\'l Airport'**
  String get calgaryIntlAirport;

  /// No description provided for @weatherHumidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity: {humidity}%'**
  String weatherHumidity(String humidity);

  /// No description provided for @weatherWind.
  ///
  /// In en, this message translates to:
  /// **'Wind: {wind}'**
  String weatherWind(String wind);

  /// No description provided for @weatherVisPres.
  ///
  /// In en, this message translates to:
  /// **'Vis: {visibility} • Pres: {pressure}'**
  String weatherVisPres(String visibility, String pressure);

  /// No description provided for @hideForecast.
  ///
  /// In en, this message translates to:
  /// **'Hide Forecast'**
  String get hideForecast;

  /// No description provided for @showFullForecast.
  ///
  /// In en, this message translates to:
  /// **'Show 24-Hr & Multi-Day Forecast'**
  String get showFullForecast;

  /// No description provided for @hourlyForecastTitle.
  ///
  /// In en, this message translates to:
  /// **'24-Hour Forecast'**
  String get hourlyForecastTitle;

  /// No description provided for @multiDayOutlookTitle.
  ///
  /// In en, this message translates to:
  /// **'Multi-Day Outlook'**
  String get multiDayOutlookTitle;

  /// No description provided for @weatherHigh.
  ///
  /// In en, this message translates to:
  /// **'High {temp}'**
  String weatherHigh(String temp);

  /// No description provided for @weatherLow.
  ///
  /// In en, this message translates to:
  /// **'Low {temp}'**
  String weatherLow(String temp);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr', 'pa', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'pa':
      return AppLocalizationsPa();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
