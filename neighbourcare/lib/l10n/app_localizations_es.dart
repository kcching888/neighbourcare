// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get aboutNeighbourCare =>
      'NeighbourCare acerca a los vecinos de Calgary a información local útil y recursos comunitarios.';

  @override
  String get account => 'Cuenta';

  @override
  String get accountCreatedCheckEmail =>
      'Cuenta creada. Revisa tu correo para confirmar tu cuenta y luego inicia sesión.';

  @override
  String get accountCreatedCheckEmailReturn =>
      'Cuenta creada. Revisa tu correo para confirmar tu cuenta y luego vuelve aquí para iniciar sesión.';

  @override
  String get accountCreatedSignedIn => 'Cuenta creada y sesión iniciada.';

  @override
  String activeIncidentsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString incidentes activos',
      one: '$countString incidente activo',
    );
    return '$_temp0';
  }

  @override
  String get adminPortalTitle => 'Portal de administración';

  @override
  String get adminPortalTooltip => 'Portal de administración';

  @override
  String get alertTypeLabel => 'Tipo de alerta';

  @override
  String get all => 'Todos';

  @override
  String amountValue(String amount) {
    return 'Monto: $amount';
  }

  @override
  String get appName => 'NeighbourCare';

  @override
  String get applicationSubmittedPendingApproval =>
      'Solicitud enviada. Un administrador debe aprobar tu perfil de proveedor antes de que puedas aceptar trabajos.';

  @override
  String get applyNow => 'Postularse ahora';

  @override
  String get applyToBecomeProvider => 'Solicitar para convertirte en proveedor';

  @override
  String get approveButton => 'Aprobar';

  @override
  String get assessedValueExplainer =>
      'Un valor catastral se usa para la evaluación de la propiedad y los impuestos. No es lo mismo que una estimación actual del precio de venta en el mercado.';

  @override
  String get assessedValueLookupTitle =>
      'Consulta del valor catastral municipal';

  @override
  String get assignButton => 'Asignar';

  @override
  String get backToSignIn => 'Volver a iniciar sesión';

  @override
  String get becomeAProviderTitle => 'Convertirse en proveedor';

  @override
  String get bestDealsThisWeek => 'Mejores ofertas de esta semana';

  @override
  String get bookAHomeService => 'Reservar un servicio a domicilio';

  @override
  String get bookServices => 'Reservar servicios';

  @override
  String get bookingAssignedToProvider => 'Reserva asignada al proveedor.';

  @override
  String bookingStartedFromPost(String title) {
    return 'Esta reserva comenzó desde la publicación comunitaria: $title';
  }

  @override
  String bookingStatusUpdated(String status) {
    return 'Estado de la reserva actualizado a $status.';
  }

  @override
  String bookingSubmittedSuccess(String id) {
    return 'Reserva enviada con éxito.\nID de reserva: $id';
  }

  @override
  String get bookingsTitle => 'Reservas';

  @override
  String get browseGroceryDeals => 'Explorar ofertas de supermercado';

  @override
  String get browseOpenings => 'Explorar vacantes';

  @override
  String get calgary => 'Calgary';

  @override
  String get calgaryAlberta => 'CALGARY, ALBERTA';

  @override
  String get calgaryCommunityHub => 'Centro comunitario de Calgary';

  @override
  String get calgaryCommunityHubTraffic =>
      'Centro comunitario de Calgary - Tráfico';

  @override
  String get calgaryHousingInfoTitle => 'Información sobre vivienda en Calgary';

  @override
  String get calgaryHousingPortalTitle => 'Portal de vivienda de Calgary';

  @override
  String get calgaryHousingSnapshotTitle => 'Panorama de vivienda en Calgary';

  @override
  String get calgaryMarketVacancyRateLabel =>
      'Tasa de desocupación del mercado de alquiler de Calgary';

  @override
  String get cancel => 'Cancelar';

  @override
  String get categoryBeef => 'Res';

  @override
  String get categoryBreakfast => 'Desayuno';

  @override
  String get categoryChicken => 'Pollo';

  @override
  String get categoryDairy => 'Lácteos';

  @override
  String get categoryFish => 'Pescado';

  @override
  String get categoryOther => 'Otro';

  @override
  String get categoryPork => 'Cerdo';

  @override
  String categoryPostsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString publicaciones',
      one: '$countString publicación',
    );
    return '$_temp0';
  }

  @override
  String get chooseTopicToPost => 'Elegir un tema para publicar';

  @override
  String get citywideMedianPriceNote =>
      'Estos son cambios en el precio medio de venta a nivel de la ciudad, por tipo de edificio. No son valoraciones de propiedades individuales.';

  @override
  String get claimJobButton => 'Reclamar trabajo';

  @override
  String get claimUnassignedSubtitle =>
      'Reclama una solicitud sin asignar. Gana la primera reclamación exitosa.';

  @override
  String get claimingEllipsis => 'Reclamando...';

  @override
  String get clientSignIn => 'Inicio de sesión de cliente';

  @override
  String get community => 'Comunidad';

  @override
  String get communityFeeds => 'Publicaciones comunitarias';

  @override
  String get communityForumTooltip => 'Foro comunitario';

  @override
  String get communityPost => 'Publicación comunitaria';

  @override
  String get completeButton => 'Completar';

  @override
  String get confirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get confirmationEmailResent =>
      'Se ha enviado un nuevo correo de confirmación. Usa solo el enlace más reciente y ábrelo una sola vez.';

  @override
  String couldNotAssignProvider(String error) {
    return 'No se pudo asignar el proveedor: $error';
  }

  @override
  String couldNotClaimJob(String error) {
    return 'No se pudo reclamar el trabajo: $error';
  }

  @override
  String couldNotCreateAccount(String error) {
    return 'No se pudo crear la cuenta: $error';
  }

  @override
  String couldNotLaunchUrl(String url) {
    return 'No se pudo abrir $url';
  }

  @override
  String couldNotLoadAdminData(String error) {
    return 'No se pudieron cargar los datos de administración: $error';
  }

  @override
  String couldNotLoadBookings(String error) {
    return 'No se pudieron cargar las reservas: $error';
  }

  @override
  String get couldNotLoadJobs => 'No se pudieron cargar los empleos.';

  @override
  String couldNotLoadNotifications(String error) {
    return 'No se pudieron cargar las notificaciones: $error';
  }

  @override
  String get couldNotLoadPosts => 'No se pudieron cargar las publicaciones';

  @override
  String couldNotLoadPostsError(String error) {
    return 'No se pudieron cargar las publicaciones: $error';
  }

  @override
  String couldNotLoadProfile(String error) {
    return 'No se pudo cargar el perfil: $error';
  }

  @override
  String couldNotLoadProviderPortal(String error) {
    return 'No se pudo cargar el portal de proveedores: $error';
  }

  @override
  String couldNotLoadReplies(String error) {
    return 'No se pudieron cargar las respuestas: $error';
  }

  @override
  String couldNotMarkAsRead(String error) {
    return 'No se pudo marcar como leído: $error';
  }

  @override
  String get couldNotOpenDirections => 'No se pudieron abrir las indicaciones.';

  @override
  String get couldNotOpenTrafficReport =>
      'No se pudo abrir el informe oficial de tráfico de Calgary.';

  @override
  String couldNotPublish(String error) {
    return 'No se pudo publicar: $error';
  }

  @override
  String couldNotResendConfirmation(String error) {
    return 'No se pudo reenviar el correo de confirmación: $error';
  }

  @override
  String couldNotSaveLoginName(String error) {
    return 'No se pudo guardar el nombre de usuario: $error';
  }

  @override
  String couldNotSendReply(String error) {
    return 'No se pudo enviar la respuesta: $error';
  }

  @override
  String couldNotSignOut(String error) {
    return 'No se pudo cerrar sesión: $error';
  }

  @override
  String couldNotSubmitApplication(String error) {
    return 'No se pudo enviar la solicitud de proveedor: $error';
  }

  @override
  String couldNotSubmitBooking(String error) {
    return 'No se pudo enviar la reserva: $error';
  }

  @override
  String couldNotUpdateBookingStatus(String error) {
    return 'No se pudo actualizar el estado de la reserva: $error';
  }

  @override
  String couldNotUpdateJobStatus(String error) {
    return 'No se pudo actualizar el estado del trabajo: $error';
  }

  @override
  String couldNotUpdateProfile(String error) {
    return 'No se pudo actualizar el perfil: $error';
  }

  @override
  String couldNotUpdateProviderVerification(String error) {
    return 'No se pudo actualizar la verificación del proveedor: $error';
  }

  @override
  String couldNotVerifyRole(String error) {
    return 'No se pudo verificar el rol de la cuenta: $error';
  }

  @override
  String get createAccountTitle => 'Crear cuenta';

  @override
  String get createClientAccountSubtitle =>
      'Crea una cuenta de cliente para reservar servicios locales de confianza.';

  @override
  String get createPost => 'Crear publicación';

  @override
  String get creatingAccountEllipsis => 'Creando cuenta...';

  @override
  String currentIncidentsShown(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString incidentes actuales mostrados.',
      one: '$countString incidente actual mostrado.',
    );
    return '$_temp0';
  }

  @override
  String get dataSourcesLabel => 'Fuentes de datos';

  @override
  String get deals => 'Ofertas';

  @override
  String get delete => 'Eliminar';

  @override
  String get describeIssueHint =>
      'Cuéntanos qué necesita reparación o finalización.';

  @override
  String get describeIssueLabel => 'Describe el problema';

  @override
  String get describeIssueValidator => 'Describe el problema';

  @override
  String get describeServiceSubtitle =>
      'Describe el servicio que necesitas en Calgary.';

  @override
  String get developmentNearYouTitle => 'Desarrollo cerca de ti';

  @override
  String get dining => 'Restaurantes';

  @override
  String get diningPost => 'Publicación de restaurantes';

  @override
  String get diningPostsTitle => 'Publicaciones de restaurantes';

  @override
  String get discussionFallback => 'Discusión';

  @override
  String discussionsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString discusiones',
      one: '$countString discusión',
    );
    return '$_temp0';
  }

  @override
  String get displayNameLabel => 'Nombre para mostrar';

  @override
  String get diyHome => 'Bricolaje y hogar';

  @override
  String get diyHomePost => 'Publicación de bricolaje y hogar';

  @override
  String get diyHomeTitle => 'Bricolaje y hogar';

  @override
  String get edit => 'Editar';

  @override
  String get emailAddressLabel => 'Correo electrónico';

  @override
  String get emailHint => 'tu@ejemplo.com';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get enterAtLeast3Characters => 'Ingresa al menos 3 caracteres.';

  @override
  String get enterDisplayName =>
      'Ingresa un nombre para mostrar en la aplicación.';

  @override
  String get enterEmailAddress => 'Ingresa tu correo electrónico';

  @override
  String get enterEmailAndPassword => 'Ingresa el correo y la contraseña.';

  @override
  String get enterEmailFirstResend =>
      'Ingresa primero el correo electrónico y luego reenvía la confirmación.';

  @override
  String get enterFirstName => 'Ingresa tu nombre.';

  @override
  String get enterFullName => 'Ingresa tu nombre completo';

  @override
  String get enterLastName => 'Ingresa tu apellido.';

  @override
  String get enterLocation => 'Ingresa tu ubicación';

  @override
  String get enterLoginName => 'Ingresa un nombre de usuario';

  @override
  String get enterNeighbourhood => 'Ingresa un vecindario.';

  @override
  String get enterPhoneNumber => 'Ingresa un número de teléfono';

  @override
  String get enterServiceCategory => 'Ingresa una categoría de servicio';

  @override
  String get enterSignupDetails =>
      'Ingresa tu nombre completo, número de teléfono, correo y contraseña.';

  @override
  String get enterValidEmailAddress => 'Ingresa un correo electrónico válido';

  @override
  String get enterYourNameHint => 'Ingresa tu nombre';

  @override
  String estimatedAmountValue(String amount) {
    return 'Monto estimado: $amount';
  }

  @override
  String get expiryDate => 'Fecha de vencimiento';

  @override
  String get exploreNeighbourCare => 'Explorar NeighbourCare';

  @override
  String get exploreSubtitle =>
      'Información útil de Calgary, conexiones locales y recursos cotidianos en un solo lugar.';

  @override
  String get filter => 'Filtrar';

  @override
  String get filterAll => 'Todos';

  @override
  String get filterLabelPrefix => 'Filtrar: ';

  @override
  String get findAssessedValueNote =>
      'Encuentra el valor catastral municipal de una propiedad específica en Calgary.';

  @override
  String get firstNameLabel => 'Nombre';

  @override
  String get fontSizeLarge => 'Grande';

  @override
  String get fontSizeNormal => 'Normal';

  @override
  String get fontSizeSmall => 'Pequeño';

  @override
  String get forceAcceptButton => 'Forzar aceptación';

  @override
  String get forceDeclineButton => 'Forzar rechazo';

  @override
  String get fullNameHint => 'Tu nombre y apellido';

  @override
  String get fullNameLabel => 'Nombre completo';

  @override
  String get getDirections => 'Obtener indicaciones';

  @override
  String groceryDealsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ofertas de supermercado',
      one: '$countString oferta de supermercado',
    );
    return '$_temp0';
  }

  @override
  String get heroSubtitle =>
      'Noticias locales, tráfico, ofertas, vivienda y actualizaciones de tus vecinos.';

  @override
  String get heroTitle => 'Tu comunidad de Calgary, toda en un solo lugar.';

  @override
  String get hideReplies => 'Ocultar respuestas';

  @override
  String get home => 'Inicio';

  @override
  String get homeRepairDiyHelp => 'Reparaciones del hogar / bricolaje';

  @override
  String get homeServiceFallback => 'Servicio a domicilio';

  @override
  String get housing => 'Vivienda';

  @override
  String get housingAndDevelopment => 'Vivienda y desarrollo';

  @override
  String get housingDataRefreshed => 'Datos de vivienda actualizados.';

  @override
  String get housingDataSourcesText =>
      'Las estadísticas de vivienda provienen de la investigación de vivienda de la Ciudad de Calgary y la información del mercado de CMHC. Las evaluaciones de propiedades y los detalles de desarrollo se proporcionan a través de herramientas oficiales de la Ciudad de Calgary.';

  @override
  String get housingInfoDescription =>
      'Explora las tendencias del mercado de alquiler, los cambios recientes en los precios de las viviendas, las evaluaciones oficiales de propiedades y la actividad de desarrollo próxima.';

  @override
  String get housingTypeApartment => 'Apartamento';

  @override
  String get housingTypeDetached => 'Casa unifamiliar';

  @override
  String get housingTypeRowTownhouse => 'Casa adosada';

  @override
  String get housingTypeSemiDetached => 'Casa semiadosada';

  @override
  String get jobAlreadyClaimed =>
      'Este trabajo ya fue reclamado por otro proveedor. La lista se actualizará ahora.';

  @override
  String get jobClaimedSuccess => 'Trabajo reclamado con éxito.';

  @override
  String get jobListings => 'Ofertas de empleo';

  @override
  String jobOpeningsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString vacantes',
      one: '$countString vacante',
    );
    return '$_temp0';
  }

  @override
  String jobStatusChanged(String status) {
    return 'Estado del trabajo cambiado a $status.';
  }

  @override
  String get jobs => 'Empleos';

  @override
  String get joinConversation => 'Unirse a la conversación';

  @override
  String get joinNeighbourCare => 'Unirse a NeighbourCare';

  @override
  String get lastNameLabel => 'Apellido';

  @override
  String lastRefreshedPrefix(String time) {
    return 'Última actualización: $time';
  }

  @override
  String get listLabel => 'Lista';

  @override
  String get live => 'EN VIVO';

  @override
  String get liveDealsSubtitle =>
      'Ofertas en vivo de tiendas locales participantes. Desliza hacia abajo para actualizar.';

  @override
  String get loading => 'Cargando...';

  @override
  String get loadingDeals => 'Cargando ofertas...';

  @override
  String get loadingDiscussions => 'Cargando discusiones...';

  @override
  String get loadingJobs => 'Cargando empleos...';

  @override
  String get loadingLiveUpdates => 'Cargando actualizaciones en vivo...';

  @override
  String get loadingPosts => 'Cargando publicaciones...';

  @override
  String get loadingTrafficUpdates => 'Cargando actualizaciones de tráfico...';

  @override
  String get localSavings => 'Ahorros locales';

  @override
  String localSavingsCouldNotUpdate(String error) {
    return 'Los ahorros locales no se pudieron actualizar:\n\n$error';
  }

  @override
  String get localUpdateLabel => 'Actualización local';

  @override
  String get locationHint => 'Vecindario o código postal';

  @override
  String get locationLabel => 'Ubicación';

  @override
  String get locationRadiusNote =>
      'La ubicación será opcional. Cuando esté habilitada, podrás elegir un radio de búsqueda de 2 km, 5 km, o 10 km por defecto.';

  @override
  String get locationUnavailable => 'Ubicación no disponible';

  @override
  String locationValue(String location) {
    return 'Ubicación: $location';
  }

  @override
  String get loginNameHint => 'Cómo te verán otros miembros';

  @override
  String get loginNameLabel => 'Nombre de usuario';

  @override
  String get loginNameMinLength =>
      'El nombre de usuario debe tener al menos 3 caracteres';

  @override
  String get loginNameTaken =>
      'Ese nombre de usuario ya está en uso. Elige otro.';

  @override
  String get mapLabel => 'Mapa';

  @override
  String get markAsReadTooltip => 'Marcar como leído';

  @override
  String get markCompletedButton => 'Marcar como completado';

  @override
  String get marketMetricsSubtitle =>
      'Métricas del mercado y permisos de desarrollo';

  @override
  String get marketPriceTrendsTitle => 'Tendencias de precios del mercado';

  @override
  String get marketplace => 'Mercado';

  @override
  String get marketplaceSubtitle => 'Comprar, vender y compartir';

  @override
  String get medianHomePricesTitle =>
      'Precios medios de vivienda por tipo de edificio';

  @override
  String get memberFallback => 'Miembro';

  @override
  String get myAssignedJobsTitle => 'Mis trabajos asignados';

  @override
  String get myBookings => 'Mis reservas';

  @override
  String get myProfileTitle => 'Mi perfil';

  @override
  String get neighbourCareCalgaryTitle => 'NeighbourCare Calgary';

  @override
  String get neighbourCareCommunity => 'Comunidad NeighbourCare';

  @override
  String get neighbourCareServicesTitle => 'Servicios NeighbourCare';

  @override
  String get neighbourhoodExampleHint => 'Ejemplo: Beltline';

  @override
  String get neighbourhoodHint => 'Por ejemplo: Beltline o Tuscany';

  @override
  String get neighbourhoodLabel => 'Vecindario';

  @override
  String get neighbourhoodOptionalLabel => 'Vecindario de Calgary (opcional)';

  @override
  String get newToNeighbourCareSignUp => '¿Nuevo en NeighbourCare? Regístrate';

  @override
  String get newestApplicationsNote =>
      'Las solicitudes más recientes de toda Calgary aparecerán aquí primero.';

  @override
  String get news => 'Noticias';

  @override
  String get noActiveDealsMatch =>
      'Ninguna oferta activa coincide con esta búsqueda o categoría.';

  @override
  String get noActiveIncidents => 'Sin incidentes activos';

  @override
  String get noActiveIncidentsListed => 'No hay incidentes activos reportados.';

  @override
  String get noBookingsYet =>
      'Aún no hay reservas. Envía tu primera solicitud de servicio.';

  @override
  String get noClaimedJobsYet => 'Aún no has reclamado ningún trabajo.';

  @override
  String get noCommunityPosts => 'Aún no hay publicaciones comunitarias.';

  @override
  String get noCurrentDeals => 'Sin ofertas actuales';

  @override
  String get noCurrentTrafficIncidents =>
      'No hay incidentes de tráfico activos listados.';

  @override
  String get noDealsAvailable => 'No hay ofertas disponibles en este momento.';

  @override
  String get noEmailAvailable => 'No hay correo disponible';

  @override
  String get noJobsFound => 'No se encontraron empleos.';

  @override
  String get noNotifications => 'Sin notificaciones.';

  @override
  String get noOpenRequests =>
      'No hay solicitudes abiertas disponibles en este momento.';

  @override
  String get noPostsShareFirst =>
      'Aún no hay publicaciones. Sé el primero en compartir.';

  @override
  String get noProviderApplicationsFound =>
      'No se encontraron solicitudes de proveedores.';

  @override
  String get noProviderProfileLinked =>
      'No hay un perfil de proveedor vinculado a esta cuenta. Crea una fila en providers usando el UUID de autenticación de este usuario.';

  @override
  String get noRecentDiscussions => 'No hay discusiones recientes.';

  @override
  String get noRecentPosts => 'No hay publicaciones recientes.';

  @override
  String get noRepliesYet => 'Aún no hay respuestas.';

  @override
  String get noVerifiedPriceReductions =>
      'No hay reducciones de precio verificadas activas en este momento.';

  @override
  String get notAvailable => 'No disponible';

  @override
  String get notProvided => 'No proporcionado';

  @override
  String notesValue(String notes) {
    return 'Notas: $notes';
  }

  @override
  String get notificationFallback => 'Notificación';

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get officialSourceLabel => 'Fuente oficial';

  @override
  String get openCalgaryDevelopmentMap =>
      'Abrir el mapa de desarrollo de Calgary';

  @override
  String get openCalgaryMyTax => 'Abrir myTax de la Ciudad de Calgary';

  @override
  String get openCityTrafficReport =>
      'Abrir el informe de tráfico de la ciudad';

  @override
  String get openRequestsTitle => 'Solicitudes abiertas';

  @override
  String get optionsTooltip => 'Opciones';

  @override
  String get otherLocalAssistance => 'Otra asistencia local';

  @override
  String get passwordHelperText => 'Usa al menos 8 caracteres.';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get passwordMinLength =>
      'La contraseña debe tener al menos 6 caracteres.';

  @override
  String get passwordMinLength8 =>
      'La contraseña debe tener al menos 8 caracteres.';

  @override
  String get passwordTooShort => 'Usa al menos 8 caracteres';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get permitFeedComingNext => 'Feed de permisos próximamente';

  @override
  String get phoneNumberLabel => 'Número de teléfono';

  @override
  String get postFallback => 'Publicación';

  @override
  String get posted => 'Publicado';

  @override
  String postedOn(String date) {
    return 'Publicado $date';
  }

  @override
  String get preferredTimeHint =>
      'Hoy de 5 a 7 p. m. o el sábado por la mañana';

  @override
  String get preferredTimeLabel => 'Hora preferida';

  @override
  String preferredTimeValue(String time) {
    return 'Hora preferida: $time';
  }

  @override
  String get price => 'Precio';

  @override
  String get pricesTermsMayChange =>
      'Los precios, el inventario, los requisitos de membresía y los términos de promoción pueden cambiar. Confirma directamente con la tienda antes de visitarla.';

  @override
  String get privacyReminderText =>
      'No incluyas direcciones, rostros, placas, números de teléfono ni otra información privada.';

  @override
  String get profileUpdatedSuccess => 'Perfil actualizado con éxito.';

  @override
  String get providerApplicationTitle => 'Solicitud de proveedor';

  @override
  String get providerApprovalTitle => 'Aprobación de proveedores';

  @override
  String get providerApprovedSuccess => 'Proveedor aprobado con éxito.';

  @override
  String providerIdFallback(String id) {
    return 'Proveedor $id';
  }

  @override
  String get providerLabelPrefix => 'Proveedor: ';

  @override
  String get providerNotVerified =>
      'Tu perfil de proveedor aún no está verificado. Pide a un administrador que establezca pvsc_verified en true.';

  @override
  String get providerPortal => 'Portal de proveedores';

  @override
  String get providerPortalTitle => 'Portal de proveedores';

  @override
  String get providerPortalTooltip => 'Portal de proveedores';

  @override
  String get providerVerificationRemoved =>
      'Se eliminó la verificación del proveedor.';

  @override
  String get publishReportButton => 'Publicar informe';

  @override
  String get publishingEllipsis => 'Publicando…';

  @override
  String get rankedByVerifiedSavings =>
      'Clasificado por porcentaje de ahorro verificado';

  @override
  String ratingValue(String rating) {
    return 'calificación: $rating';
  }

  @override
  String get refreshBookings => 'Actualizar reservas';

  @override
  String get refreshTooltip => 'Actualizar';

  @override
  String get refreshTraffic => 'Actualizar tráfico';

  @override
  String get regularPrice => 'Precio regular';

  @override
  String regularPriceValue(String price) {
    return 'Precio regular: $price';
  }

  @override
  String get rentalAvailabilityChangesNote =>
      'Disponibilidad de alquiler en Calgary y cambios recientes en los precios medios de vivienda.';

  @override
  String get rentalMarketVacancyRateTitle =>
      'Tasa de desocupación del mercado de alquiler';

  @override
  String get rentalVacancyRateLabel => 'Tasa de desocupación de alquiler';

  @override
  String get replyAction => 'Responder';

  @override
  String get reportLocalConditionsTitle => 'Informar condiciones locales';

  @override
  String get requestHelp => 'Solicitar ayuda';

  @override
  String requestedFromCommunityPost(String title) {
    return 'Solicitado desde la publicación comunitaria: $title\n\nDescribe la ayuda que necesitas:';
  }

  @override
  String get resendConfirmationEmail => 'Reenviar correo de confirmación';

  @override
  String get retry => 'Reintentar';

  @override
  String get save => 'Guardar';

  @override
  String get saveOnGroceriesTitle => 'Ahorra en víveres en Calgary';

  @override
  String get saveProfileButton => 'Guardar perfil';

  @override
  String get savingEllipsis => 'Guardando...';

  @override
  String get savings => 'Ahorros';

  @override
  String get search => 'Buscar';

  @override
  String get searchByProductOrStore => 'Buscar por producto o tienda';

  @override
  String get serviceCategoryHint =>
      'Plomería, calefacción, remoción de nieve...';

  @override
  String get serviceCategoryLabel => 'Categoría de servicio';

  @override
  String get serviceFallback => 'Servicio';

  @override
  String get shareAnUpdate => 'Compartir una actualización';

  @override
  String get shareFactualConditionsHint =>
      'Comparte condiciones actuales y objetivas.';

  @override
  String get shareLocalConditionsWarning =>
      'Comparte las condiciones locales actuales. Para una emergencia inmediata, llama al 911.';

  @override
  String get showList => 'Mostrar lista';

  @override
  String get showMap => 'Mostrar mapa';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get signInAsProvider => 'Inicia sesión como proveedor.';

  @override
  String get signInBeforeBooking =>
      'Inicia sesión antes de enviar una reserva.';

  @override
  String get signInBeforePosting => 'Inicia sesión antes de publicar.';

  @override
  String get signInBeforeUpdatingProfile =>
      'Inicia sesión antes de actualizar tu perfil.';

  @override
  String signInFailed(String error) {
    return 'Error al iniciar sesión: $error';
  }

  @override
  String get signInRequired => 'Se requiere iniciar sesión';

  @override
  String get signInSubtitle =>
      'Inicia sesión para reservar y gestionar servicios a domicilio.';

  @override
  String get signInToCreatePost =>
      'Inicia sesión como cliente o proveedor antes de crear una publicación comunitaria.';

  @override
  String get signInToReply => 'Inicia sesión para responder.';

  @override
  String get signInToRequestHelp =>
      'Inicia sesión para solicitar ayuda desde una publicación comunitaria.';

  @override
  String get signInToViewBookings => 'Inicia sesión para ver tus reservas.';

  @override
  String get signInToViewNotifications =>
      'Inicia sesión para ver tus notificaciones.';

  @override
  String get signInToViewProfile => 'Inicia sesión para ver tu perfil.';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get signOutTooltip => 'Cerrar sesión';

  @override
  String get signedInFallback => 'Sesión iniciada';

  @override
  String get signedInMember => 'Miembro conectado';

  @override
  String get sourceCalgaryOpenData =>
      'Fuente: datos abiertos de la Ciudad de Calgary.';

  @override
  String get startJobButton => 'Iniciar trabajo';

  @override
  String get statusAccepted => 'Aceptado';

  @override
  String get statusAssigned => 'Asignado';

  @override
  String get statusCancelled => 'Cancelado';

  @override
  String get statusCompleted => 'Completado';

  @override
  String get statusDeclined => 'Rechazado';

  @override
  String get statusInProgress => 'En progreso';

  @override
  String get statusPending => 'Pendiente';

  @override
  String statusValue(String status) {
    return 'Estado: $status';
  }

  @override
  String get store => 'Tienda';

  @override
  String get submit => 'Enviar';

  @override
  String get submitApplicationButton => 'Enviar solicitud';

  @override
  String get submitApplicationSubtitle =>
      'Envía tu solicitud para aprobación administrativa.';

  @override
  String get submitBookingButton => 'Enviar reserva';

  @override
  String get submittingEllipsis => 'Enviando...';

  @override
  String get suspendButton => 'Suspender';

  @override
  String get textSizeLabel => 'Tamaño del texto';

  @override
  String get traffic => 'Tráfico';

  @override
  String get trafficDetailsWarning =>
      'Los detalles del tráfico pueden cambiar rápidamente. Consulta el informe de la Ciudad de Calgary para conocer cierres, desvíos, cámaras y actualizaciones de ruta antes de viajar.';

  @override
  String get trafficIncidentFallback => 'Incidente de tráfico';

  @override
  String get trafficIncidentReported => 'Incidente de tráfico reportado.';

  @override
  String get trafficRoadConditions => 'Condiciones de las vías';

  @override
  String get trafficSourceNote =>
      'Fuente de tráfico: datos abiertos de la Ciudad de Calgary. Confirma las condiciones antes de viajar.';

  @override
  String get trafficUpdatesUnavailable =>
      'Las actualizaciones de tráfico no están disponibles.';

  @override
  String get tryAgainButton => 'Intentar de nuevo';

  @override
  String get unassigned => 'Sin asignar';

  @override
  String get updateTimeUnavailable => 'Hora de actualización no disponible';

  @override
  String updatedPrefix(String time) {
    return 'Actualizado: $time';
  }

  @override
  String get vacancyRate2025Note =>
      'Tasa de desocupación del mercado de Calgary en 2025, un aumento desde 4.6% en 2024.';

  @override
  String get vacancyRateExplainer =>
      'Una tasa de desocupación más alta puede significar más opciones de alquiler, pero la disponibilidad y el alquiler todavía varían según el vecindario y el tipo de vivienda.';

  @override
  String get vacancyRateIncreaseNote =>
      'La tasa de desocupación del mercado aumentó de 1.4% en 2023 a 5.1% en 2025.';

  @override
  String get verifiedLabel => 'Verificado';

  @override
  String get viewAllGroceryDeals => 'Ver todas las ofertas de supermercado';

  @override
  String get viewCityHousingTrends => 'Ver tendencias de vivienda de la ciudad';

  @override
  String get viewDetails => 'Ver detalles';

  @override
  String get viewLatestStatistics => 'Ver las últimas estadísticas';

  @override
  String get viewModeLabel => 'Modo de vista';

  @override
  String get weather => 'Clima';

  @override
  String get weatherRelatedHomeHelp =>
      'Ayuda doméstica relacionada con el clima';

  @override
  String get weatherUpdate => 'Actualización meteorológica';

  @override
  String get weatherUpdatePublished => 'Actualización meteorológica publicada.';

  @override
  String get weatherUpdatesTitle => 'Actualizaciones meteorológicas';

  @override
  String get welcomeToNeighbourCare => 'Bienvenido a NeighbourCare';

  @override
  String get whatIsHappeningLabel => '¿Qué está pasando?';

  @override
  String get writeAReplyHint => 'Escribe una respuesta...';

  @override
  String get yourAccountTitle => 'Tu cuenta';

  @override
  String get yoyChangeQ22026 => 'Cambio interanual, segundo trimestre de 2026';

  @override
  String get updatingWeather => 'Actualizando clima...';

  @override
  String weatherUpdateUnavailable(String error) {
    return 'Actualización del clima no disponible: $error';
  }

  @override
  String get weatherAlertIssued => 'Alerta meteorológica emitida';

  @override
  String get calgaryIntlAirport => 'Aeropuerto Internacional de Calgary';

  @override
  String weatherHumidity(String humidity) {
    return 'Humedad: $humidity%';
  }

  @override
  String weatherWind(String wind) {
    return 'Viento: $wind';
  }

  @override
  String weatherVisPres(String visibility, String pressure) {
    return 'Vis: $visibility • Pres: $pressure';
  }

  @override
  String get hideForecast => 'Ocultar pronóstico';

  @override
  String get showFullForecast => 'Mostrar pronóstico de 24 horas y varios días';

  @override
  String get hourlyForecastTitle => 'Pronóstico de 24 horas';

  @override
  String get multiDayOutlookTitle => 'Pronóstico de varios días';

  @override
  String weatherHigh(String temp) {
    return 'Máx $temp';
  }

  @override
  String weatherLow(String temp) {
    return 'Mín $temp';
  }
}
