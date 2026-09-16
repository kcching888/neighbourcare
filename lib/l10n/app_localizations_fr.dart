// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get aboutNeighbourCare =>
      'NeighbourCare rapproche les voisins de Calgary des informations locales utiles et des ressources communautaires.';

  @override
  String get account => 'Compte';

  @override
  String get accountCreatedCheckEmail =>
      'Compte créé. Vérifiez votre courriel pour confirmer votre compte, puis connectez-vous.';

  @override
  String get accountCreatedCheckEmailReturn =>
      'Compte créé. Vérifiez votre courriel pour confirmer votre compte, puis revenez ici pour vous connecter.';

  @override
  String get accountCreatedSignedIn => 'Compte créé et connecté.';

  @override
  String activeIncidentsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString incidents actifs',
      one: '$countString incident actif',
    );
    return '$_temp0';
  }

  @override
  String get adminPortalTitle => 'Portail d\'administration';

  @override
  String get adminPortalTooltip => 'Portail d\'administration';

  @override
  String get alertTypeLabel => 'Type d\'alerte';

  @override
  String get all => 'Tous';

  @override
  String amountValue(String amount) {
    return 'Montant : $amount';
  }

  @override
  String get appName => 'NeighbourCare';

  @override
  String get applicationSubmittedPendingApproval =>
      'Demande soumise. Un administrateur doit approuver votre profil de prestataire avant que vous puissiez accepter des travaux.';

  @override
  String get applyNow => 'Postuler maintenant';

  @override
  String get applyToBecomeProvider => 'Postuler pour devenir prestataire';

  @override
  String get approveButton => 'Approuver';

  @override
  String get assessedValueExplainer =>
      'Une valeur imposable est utilisée pour l\'évaluation foncière et les taxes. Elle n\'est pas la même chose qu\'une estimation actuelle du prix de vente sur le marché.';

  @override
  String get assessedValueLookupTitle =>
      'Recherche de la valeur imposable municipale';

  @override
  String get assignButton => 'Attribuer';

  @override
  String get backToSignIn => 'Retour à la connexion';

  @override
  String get becomeAProviderTitle => 'Devenir prestataire';

  @override
  String get bestDealsThisWeek => 'Meilleures offres de la semaine';

  @override
  String get bookAHomeService => 'Réserver un service à domicile';

  @override
  String get bookServices => 'Réserver des services';

  @override
  String get bookingAssignedToProvider =>
      'Réservation attribuée au prestataire.';

  @override
  String bookingStartedFromPost(String title) {
    return 'Cette réservation provient de la publication communautaire : $title';
  }

  @override
  String bookingStatusUpdated(String status) {
    return 'Statut de la réservation mis à jour à $status.';
  }

  @override
  String bookingSubmittedSuccess(String id) {
    return 'Réservation soumise avec succès.\nNuméro de réservation : $id';
  }

  @override
  String get bookingsTitle => 'Réservations';

  @override
  String get browseGroceryDeals => 'Parcourir les offres d\'épicerie';

  @override
  String get browseOpenings => 'Parcourir les offres';

  @override
  String get calgary => 'Calgary';

  @override
  String get calgaryAlberta => 'CALGARY, ALBERTA';

  @override
  String get calgaryCommunityHub => 'Centre communautaire de Calgary';

  @override
  String get calgaryCommunityHubTraffic =>
      'Centre communautaire de Calgary - Circulation';

  @override
  String get calgaryHousingInfoTitle =>
      'Informations sur le logement à Calgary';

  @override
  String get calgaryHousingPortalTitle => 'Portail du logement de Calgary';

  @override
  String get calgaryHousingSnapshotTitle => 'Aperçu du logement à Calgary';

  @override
  String get calgaryMarketVacancyRateLabel =>
      'Taux d\'inoccupation du marché locatif de Calgary';

  @override
  String get cancel => 'Annuler';

  @override
  String get categoryBeef => 'Bœuf';

  @override
  String get categoryBreakfast => 'Déjeuner';

  @override
  String get categoryChicken => 'Poulet';

  @override
  String get categoryDairy => 'Produits laitiers';

  @override
  String get categoryFish => 'Poisson';

  @override
  String get categoryOther => 'Autre';

  @override
  String get categoryPork => 'Porc';

  @override
  String categoryPostsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString publications',
      one: '$countString publication',
    );
    return '$_temp0';
  }

  @override
  String get chooseTopicToPost => 'Choisir un sujet à publier';

  @override
  String get citywideMedianPriceNote =>
      'Il s\'agit des variations médianes des prix de vente à l\'échelle de la ville, par type de bâtiment. Elles ne représentent pas des évaluations individuelles.';

  @override
  String get claimJobButton => 'Réclamer la demande';

  @override
  String get claimUnassignedSubtitle =>
      'Réclamez une demande non attribuée. La première réclamation réussie gagne.';

  @override
  String get claimingEllipsis => 'Réclamation en cours...';

  @override
  String get clientSignIn => 'Connexion client';

  @override
  String get community => 'Communauté';

  @override
  String get communityFeeds => 'Fils communautaires';

  @override
  String get communityForumTooltip => 'Forum communautaire';

  @override
  String get communityPost => 'Publication communautaire';

  @override
  String get completeButton => 'Terminer';

  @override
  String get confirmPasswordLabel => 'Confirmer le mot de passe';

  @override
  String get confirmationEmailResent =>
      'Un nouveau courriel de confirmation a été envoyé. Utilisez uniquement le lien le plus récent et ouvrez-le une seule fois.';

  @override
  String couldNotAssignProvider(String error) {
    return 'Impossible d\'attribuer le prestataire : $error';
  }

  @override
  String couldNotClaimJob(String error) {
    return 'Impossible de réclamer le travail : $error';
  }

  @override
  String couldNotCreateAccount(String error) {
    return 'Impossible de créer le compte : $error';
  }

  @override
  String couldNotLaunchUrl(String url) {
    return 'Impossible de lancer $url';
  }

  @override
  String couldNotLoadAdminData(String error) {
    return 'Impossible de charger les données d\'administration : $error';
  }

  @override
  String couldNotLoadBookings(String error) {
    return 'Impossible de charger les réservations : $error';
  }

  @override
  String get couldNotLoadJobs => 'Impossible de charger les offres d\'emploi.';

  @override
  String couldNotLoadNotifications(String error) {
    return 'Impossible de charger les notifications : $error';
  }

  @override
  String get couldNotLoadPosts => 'Impossible de charger les publications';

  @override
  String couldNotLoadPostsError(String error) {
    return 'Impossible de charger les publications : $error';
  }

  @override
  String couldNotLoadProfile(String error) {
    return 'Impossible de charger le profil : $error';
  }

  @override
  String couldNotLoadProviderPortal(String error) {
    return 'Impossible de charger le portail des prestataires : $error';
  }

  @override
  String couldNotLoadReplies(String error) {
    return 'Impossible de charger les réponses : $error';
  }

  @override
  String couldNotMarkAsRead(String error) {
    return 'Impossible de marquer comme lu : $error';
  }

  @override
  String get couldNotOpenDirections => 'Impossible d\'ouvrir l\'itinéraire.';

  @override
  String get couldNotOpenTrafficReport =>
      'Impossible d\'ouvrir le rapport officiel sur la circulation de Calgary.';

  @override
  String couldNotPublish(String error) {
    return 'Impossible de publier : $error';
  }

  @override
  String couldNotResendConfirmation(String error) {
    return 'Impossible de renvoyer le courriel de confirmation : $error';
  }

  @override
  String couldNotSaveLoginName(String error) {
    return 'Impossible d\'enregistrer le nom de connexion : $error';
  }

  @override
  String couldNotSendReply(String error) {
    return 'Impossible d\'envoyer la réponse : $error';
  }

  @override
  String couldNotSignOut(String error) {
    return 'Impossible de se déconnecter : $error';
  }

  @override
  String couldNotSubmitApplication(String error) {
    return 'Impossible de soumettre la demande de prestataire : $error';
  }

  @override
  String couldNotSubmitBooking(String error) {
    return 'Impossible de soumettre la réservation : $error';
  }

  @override
  String couldNotUpdateBookingStatus(String error) {
    return 'Impossible de mettre à jour le statut de la réservation : $error';
  }

  @override
  String couldNotUpdateJobStatus(String error) {
    return 'Impossible de mettre à jour le statut du travail : $error';
  }

  @override
  String couldNotUpdateProfile(String error) {
    return 'Impossible de mettre à jour le profil : $error';
  }

  @override
  String couldNotUpdateProviderVerification(String error) {
    return 'Impossible de mettre à jour la vérification du prestataire : $error';
  }

  @override
  String couldNotVerifyRole(String error) {
    return 'Impossible de vérifier le rôle du compte : $error';
  }

  @override
  String get createAccountTitle => 'Créer un compte';

  @override
  String get createClientAccountSubtitle =>
      'Créez un compte client pour réserver des services locaux fiables.';

  @override
  String get createPost => 'Créer une publication';

  @override
  String get creatingAccountEllipsis => 'Création du compte...';

  @override
  String currentIncidentsShown(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString incidents actuels affichés.',
      one: '$countString incident actuel affiché.',
    );
    return '$_temp0';
  }

  @override
  String get dataSourcesLabel => 'Sources de données';

  @override
  String get deals => 'Offres';

  @override
  String get delete => 'Supprimer';

  @override
  String get describeIssueHint =>
      'Dites-nous ce qui doit être réparé ou terminé.';

  @override
  String get describeIssueLabel => 'Décrivez le problème';

  @override
  String get describeIssueValidator => 'Décrivez le problème';

  @override
  String get describeServiceSubtitle =>
      'Décrivez le service dont vous avez besoin à Calgary.';

  @override
  String get developmentNearYouTitle => 'Développement près de chez vous';

  @override
  String get dining => 'Restauration';

  @override
  String get diningPost => 'Publication sur la restauration';

  @override
  String get diningPostsTitle => 'Publications sur la restauration';

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
  String get displayNameLabel => 'Nom d\'affichage';

  @override
  String get diyHome => 'Bricolage et maison';

  @override
  String get diyHomePost => 'Publication bricolage et maison';

  @override
  String get diyHomeTitle => 'Bricolage et maison';

  @override
  String get edit => 'Modifier';

  @override
  String get emailAddressLabel => 'Adresse courriel';

  @override
  String get emailHint => 'vous@exemple.com';

  @override
  String get emailLabel => 'Courriel';

  @override
  String get enterAtLeast3Characters => 'Entrez au moins 3 caractères.';

  @override
  String get enterDisplayName =>
      'Entrez un nom à afficher dans l\'application.';

  @override
  String get enterEmailAddress => 'Entrez votre adresse courriel';

  @override
  String get enterEmailAndPassword => 'Entrez le courriel et le mot de passe.';

  @override
  String get enterEmailFirstResend =>
      'Entrez d\'abord l\'adresse courriel, puis renvoyez la confirmation.';

  @override
  String get enterFirstName => 'Entrez votre prénom.';

  @override
  String get enterFullName => 'Entrez votre nom complet';

  @override
  String get enterLastName => 'Entrez votre nom de famille.';

  @override
  String get enterLocation => 'Entrez votre emplacement';

  @override
  String get enterLoginName => 'Entrez un nom de connexion';

  @override
  String get enterNeighbourhood => 'Entrez un quartier.';

  @override
  String get enterPhoneNumber => 'Entrez un numéro de téléphone';

  @override
  String get enterServiceCategory => 'Entrez une catégorie de service';

  @override
  String get enterSignupDetails =>
      'Entrez votre nom complet, numéro de téléphone, courriel et mot de passe.';

  @override
  String get enterValidEmailAddress => 'Entrez une adresse courriel valide';

  @override
  String get enterYourNameHint => 'Entrez votre nom';

  @override
  String estimatedAmountValue(String amount) {
    return 'Montant estimé : $amount';
  }

  @override
  String get expiryDate => 'Date d\'expiration';

  @override
  String get exploreNeighbourCare => 'Découvrir NeighbourCare';

  @override
  String get exploreSubtitle =>
      'Des informations utiles sur Calgary, des liens locaux et des ressources quotidiennes, tout en un seul endroit.';

  @override
  String get filter => 'Filtrer';

  @override
  String get filterAll => 'Tous';

  @override
  String get filterLabelPrefix => 'Filtrer : ';

  @override
  String get findAssessedValueNote =>
      'Trouvez la valeur imposable municipale d\'une propriété précise à Calgary.';

  @override
  String get firstNameLabel => 'Prénom';

  @override
  String get fontSizeLarge => 'Grand';

  @override
  String get fontSizeNormal => 'Normal';

  @override
  String get fontSizeSmall => 'Petit';

  @override
  String get forceAcceptButton => 'Forcer l\'acceptation';

  @override
  String get forceDeclineButton => 'Forcer le refus';

  @override
  String get fullNameHint => 'Votre prénom et nom de famille';

  @override
  String get fullNameLabel => 'Nom complet';

  @override
  String get getDirections => 'Obtenir l\'itinéraire';

  @override
  String groceryDealsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString offres d\'épicerie',
      one: '$countString offre d\'épicerie',
    );
    return '$_temp0';
  }

  @override
  String get heroSubtitle =>
      'Actualités locales, circulation, offres, logement et mises à jour menées par les voisins.';

  @override
  String get heroTitle =>
      'Votre communauté de Calgary, réunie en un seul endroit.';

  @override
  String get hideReplies => 'Masquer les réponses';

  @override
  String get home => 'Accueil';

  @override
  String get homeRepairDiyHelp => 'Réparation domiciliaire / bricolage';

  @override
  String get homeServiceFallback => 'Service à domicile';

  @override
  String get housing => 'Logement';

  @override
  String get housingAndDevelopment => 'Logement et développement';

  @override
  String get housingDataRefreshed => 'Données sur le logement actualisées.';

  @override
  String get housingDataSourcesText =>
      'Les statistiques sur le logement proviennent de la recherche sur le logement de la Ville de Calgary et des informations sur le marché de la SCHL. Les évaluations foncières et les détails de développement sont fournis par les outils officiels de la Ville de Calgary.';

  @override
  String get housingInfoDescription =>
      'Explorez les tendances du marché locatif, les changements récents des prix des maisons, les évaluations foncières officielles et les activités de développement à venir.';

  @override
  String get housingTypeApartment => 'Appartement';

  @override
  String get housingTypeDetached => 'Maison individuelle';

  @override
  String get housingTypeRowTownhouse => 'Maison en rangée';

  @override
  String get housingTypeSemiDetached => 'Maison jumelée';

  @override
  String get jobAlreadyClaimed =>
      'Cette demande a déjà été réclamée par un autre prestataire. La liste va maintenant s\'actualiser.';

  @override
  String get jobClaimedSuccess => 'Demande réclamée avec succès.';

  @override
  String get jobListings => 'Offres d\'emploi';

  @override
  String jobOpeningsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString offres',
      one: '$countString offre',
    );
    return '$_temp0';
  }

  @override
  String jobStatusChanged(String status) {
    return 'Statut du travail changé à $status.';
  }

  @override
  String get jobs => 'Emplois';

  @override
  String get joinConversation => 'Rejoindre la conversation';

  @override
  String get joinNeighbourCare => 'Rejoindre NeighbourCare';

  @override
  String get lastNameLabel => 'Nom de famille';

  @override
  String lastRefreshedPrefix(String time) {
    return 'Dernière actualisation : $time';
  }

  @override
  String get listLabel => 'Liste';

  @override
  String get live => 'EN DIRECT';

  @override
  String get liveDealsSubtitle =>
      'Offres en direct des magasins locaux participants. Tirez vers le bas pour actualiser.';

  @override
  String get loading => 'Chargement...';

  @override
  String get loadingDeals => 'Chargement des offres...';

  @override
  String get loadingDiscussions => 'Chargement des discussions...';

  @override
  String get loadingJobs => 'Chargement des offres d\'emploi...';

  @override
  String get loadingLiveUpdates => 'Chargement des mises à jour en direct...';

  @override
  String get loadingPosts => 'Chargement des publications...';

  @override
  String get loadingTrafficUpdates =>
      'Chargement des mises à jour de la circulation...';

  @override
  String get localSavings => 'Économies locales';

  @override
  String localSavingsCouldNotUpdate(String error) {
    return 'Les économies locales n\'ont pas pu être mises à jour :\n\n$error';
  }

  @override
  String get localUpdateLabel => 'Mise à jour locale';

  @override
  String get locationHint => 'Quartier ou code postal';

  @override
  String get locationLabel => 'Emplacement';

  @override
  String get locationRadiusNote =>
      'L\'emplacement sera facultatif. Une fois activé, vous pourrez choisir un rayon de recherche de 2 km, 5 km, ou 10 km par défaut.';

  @override
  String get locationUnavailable => 'Emplacement non disponible';

  @override
  String locationValue(String location) {
    return 'Emplacement : $location';
  }

  @override
  String get loginNameHint => 'Comment les autres membres vous verront';

  @override
  String get loginNameLabel => 'Nom de connexion';

  @override
  String get loginNameMinLength =>
      'Le nom de connexion doit comporter au moins 3 caractères';

  @override
  String get loginNameTaken =>
      'Ce nom de connexion est déjà pris. Veuillez en choisir un autre.';

  @override
  String get mapLabel => 'Carte';

  @override
  String get markAsReadTooltip => 'Marquer comme lu';

  @override
  String get markCompletedButton => 'Marquer comme terminé';

  @override
  String get marketMetricsSubtitle =>
      'Indicateurs du marché et permis de développement';

  @override
  String get marketPriceTrendsTitle => 'Tendances des prix du marché';

  @override
  String get marketplace => 'Petites annonces';

  @override
  String get marketplaceSubtitle => 'Acheter, vendre et partager';

  @override
  String get medianHomePricesTitle =>
      'Prix médians des maisons par type de bâtiment';

  @override
  String get memberFallback => 'Membre';

  @override
  String get myAssignedJobsTitle => 'Mes travaux attribués';

  @override
  String get myBookings => 'Mes réservations';

  @override
  String get myProfileTitle => 'Mon profil';

  @override
  String get neighbourCareCalgaryTitle => 'NeighbourCare Calgary';

  @override
  String get neighbourCareCommunity => 'Communauté NeighbourCare';

  @override
  String get neighbourCareServicesTitle => 'Services NeighbourCare';

  @override
  String get neighbourhoodExampleHint => 'Exemple : Beltline';

  @override
  String get neighbourhoodHint => 'Par exemple : Beltline ou Tuscany';

  @override
  String get neighbourhoodLabel => 'Quartier';

  @override
  String get neighbourhoodOptionalLabel => 'Quartier de Calgary (facultatif)';

  @override
  String get newToNeighbourCareSignUp =>
      'Nouveau sur NeighbourCare? Inscrivez-vous';

  @override
  String get newestApplicationsNote =>
      'Les demandes les plus récentes à l\'échelle de Calgary apparaîtront ici en premier.';

  @override
  String get news => 'Actualités';

  @override
  String get noActiveDealsMatch =>
      'Aucune offre active ne correspond à cette recherche ou catégorie.';

  @override
  String get noActiveIncidents => 'Aucun incident actif';

  @override
  String get noActiveIncidentsListed => 'Aucun incident actif signalé.';

  @override
  String get noBookingsYet =>
      'Aucune réservation pour l\'instant. Soumettez votre première demande de service.';

  @override
  String get noClaimedJobsYet => 'Vous n\'avez encore réclamé aucun travail.';

  @override
  String get noCommunityPosts =>
      'Aucune publication communautaire pour l\'instant.';

  @override
  String get noCurrentDeals => 'Aucune offre actuelle';

  @override
  String get noCurrentTrafficIncidents =>
      'Aucun incident de circulation actif n\'est répertorié.';

  @override
  String get noDealsAvailable => 'Aucune offre disponible pour le moment.';

  @override
  String get noEmailAvailable => 'Aucun courriel disponible';

  @override
  String get noJobsFound => 'Aucune offre d\'emploi trouvée.';

  @override
  String get noNotifications => 'Aucune notification.';

  @override
  String get noOpenRequests =>
      'Aucune demande ouverte n\'est disponible pour le moment.';

  @override
  String get noPostsShareFirst =>
      'Aucune publication pour l\'instant. Soyez le premier à partager.';

  @override
  String get noProviderApplicationsFound =>
      'Aucune demande de prestataire trouvée.';

  @override
  String get noProviderProfileLinked =>
      'Aucun profil de prestataire n\'est lié à ce compte. Créez une ligne dans providers avec l\'UUID d\'authentification de cet utilisateur.';

  @override
  String get noRecentDiscussions => 'Aucune discussion récente.';

  @override
  String get noRecentPosts => 'Aucune publication récente.';

  @override
  String get noRepliesYet => 'Aucune réponse pour l\'instant.';

  @override
  String get noVerifiedPriceReductions =>
      'Aucune réduction de prix vérifiée n\'est active pour le moment.';

  @override
  String get notAvailable => 'Non disponible';

  @override
  String get notProvided => 'Non fourni';

  @override
  String notesValue(String notes) {
    return 'Notes : $notes';
  }

  @override
  String get notificationFallback => 'Notification';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get officialSourceLabel => 'Source officielle';

  @override
  String get openCalgaryDevelopmentMap =>
      'Ouvrir la carte de développement de Calgary';

  @override
  String get openCalgaryMyTax => 'Ouvrir myTax de la Ville de Calgary';

  @override
  String get openCityTrafficReport =>
      'Ouvrir le rapport de circulation de la Ville';

  @override
  String get openRequestsTitle => 'Demandes ouvertes';

  @override
  String get optionsTooltip => 'Options';

  @override
  String get otherLocalAssistance => 'Autre aide locale';

  @override
  String get passwordHelperText => 'Utilisez au moins 8 caractères.';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get passwordMinLength =>
      'Le mot de passe doit contenir au moins 6 caractères.';

  @override
  String get passwordMinLength8 =>
      'Le mot de passe doit contenir au moins 8 caractères.';

  @override
  String get passwordTooShort => 'Utilisez au moins 8 caractères';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get permitFeedComingNext => 'Fil des permis à venir';

  @override
  String get phoneNumberLabel => 'Numéro de téléphone';

  @override
  String get postFallback => 'Publication';

  @override
  String get posted => 'Publié';

  @override
  String postedOn(String date) {
    return 'Publié $date';
  }

  @override
  String get preferredTimeHint => 'Aujourd\'hui de 17 h à 19 h ou samedi matin';

  @override
  String get preferredTimeLabel => 'Heure préférée';

  @override
  String preferredTimeValue(String time) {
    return 'Heure préférée : $time';
  }

  @override
  String get price => 'Prix';

  @override
  String get pricesTermsMayChange =>
      'Les prix, les stocks, les exigences d\'adhésion et les conditions de promotion peuvent changer. Confirmez directement avec le magasin avant de vous y rendre.';

  @override
  String get privacyReminderText =>
      'N\'incluez pas d\'adresses, de visages, de plaques d\'immatriculation, de numéros de téléphone ou d\'autres renseignements privés.';

  @override
  String get profileUpdatedSuccess => 'Profil mis à jour avec succès.';

  @override
  String get providerApplicationTitle => 'Demande de prestataire';

  @override
  String get providerApprovalTitle => 'Approbation des prestataires';

  @override
  String get providerApprovedSuccess => 'Prestataire approuvé avec succès.';

  @override
  String providerIdFallback(String id) {
    return 'Prestataire $id';
  }

  @override
  String get providerLabelPrefix => 'Prestataire : ';

  @override
  String get providerNotVerified =>
      'Votre profil de prestataire n\'est pas encore vérifié. Demandez à un administrateur de définir pvsc_verified à true.';

  @override
  String get providerPortal => 'Portail des prestataires';

  @override
  String get providerPortalTitle => 'Portail des prestataires';

  @override
  String get providerPortalTooltip => 'Portail des prestataires';

  @override
  String get providerVerificationRemoved =>
      'La vérification du prestataire a été retirée.';

  @override
  String get publishReportButton => 'Publier le rapport';

  @override
  String get publishingEllipsis => 'Publication en cours…';

  @override
  String get rankedByVerifiedSavings =>
      'Classé par pourcentage d\'économies vérifié';

  @override
  String ratingValue(String rating) {
    return 'note : $rating';
  }

  @override
  String get refreshBookings => 'Actualiser les réservations';

  @override
  String get refreshTooltip => 'Actualiser';

  @override
  String get refreshTraffic => 'Actualiser la circulation';

  @override
  String get regularPrice => 'Prix régulier';

  @override
  String regularPriceValue(String price) {
    return 'Prix régulier : $price';
  }

  @override
  String get rentalAvailabilityChangesNote =>
      'Disponibilité locative à Calgary et changements récents des prix médians des maisons.';

  @override
  String get rentalMarketVacancyRateTitle =>
      'Taux d\'inoccupation du marché locatif';

  @override
  String get rentalVacancyRateLabel => 'Taux d\'inoccupation locatif';

  @override
  String get replyAction => 'Répondre';

  @override
  String get reportLocalConditionsTitle => 'Signaler les conditions locales';

  @override
  String get requestHelp => 'Demander de l\'aide';

  @override
  String requestedFromCommunityPost(String title) {
    return 'Demande provenant de la publication communautaire : $title\n\nVeuillez décrire l\'aide nécessaire :';
  }

  @override
  String get resendConfirmationEmail => 'Renvoyer le courriel de confirmation';

  @override
  String get retry => 'Réessayer';

  @override
  String get save => 'Enregistrer';

  @override
  String get saveOnGroceriesTitle => 'Économisez sur l\'épicerie à Calgary';

  @override
  String get saveProfileButton => 'Enregistrer le profil';

  @override
  String get savingEllipsis => 'Enregistrement...';

  @override
  String get savings => 'Économies';

  @override
  String get search => 'Rechercher';

  @override
  String get searchByProductOrStore => 'Rechercher par produit ou magasin';

  @override
  String get serviceCategoryHint => 'Plomberie, chauffage, déneigement...';

  @override
  String get serviceCategoryLabel => 'Catégorie de service';

  @override
  String get serviceFallback => 'Service';

  @override
  String get shareAnUpdate => 'Partager une mise à jour';

  @override
  String get shareFactualConditionsHint =>
      'Partagez des conditions actuelles et factuelles.';

  @override
  String get shareLocalConditionsWarning =>
      'Partagez les conditions locales actuelles. En cas d\'urgence immédiate, appelez le 911.';

  @override
  String get showList => 'Afficher la liste';

  @override
  String get showMap => 'Afficher la carte';

  @override
  String get signIn => 'Se connecter';

  @override
  String get signInAsProvider =>
      'Veuillez vous connecter en tant que prestataire.';

  @override
  String get signInBeforeBooking =>
      'Veuillez vous connecter avant de soumettre une réservation.';

  @override
  String get signInBeforePosting => 'Veuillez vous connecter avant de publier.';

  @override
  String get signInBeforeUpdatingProfile =>
      'Veuillez vous connecter avant de mettre à jour votre profil.';

  @override
  String signInFailed(String error) {
    return 'Connexion échouée : $error';
  }

  @override
  String get signInRequired => 'Connexion requise';

  @override
  String get signInSubtitle =>
      'Connectez-vous pour réserver et gérer des services à domicile.';

  @override
  String get signInToCreatePost =>
      'Connectez-vous en tant que client ou prestataire avant de créer une publication communautaire.';

  @override
  String get signInToReply => 'Connectez-vous pour répondre.';

  @override
  String get signInToRequestHelp =>
      'Connectez-vous pour demander de l\'aide depuis une publication communautaire.';

  @override
  String get signInToViewBookings =>
      'Veuillez vous connecter pour voir vos réservations.';

  @override
  String get signInToViewNotifications =>
      'Veuillez vous connecter pour voir vos notifications.';

  @override
  String get signInToViewProfile =>
      'Veuillez vous connecter pour voir votre profil.';

  @override
  String get signOut => 'Se déconnecter';

  @override
  String get signOutTooltip => 'Se déconnecter';

  @override
  String get signedInFallback => 'Connecté';

  @override
  String get signedInMember => 'Membre connecté';

  @override
  String get sourceCalgaryOpenData =>
      'Source : données ouvertes de la Ville de Calgary.';

  @override
  String get startJobButton => 'Démarrer le travail';

  @override
  String get statusAccepted => 'Accepté';

  @override
  String get statusAssigned => 'Attribué';

  @override
  String get statusCancelled => 'Annulé';

  @override
  String get statusCompleted => 'Terminé';

  @override
  String get statusDeclined => 'Refusé';

  @override
  String get statusInProgress => 'En cours';

  @override
  String get statusPending => 'En attente';

  @override
  String statusValue(String status) {
    return 'Statut : $status';
  }

  @override
  String get store => 'Magasin';

  @override
  String get submit => 'Soumettre';

  @override
  String get submitApplicationButton => 'Soumettre la demande';

  @override
  String get submitApplicationSubtitle =>
      'Soumettez votre demande pour approbation administrative.';

  @override
  String get submitBookingButton => 'Soumettre la réservation';

  @override
  String get submittingEllipsis => 'Soumission en cours...';

  @override
  String get suspendButton => 'Suspendre';

  @override
  String get textSizeLabel => 'Taille du texte';

  @override
  String get traffic => 'Circulation';

  @override
  String get trafficDetailsWarning =>
      'Les conditions de circulation peuvent changer rapidement. Consultez le rapport de la Ville de Calgary pour connaître les fermetures, les détours, les caméras et les mises à jour d\'itinéraire avant de voyager.';

  @override
  String get trafficIncidentFallback => 'Incident de circulation';

  @override
  String get trafficIncidentReported => 'Incident de circulation signalé.';

  @override
  String get trafficRoadConditions => 'État des routes';

  @override
  String get trafficSourceNote =>
      'Source du trafic : données ouvertes de la Ville de Calgary. Vérifiez les conditions avant de voyager.';

  @override
  String get trafficUpdatesUnavailable =>
      'Les mises à jour de la circulation ne sont pas disponibles.';

  @override
  String get tryAgainButton => 'Réessayer';

  @override
  String get unassigned => 'Non attribué';

  @override
  String get updateTimeUnavailable => 'Heure de mise à jour non disponible';

  @override
  String updatedPrefix(String time) {
    return 'Mis à jour : $time';
  }

  @override
  String get vacancyRate2025Note =>
      'Taux d\'inoccupation du marché de Calgary en 2025, en hausse par rapport à 4,6 % en 2024.';

  @override
  String get vacancyRateExplainer =>
      'Un taux d\'inoccupation plus élevé peut signifier plus d\'options de location, mais la disponibilité et le loyer varient encore selon le quartier et le type de logement.';

  @override
  String get vacancyRateIncreaseNote =>
      'Le taux d\'inoccupation du marché est passé de 1,4 % en 2023 à 5,1 % en 2025.';

  @override
  String get verifiedLabel => 'Vérifié';

  @override
  String get viewAllGroceryDeals => 'Voir toutes les offres d\'épicerie';

  @override
  String get viewCityHousingTrends =>
      'Voir les tendances du logement de la Ville';

  @override
  String get viewDetails => 'Voir les détails';

  @override
  String get viewLatestStatistics => 'Voir les dernières statistiques';

  @override
  String get viewModeLabel => 'Mode d\'affichage';

  @override
  String get weather => 'Météo';

  @override
  String get weatherRelatedHomeHelp => 'Aide domiciliaire liée à la météo';

  @override
  String get weatherUpdate => 'Mise à jour météo';

  @override
  String get weatherUpdatePublished => 'Mise à jour météo publiée.';

  @override
  String get weatherUpdatesTitle => 'Mises à jour météo';

  @override
  String get welcomeToNeighbourCare => 'Bienvenue sur NeighbourCare';

  @override
  String get whatIsHappeningLabel => 'Que se passe-t-il?';

  @override
  String get writeAReplyHint => 'Écrire une réponse...';

  @override
  String get yourAccountTitle => 'Votre compte';

  @override
  String get yoyChangeQ22026 => 'Variation sur un an, T2 2026';

  @override
  String get updatingWeather => 'Mise à jour de la météo...';

  @override
  String weatherUpdateUnavailable(String error) {
    return 'Mise à jour météo indisponible : $error';
  }

  @override
  String get weatherAlertIssued => 'Alerte météo émise';

  @override
  String get calgaryIntlAirport => 'Aéroport international de Calgary';

  @override
  String weatherHumidity(String humidity) {
    return 'Humidité : $humidity%';
  }

  @override
  String weatherWind(String wind) {
    return 'Vent : $wind';
  }

  @override
  String weatherVisPres(String visibility, String pressure) {
    return 'Vis : $visibility • Pres : $pressure';
  }

  @override
  String get hideForecast => 'Masquer les prévisions';

  @override
  String get showFullForecast =>
      'Afficher les prévisions sur 24h et multijours';

  @override
  String get hourlyForecastTitle => 'Prévisions sur 24 heures';

  @override
  String get multiDayOutlookTitle => 'Aperçu sur plusieurs jours';

  @override
  String weatherHigh(String temp) {
    return 'Max $temp';
  }

  @override
  String weatherLow(String temp) {
    return 'Min $temp';
  }
}
