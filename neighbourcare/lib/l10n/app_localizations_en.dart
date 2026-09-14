// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get aboutNeighbourCare =>
      'NeighbourCare brings Calgary neighbours closer to useful local information and community resources.';

  @override
  String get account => 'Account';

  @override
  String get accountCreatedCheckEmail =>
      'Account created. Check your email to confirm your account, then sign in.';

  @override
  String get accountCreatedCheckEmailReturn =>
      'Account created. Check your email to confirm your account, then return here to sign in.';

  @override
  String get accountCreatedSignedIn => 'Account created and signed in.';

  @override
  String activeIncidentsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString active incidents',
      one: '$countString active incident',
    );
    return '$_temp0';
  }

  @override
  String get adminPortalTitle => 'Admin Portal';

  @override
  String get adminPortalTooltip => 'Admin portal';

  @override
  String get alertTypeLabel => 'Alert type';

  @override
  String get all => 'All';

  @override
  String amountValue(String amount) {
    return 'Amount: $amount';
  }

  @override
  String get appName => 'NeighbourCare';

  @override
  String get applicationSubmittedPendingApproval =>
      'Application submitted. An administrator must approve your provider profile before you can claim jobs.';

  @override
  String get applyNow => 'Apply Now';

  @override
  String get applyToBecomeProvider => 'Apply to become a provider';

  @override
  String get approveButton => 'Approve';

  @override
  String get assessedValueExplainer =>
      'An assessed value is used for property assessment and tax. It is not the same as a current market sale-price estimate.';

  @override
  String get assessedValueLookupTitle => 'City assessed-value lookup';

  @override
  String get assignButton => 'Assign';

  @override
  String get backToSignIn => 'Back to sign in';

  @override
  String get becomeAProviderTitle => 'Become a Provider';

  @override
  String get bestDealsThisWeek => 'Best deals this week';

  @override
  String get bookAHomeService => 'Book a home service';

  @override
  String get bookServices => 'Book services';

  @override
  String get bookingAssignedToProvider => 'Booking assigned to provider.';

  @override
  String bookingStartedFromPost(String title) {
    return 'This booking started from the community post: $title';
  }

  @override
  String bookingStatusUpdated(String status) {
    return 'Booking status updated to $status.';
  }

  @override
  String bookingSubmittedSuccess(String id) {
    return 'Booking submitted successfully.\\nBooking ID: $id';
  }

  @override
  String get bookingsTitle => 'Bookings';

  @override
  String get browseGroceryDeals => 'Browse grocery deals';

  @override
  String get browseOpenings => 'Browse openings';

  @override
  String get calgary => 'Calgary';

  @override
  String get calgaryAlberta => 'CALGARY, ALBERTA';

  @override
  String get calgaryCommunityHub => 'Calgary Community Hub';

  @override
  String get calgaryCommunityHubTraffic => 'Calgary Community Hub - Traffic';

  @override
  String get calgaryHousingInfoTitle => 'Calgary housing information';

  @override
  String get calgaryHousingPortalTitle => 'Calgary Housing Portal';

  @override
  String get calgaryHousingSnapshotTitle => 'Calgary housing snapshot';

  @override
  String get calgaryMarketVacancyRateLabel =>
      'Calgary market rental vacancy rate';

  @override
  String get cancel => 'Cancel';

  @override
  String get categoryBeef => 'Beef';

  @override
  String get categoryBreakfast => 'Breakfast';

  @override
  String get categoryChicken => 'Chicken';

  @override
  String get categoryDairy => 'Dairy';

  @override
  String get categoryFish => 'Fish';

  @override
  String get categoryOther => 'Other';

  @override
  String get categoryPork => 'Pork';

  @override
  String categoryPostsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString posts',
      one: '$countString post',
    );
    return '$_temp0';
  }

  @override
  String get chooseTopicToPost => 'Choose a topic to post';

  @override
  String get citywideMedianPriceNote =>
      'These are citywide median sale-price changes by building type. They are not individual-property valuations.';

  @override
  String get claimJobButton => 'Claim job';

  @override
  String get claimUnassignedSubtitle =>
      'Claim an unassigned request. The first successful claim wins.';

  @override
  String get claimingEllipsis => 'Claiming...';

  @override
  String get clientSignIn => 'Client sign in';

  @override
  String get community => 'Community';

  @override
  String get communityFeeds => 'Community Feeds';

  @override
  String get communityForumTooltip => 'Community Forum';

  @override
  String get communityPost => 'Community post';

  @override
  String get completeButton => 'Complete';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get confirmationEmailResent =>
      'A new confirmation email has been sent. Use only the newest link, and open it once.';

  @override
  String couldNotAssignProvider(String error) {
    return 'Could not assign provider: $error';
  }

  @override
  String couldNotClaimJob(String error) {
    return 'Could not claim job: $error';
  }

  @override
  String couldNotCreateAccount(String error) {
    return 'Could not create account: $error';
  }

  @override
  String couldNotLaunchUrl(String url) {
    return 'Could not launch $url';
  }

  @override
  String couldNotLoadAdminData(String error) {
    return 'Could not load admin data: $error';
  }

  @override
  String couldNotLoadBookings(String error) {
    return 'Could not load bookings: $error';
  }

  @override
  String get couldNotLoadJobs => 'Could not load jobs.';

  @override
  String couldNotLoadNotifications(String error) {
    return 'Could not load notifications: $error';
  }

  @override
  String get couldNotLoadPosts => 'Could not load posts';

  @override
  String couldNotLoadPostsError(String error) {
    return 'Could not load posts: $error';
  }

  @override
  String couldNotLoadProfile(String error) {
    return 'Could not load profile: $error';
  }

  @override
  String couldNotLoadProviderPortal(String error) {
    return 'Could not load Provider Portal: $error';
  }

  @override
  String couldNotLoadReplies(String error) {
    return 'Could not load replies: $error';
  }

  @override
  String couldNotMarkAsRead(String error) {
    return 'Could not mark as read: $error';
  }

  @override
  String get couldNotOpenDirections => 'Could not open directions.';

  @override
  String get couldNotOpenTrafficReport =>
      'Could not open the official Calgary traffic report.';

  @override
  String couldNotPublish(String error) {
    return 'Could not publish: $error';
  }

  @override
  String couldNotResendConfirmation(String error) {
    return 'Could not resend confirmation email: $error';
  }

  @override
  String couldNotSaveLoginName(String error) {
    return 'Could not save login name: $error';
  }

  @override
  String couldNotSendReply(String error) {
    return 'Could not send reply: $error';
  }

  @override
  String couldNotSignOut(String error) {
    return 'Could not sign out: $error';
  }

  @override
  String couldNotSubmitApplication(String error) {
    return 'Could not submit provider application: $error';
  }

  @override
  String couldNotSubmitBooking(String error) {
    return 'Could not submit booking: $error';
  }

  @override
  String couldNotUpdateBookingStatus(String error) {
    return 'Could not update booking status: $error';
  }

  @override
  String couldNotUpdateJobStatus(String error) {
    return 'Could not update job status: $error';
  }

  @override
  String couldNotUpdateProfile(String error) {
    return 'Could not update profile: $error';
  }

  @override
  String couldNotUpdateProviderVerification(String error) {
    return 'Could not update provider verification: $error';
  }

  @override
  String couldNotVerifyRole(String error) {
    return 'Could not verify account role: $error';
  }

  @override
  String get createAccountTitle => 'Create account';

  @override
  String get createClientAccountSubtitle =>
      'Create a client account to book trusted local services.';

  @override
  String get createPost => 'Create post';

  @override
  String get creatingAccountEllipsis => 'Creating account...';

  @override
  String currentIncidentsShown(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString current incidents shown.',
      one: '$countString current incident shown.',
    );
    return '$_temp0';
  }

  @override
  String get dataSourcesLabel => 'Data sources';

  @override
  String get deals => 'Deals';

  @override
  String get delete => 'Delete';

  @override
  String get describeIssueHint =>
      'Tell us what needs to be repaired or completed.';

  @override
  String get describeIssueLabel => 'Describe the issue';

  @override
  String get describeIssueValidator => 'Describe the issue';

  @override
  String get describeServiceSubtitle =>
      'Describe the service you need in Calgary.';

  @override
  String get developmentNearYouTitle => 'Development near you';

  @override
  String get dining => 'Dining';

  @override
  String get diningPost => 'Dining post';

  @override
  String get diningPostsTitle => 'Dining posts';

  @override
  String get discussionFallback => 'Discussion';

  @override
  String discussionsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString discussions',
      one: '$countString discussion',
    );
    return '$_temp0';
  }

  @override
  String get displayNameLabel => 'Display name';

  @override
  String get diyHome => 'DIY & Home';

  @override
  String get diyHomePost => 'DIY & Home post';

  @override
  String get diyHomeTitle => 'DIY & Home';

  @override
  String get edit => 'Edit';

  @override
  String get emailAddressLabel => 'Email address';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get emailLabel => 'Email';

  @override
  String get enterAtLeast3Characters => 'Enter at least 3 characters.';

  @override
  String get enterDisplayName => 'Enter a name to display in the app.';

  @override
  String get enterEmailAddress => 'Enter your email address';

  @override
  String get enterEmailAndPassword => 'Enter both email and password.';

  @override
  String get enterEmailFirstResend =>
      'Enter the email address first, then resend confirmation.';

  @override
  String get enterFirstName => 'Enter your first name.';

  @override
  String get enterFullName => 'Enter your full name';

  @override
  String get enterLastName => 'Enter your last name.';

  @override
  String get enterLocation => 'Enter your location';

  @override
  String get enterLoginName => 'Enter a login name';

  @override
  String get enterNeighbourhood => 'Enter a neighbourhood.';

  @override
  String get enterPhoneNumber => 'Enter a phone number';

  @override
  String get enterServiceCategory => 'Enter a service category';

  @override
  String get enterSignupDetails =>
      'Enter your full name, phone number, email, and password.';

  @override
  String get enterValidEmailAddress => 'Enter a valid email address';

  @override
  String get enterYourNameHint => 'Enter your name';

  @override
  String estimatedAmountValue(String amount) {
    return 'Estimated amount: $amount';
  }

  @override
  String get expiryDate => 'Expiry date';

  @override
  String get exploreNeighbourCare => 'Explore NeighbourCare';

  @override
  String get exploreSubtitle =>
      'Helpful Calgary information, local connections, and everyday resources in one place.';

  @override
  String get filter => 'Filter';

  @override
  String get filterAll => 'All';

  @override
  String get filterLabelPrefix => 'Filter: ';

  @override
  String get findAssessedValueNote =>
      'Find the City-assessed value for a specific Calgary property.';

  @override
  String get firstNameLabel => 'First name';

  @override
  String get fontSizeLarge => 'Large';

  @override
  String get fontSizeNormal => 'Normal';

  @override
  String get fontSizeSmall => 'Small';

  @override
  String get forceAcceptButton => 'Force accept';

  @override
  String get forceDeclineButton => 'Force decline';

  @override
  String get fullNameHint => 'Your first and last name';

  @override
  String get fullNameLabel => 'Full name';

  @override
  String get getDirections => 'Get directions';

  @override
  String groceryDealsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString grocery deals',
      one: '$countString grocery deal',
    );
    return '$_temp0';
  }

  @override
  String get heroSubtitle =>
      'Local news, traffic, savings, housing, and neighbour-led updates.';

  @override
  String get heroTitle => 'Your Calgary community, all in one place.';

  @override
  String get hideReplies => 'Hide replies';

  @override
  String get home => 'Home';

  @override
  String get homeRepairDiyHelp => 'Home repair / DIY help';

  @override
  String get homeServiceFallback => 'Home service';

  @override
  String get housing => 'Housing';

  @override
  String get housingAndDevelopment => 'Housing and Development';

  @override
  String get housingDataRefreshed => 'Housing data refreshed.';

  @override
  String get housingDataSourcesText =>
      'Housing statistics are sourced from City of Calgary housing research and CMHC market information. Property assessments and development details are provided through official City of Calgary tools.';

  @override
  String get housingInfoDescription =>
      'Explore rental-market trends, recent home-price changes, official property assessments, and upcoming development activity.';

  @override
  String get housingTypeApartment => 'Apartment';

  @override
  String get housingTypeDetached => 'Detached';

  @override
  String get housingTypeRowTownhouse => 'Row / townhouse';

  @override
  String get housingTypeSemiDetached => 'Semi-detached';

  @override
  String get jobAlreadyClaimed =>
      'This job was already claimed by another provider. The list will now refresh.';

  @override
  String get jobClaimedSuccess => 'Job claimed successfully.';

  @override
  String get jobListings => 'Job Listings';

  @override
  String jobOpeningsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString openings',
      one: '$countString opening',
    );
    return '$_temp0';
  }

  @override
  String jobStatusChanged(String status) {
    return 'Job status changed to $status.';
  }

  @override
  String get jobs => 'Jobs';

  @override
  String get joinConversation => 'Join the conversation';

  @override
  String get joinNeighbourCare => 'Join NeighbourCare';

  @override
  String get lastNameLabel => 'Last name';

  @override
  String lastRefreshedPrefix(String time) {
    return 'Last refreshed: $time';
  }

  @override
  String get listLabel => 'List';

  @override
  String get live => 'LIVE';

  @override
  String get liveDealsSubtitle =>
      'Live deals from participating local stores. Pull down to refresh.';

  @override
  String get loading => 'Loading...';

  @override
  String get loadingDeals => 'Loading deals...';

  @override
  String get loadingDiscussions => 'Loading discussions...';

  @override
  String get loadingJobs => 'Loading jobs...';

  @override
  String get loadingLiveUpdates => 'Loading live updates...';

  @override
  String get loadingPosts => 'Loading posts...';

  @override
  String get loadingTrafficUpdates => 'Loading traffic updates...';

  @override
  String get localSavings => 'Local Savings';

  @override
  String localSavingsCouldNotUpdate(String error) {
    return 'Local Savings could not be updated:\n\n$error';
  }

  @override
  String get localUpdateLabel => 'Local update';

  @override
  String get locationHint => 'Neighbourhood or postal code';

  @override
  String get locationLabel => 'Location';

  @override
  String get locationRadiusNote =>
      'Location will be optional. When enabled, you can choose 2 km, 5 km, or a default 10 km search radius.';

  @override
  String get locationUnavailable => 'Location unavailable';

  @override
  String locationValue(String location) {
    return 'Location: $location';
  }

  @override
  String get loginNameHint => 'How other members will see you';

  @override
  String get loginNameLabel => 'Login name';

  @override
  String get loginNameMinLength => 'Login name must be at least 3 characters';

  @override
  String get loginNameTaken =>
      'That login name is already taken. Please choose another.';

  @override
  String get mapLabel => 'Map';

  @override
  String get markAsReadTooltip => 'Mark as read';

  @override
  String get markCompletedButton => 'Mark completed';

  @override
  String get marketMetricsSubtitle => 'Market metrics & development permits';

  @override
  String get marketPriceTrendsTitle => 'Market price trends';

  @override
  String get marketplace => 'Marketplace';

  @override
  String get marketplaceSubtitle => 'Buy, sell, and share';

  @override
  String get medianHomePricesTitle => 'Median home prices by building type';

  @override
  String get memberFallback => 'Member';

  @override
  String get myAssignedJobsTitle => 'My assigned jobs';

  @override
  String get myBookings => 'My bookings';

  @override
  String get myProfileTitle => 'My profile';

  @override
  String get neighbourCareCalgaryTitle => 'NeighbourCare Calgary';

  @override
  String get neighbourCareCommunity => 'NeighbourCare Community';

  @override
  String get neighbourCareServicesTitle => 'NeighbourCare Services';

  @override
  String get neighbourhoodExampleHint => 'Example: Beltline';

  @override
  String get neighbourhoodHint => 'For example: Beltline or Tuscany';

  @override
  String get neighbourhoodLabel => 'Neighbourhood';

  @override
  String get neighbourhoodOptionalLabel => 'Calgary neighbourhood (optional)';

  @override
  String get newToNeighbourCareSignUp => 'New to NeighbourCare? Sign up';

  @override
  String get newestApplicationsNote =>
      'Newest Calgary-wide applications will appear here first.';

  @override
  String get news => 'News';

  @override
  String get noActiveDealsMatch =>
      'No active deals match this search or category.';

  @override
  String get noActiveIncidents => 'No active incidents';

  @override
  String get noActiveIncidentsListed => 'No active incidents listed.';

  @override
  String get noBookingsYet =>
      'No bookings yet. Submit your first service request.';

  @override
  String get noClaimedJobsYet => 'You have not claimed any jobs yet.';

  @override
  String get noCommunityPosts => 'No community posts yet.';

  @override
  String get noCurrentDeals => 'No current deals';

  @override
  String get noCurrentTrafficIncidents =>
      'No current traffic incidents are listed.';

  @override
  String get noDealsAvailable => 'No deals available right now.';

  @override
  String get noEmailAvailable => 'No email available';

  @override
  String get noJobsFound => 'No jobs found.';

  @override
  String get noNotifications => 'No notifications.';

  @override
  String get noOpenRequests => 'No open requests are available right now.';

  @override
  String get noPostsShareFirst => 'No posts yet. Be the first to share.';

  @override
  String get noProviderApplicationsFound => 'No provider applications found.';

  @override
  String get noProviderProfileLinked =>
      'No provider profile is linked to this account. Create a providers row using this user’s Auth UUID.';

  @override
  String get noRecentDiscussions => 'No recent discussions.';

  @override
  String get noRecentPosts => 'No recent posts.';

  @override
  String get noRepliesYet => 'No replies yet.';

  @override
  String get noVerifiedPriceReductions =>
      'No verified price reductions are active right now.';

  @override
  String get notAvailable => 'Not available';

  @override
  String get notProvided => 'Not provided';

  @override
  String notesValue(String notes) {
    return 'Notes: $notes';
  }

  @override
  String get notificationFallback => 'Notification';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get officialSourceLabel => 'Official source';

  @override
  String get openCalgaryDevelopmentMap => 'Open Calgary Development Map';

  @override
  String get openCalgaryMyTax => 'Open City of Calgary myTax';

  @override
  String get openCityTrafficReport => 'Open City traffic report';

  @override
  String get openRequestsTitle => 'Open requests';

  @override
  String get optionsTooltip => 'Options';

  @override
  String get otherLocalAssistance => 'Other local assistance';

  @override
  String get passwordHelperText => 'Use at least 8 characters.';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordMinLength =>
      'Password must contain at least 6 characters.';

  @override
  String get passwordMinLength8 => 'Password must be at least 8 characters.';

  @override
  String get passwordTooShort => 'Use at least 8 characters';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get permitFeedComingNext => 'Permit feed coming next';

  @override
  String get phoneNumberLabel => 'Phone number';

  @override
  String get postFallback => 'Post';

  @override
  String get posted => 'Posted';

  @override
  String postedOn(String date) {
    return 'Posted $date';
  }

  @override
  String get preferredTimeHint => 'Today 5–7 PM or Saturday morning';

  @override
  String get preferredTimeLabel => 'Preferred time';

  @override
  String preferredTimeValue(String time) {
    return 'Preferred time: $time';
  }

  @override
  String get price => 'Price';

  @override
  String get pricesTermsMayChange =>
      'Prices, stock, membership requirements, and promotion terms may change. Confirm directly with the store before visiting.';

  @override
  String get privacyReminderText =>
      'Do not include home addresses, faces, licence plates, phone numbers, or other private information.';

  @override
  String get profileUpdatedSuccess => 'Profile updated successfully.';

  @override
  String get providerApplicationTitle => 'Provider application';

  @override
  String get providerApprovalTitle => 'Provider approval';

  @override
  String get providerApprovedSuccess => 'Provider approved successfully.';

  @override
  String providerIdFallback(String id) {
    return 'Provider $id';
  }

  @override
  String get providerLabelPrefix => 'Provider: ';

  @override
  String get providerNotVerified =>
      'Your provider profile is not verified yet. Ask an administrator to set pvsc_verified to true.';

  @override
  String get providerPortal => 'Provider portal';

  @override
  String get providerPortalTitle => 'Provider Portal';

  @override
  String get providerPortalTooltip => 'Provider portal';

  @override
  String get providerVerificationRemoved =>
      'Provider verification was removed.';

  @override
  String get publishReportButton => 'Publish report';

  @override
  String get publishingEllipsis => 'Publishing…';

  @override
  String get rankedByVerifiedSavings => 'Ranked by verified percentage saved';

  @override
  String ratingValue(String rating) {
    return 'rating: $rating';
  }

  @override
  String get refreshBookings => 'Refresh bookings';

  @override
  String get refreshTooltip => 'Refresh';

  @override
  String get refreshTraffic => 'Refresh traffic';

  @override
  String get regularPrice => 'Regular price';

  @override
  String regularPriceValue(String price) {
    return 'Regular price \$$price';
  }

  @override
  String get rentalAvailabilityChangesNote =>
      'Calgary rental availability and recent median home-price changes.';

  @override
  String get rentalMarketVacancyRateTitle => 'Rental market vacancy rate';

  @override
  String get rentalVacancyRateLabel => 'Rental vacancy rate';

  @override
  String get replyAction => 'Reply';

  @override
  String get reportLocalConditionsTitle => 'Report local conditions';

  @override
  String get requestHelp => 'Request help';

  @override
  String requestedFromCommunityPost(String title) {
    return 'Requested from community post: $title\\n\\nPlease describe the help needed:';
  }

  @override
  String get resendConfirmationEmail => 'Resend confirmation email';

  @override
  String get retry => 'Retry';

  @override
  String get save => 'Save';

  @override
  String get saveOnGroceriesTitle => 'Save on groceries in Calgary';

  @override
  String get saveProfileButton => 'Save profile';

  @override
  String get savingEllipsis => 'Saving...';

  @override
  String get savings => 'Savings';

  @override
  String get search => 'Search';

  @override
  String get searchByProductOrStore => 'Search by product or store';

  @override
  String get serviceCategoryHint => 'Plumbing, furnace, snow removal...';

  @override
  String get serviceCategoryLabel => 'Service category';

  @override
  String get serviceFallback => 'Service';

  @override
  String get shareAnUpdate => 'Share an update';

  @override
  String get shareFactualConditionsHint => 'Share factual, current conditions.';

  @override
  String get shareLocalConditionsWarning =>
      'Share current local conditions. For an immediate emergency, call 911.';

  @override
  String get showList => 'Show list';

  @override
  String get showMap => 'Show map';

  @override
  String get signIn => 'Sign in';

  @override
  String get signInAsProvider => 'Please sign in as a provider.';

  @override
  String get signInBeforeBooking =>
      'Please sign in before submitting a booking.';

  @override
  String get signInBeforePosting => 'Please sign in before posting.';

  @override
  String get signInBeforeUpdatingProfile =>
      'Please sign in before updating your profile.';

  @override
  String signInFailed(String error) {
    return 'Sign-in failed: $error';
  }

  @override
  String get signInRequired => 'Sign in required';

  @override
  String get signInSubtitle => 'Sign in to book and manage home services.';

  @override
  String get signInToCreatePost =>
      'Sign in as a client or provider before creating a community post.';

  @override
  String get signInToReply => 'Sign in to reply.';

  @override
  String get signInToRequestHelp =>
      'Sign in to request help from a community post.';

  @override
  String get signInToViewBookings => 'Please sign in to view your bookings.';

  @override
  String get signInToViewNotifications =>
      'Please sign in to view notifications.';

  @override
  String get signInToViewProfile => 'Please sign in to view your profile.';

  @override
  String get signOut => 'Sign out';

  @override
  String get signOutTooltip => 'Sign out';

  @override
  String get signedInFallback => 'Signed in';

  @override
  String get signedInMember => 'Signed-in member';

  @override
  String get sourceCalgaryOpenData => 'Source: City of Calgary Open Data.';

  @override
  String get startJobButton => 'Start job';

  @override
  String get statusAccepted => 'Accepted';

  @override
  String get statusAssigned => 'Assigned';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusDeclined => 'Declined';

  @override
  String get statusInProgress => 'In progress';

  @override
  String get statusPending => 'Pending';

  @override
  String statusValue(String status) {
    return 'Status: $status';
  }

  @override
  String get store => 'Store';

  @override
  String get submit => 'Submit';

  @override
  String get submitApplicationButton => 'Submit application';

  @override
  String get submitApplicationSubtitle =>
      'Submit your application for admin approval.';

  @override
  String get submitBookingButton => 'Submit booking';

  @override
  String get submittingEllipsis => 'Submitting...';

  @override
  String get suspendButton => 'Suspend';

  @override
  String get textSizeLabel => 'Text Size';

  @override
  String get traffic => 'Traffic';

  @override
  String get trafficDetailsWarning =>
      'Traffic details can change quickly. Check the City of Calgary report for closures, detours, cameras, and route updates before travelling.';

  @override
  String get trafficIncidentFallback => 'Traffic incident';

  @override
  String get trafficIncidentReported => 'Traffic incident reported.';

  @override
  String get trafficRoadConditions => 'Road Conditions';

  @override
  String get trafficSourceNote =>
      'Traffic source: City of Calgary Open Data. Confirm conditions before travelling.';

  @override
  String get trafficUpdatesUnavailable => 'Traffic updates are unavailable.';

  @override
  String get tryAgainButton => 'Try again';

  @override
  String get unassigned => 'Unassigned';

  @override
  String get updateTimeUnavailable => 'Update time unavailable';

  @override
  String updatedPrefix(String time) {
    return 'Updated: $time';
  }

  @override
  String get vacancyRate2025Note =>
      'Calgary market vacancy rate in 2025, up from 4.6% in 2024.';

  @override
  String get vacancyRateExplainer =>
      'A higher vacancy rate can mean more rental options, but availability and rent still vary by neighbourhood and home type.';

  @override
  String get vacancyRateIncreaseNote =>
      'The market vacancy rate increased from 1.4% in 2023 to 5.1% in 2025.';

  @override
  String get verifiedLabel => 'Verified';

  @override
  String get viewAllGroceryDeals => 'View all grocery deals';

  @override
  String get viewCityHousingTrends => 'View City housing trends';

  @override
  String get viewDetails => 'View details';

  @override
  String get viewLatestStatistics => 'View the latest statistics';

  @override
  String get viewModeLabel => 'View Mode';

  @override
  String get weather => 'Weather';

  @override
  String get weatherRelatedHomeHelp => 'Weather-related home help';

  @override
  String get weatherUpdate => 'Weather update';

  @override
  String get weatherUpdatePublished => 'Weather update published.';

  @override
  String get weatherUpdatesTitle => 'Weather updates';

  @override
  String get welcomeToNeighbourCare => 'Welcome to NeighbourCare';

  @override
  String get whatIsHappeningLabel => 'What is happening?';

  @override
  String get writeAReplyHint => 'Write a reply...';

  @override
  String get yourAccountTitle => 'Your account';

  @override
  String get yoyChangeQ22026 => 'Year-over-year change, Q2 2026';

  @override
  String get updatingWeather => 'Updating Weather...';

  @override
  String weatherUpdateUnavailable(String error) {
    return 'Weather update unavailable: $error';
  }

  @override
  String get weatherAlertIssued => 'Weather Alert Issued';

  @override
  String get calgaryIntlAirport => 'Calgary Int\'l Airport';

  @override
  String weatherHumidity(String humidity) {
    return 'Humidity: $humidity%';
  }

  @override
  String weatherWind(String wind) {
    return 'Wind: $wind';
  }

  @override
  String weatherVisPres(String visibility, String pressure) {
    return 'Vis: $visibility • Pres: $pressure';
  }

  @override
  String get hideForecast => 'Hide Forecast';

  @override
  String get showFullForecast => 'Show 24-Hr & Multi-Day Forecast';

  @override
  String get hourlyForecastTitle => '24-Hour Forecast';

  @override
  String get multiDayOutlookTitle => 'Multi-Day Outlook';

  @override
  String weatherHigh(String temp) {
    return 'High $temp';
  }

  @override
  String weatherLow(String temp) {
    return 'Low $temp';
  }
}
