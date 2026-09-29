// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get aboutNeighbourCare => 'NeighbourCare 让卡尔加里的邻居更容易获得实用的本地信息与社区资源。';

  @override
  String get account => '账户';

  @override
  String get accountCreatedCheckEmail => '账户已创建。请查看您的电子邮件以确认账户，然后登录。';

  @override
  String get accountCreatedCheckEmailReturn => '账户已创建。请查看您的电子邮件以确认账户，然后返回此处登录。';

  @override
  String get accountCreatedSignedIn => '账户已创建并已登录。';

  @override
  String activeIncidentsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString 起进行中的事件',
      one: '$countString 起进行中的事件',
    );
    return '$_temp0';
  }

  @override
  String get adminPortalTitle => '管理员入口';

  @override
  String get adminPortalTooltip => '管理员入口';

  @override
  String get alertTypeLabel => '提醒类型';

  @override
  String get all => '全部';

  @override
  String amountValue(String amount) {
    return '金额：$amount';
  }

  @override
  String get appName => 'NeighbourCare';

  @override
  String get applicationSubmittedPendingApproval =>
      '申请已提交。管理员必须先批准您的服务提供者资料，您才能接取工作。';

  @override
  String get applyNow => '立即申请';

  @override
  String get applyToBecomeProvider => '申请成为服务提供者';

  @override
  String get approveButton => '批准';

  @override
  String get assessedValueExplainer => '评估价值用于房产评估与税务，并非当前市场售价的估算值。';

  @override
  String get assessedValueLookupTitle => '市政房产评估价值查询';

  @override
  String get assignButton => '指派';

  @override
  String get backToSignIn => '返回登录';

  @override
  String get becomeAProviderTitle => '成为服务提供者';

  @override
  String get bestDealsThisWeek => '本周最佳优惠';

  @override
  String get bookAHomeService => '预订居家服务';

  @override
  String get bookServices => '预订服务';

  @override
  String get bookingAssignedToProvider => '预订已指派给服务提供者。';

  @override
  String bookingStartedFromPost(String title) {
    return '此预订来自社区帖子：$title';
  }

  @override
  String bookingStatusUpdated(String status) {
    return '预订状态已更新为 $status。';
  }

  @override
  String bookingSubmittedSuccess(String id) {
    return '预订已成功提交。\n预订编号：$id';
  }

  @override
  String get bookingsTitle => '预订';

  @override
  String get browseGroceryDeals => '浏览杂货优惠';

  @override
  String get browseOpenings => '浏览职位空缺';

  @override
  String get calgary => '卡加利';

  @override
  String get calgaryAlberta => '卡尔加里，艾伯塔省';

  @override
  String get calgaryCommunityHub => '卡加利社区资讯平台';

  @override
  String get calgaryCommunityHubTraffic => '卡尔加里社区中心 - 交通';

  @override
  String get calgaryHousingInfoTitle => '卡尔加里住房信息';

  @override
  String get calgaryHousingPortalTitle => '卡尔加里住房门户网站';

  @override
  String get calgaryHousingSnapshotTitle => '卡尔加里住房概况';

  @override
  String get calgaryMarketVacancyRateLabel => '卡尔加里市场租赁空置率';

  @override
  String get cancel => '取消';

  @override
  String get categoryBeef => '牛肉';

  @override
  String get categoryBreakfast => '早餐';

  @override
  String get categoryChicken => '鸡肉';

  @override
  String get categoryDairy => '乳制品';

  @override
  String get categoryFish => '鱼类';

  @override
  String get categoryOther => '其他';

  @override
  String get categoryPork => '猪肉';

  @override
  String categoryPostsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString 条帖子',
      one: '$countString 条帖子',
    );
    return '$_temp0';
  }

  @override
  String get chooseTopicToPost => '选择发布主题';

  @override
  String get citywideMedianPriceNote => '这是全市按建筑类型计算的中位售价变化，并非个别房产的估价。';

  @override
  String get claimJobButton => '接取工作';

  @override
  String get claimUnassignedSubtitle => '接取一项尚未指派的请求，最先成功接取者得标。';

  @override
  String get claimingEllipsis => '接取中...';

  @override
  String get clientSignIn => '客户登录';

  @override
  String get community => '社区';

  @override
  String get communityFeeds => '社区动态';

  @override
  String get communityForumTooltip => '社区论坛';

  @override
  String get communityPost => '社区贴文';

  @override
  String get completeButton => '完成';

  @override
  String get confirmPasswordLabel => '确认密码';

  @override
  String get confirmationEmailResent => '已发送新的确认邮件，请只使用最新的链接，并仅打开一次。';

  @override
  String couldNotAssignProvider(String error) {
    return '无法指派服务提供者：$error';
  }

  @override
  String couldNotClaimJob(String error) {
    return '无法接取工作：$error';
  }

  @override
  String couldNotCreateAccount(String error) {
    return '无法创建账户：$error';
  }

  @override
  String couldNotLaunchUrl(String url) {
    return '无法打开 $url';
  }

  @override
  String couldNotLoadAdminData(String error) {
    return '无法加载管理员数据：$error';
  }

  @override
  String couldNotLoadBookings(String error) {
    return '无法加载预订：$error';
  }

  @override
  String get couldNotLoadJobs => '无法加载职位信息。';

  @override
  String couldNotLoadNotifications(String error) {
    return '无法加载通知：$error';
  }

  @override
  String get couldNotLoadPosts => '无法加载贴文';

  @override
  String couldNotLoadPostsError(String error) {
    return '无法加载帖子：$error';
  }

  @override
  String couldNotLoadProfile(String error) {
    return '无法加载个人资料：$error';
  }

  @override
  String couldNotLoadProviderPortal(String error) {
    return '无法加载服务提供者入口：$error';
  }

  @override
  String couldNotLoadReplies(String error) {
    return '无法加载回复：$error';
  }

  @override
  String couldNotMarkAsRead(String error) {
    return '无法标记为已读：$error';
  }

  @override
  String get couldNotOpenDirections => '无法打开路线指引。';

  @override
  String get couldNotOpenTrafficReport => '无法打开卡尔加里官方交通报告。';

  @override
  String couldNotPublish(String error) {
    return '无法发布：$error';
  }

  @override
  String couldNotResendConfirmation(String error) {
    return '无法重新发送确认信：$error';
  }

  @override
  String couldNotSaveLoginName(String error) {
    return '无法保存登录名称：$error';
  }

  @override
  String couldNotSendReply(String error) {
    return '无法发送回复：$error';
  }

  @override
  String couldNotSignOut(String error) {
    return '无法登出：$error';
  }

  @override
  String couldNotSubmitApplication(String error) {
    return '无法提交服务提供者申请：$error';
  }

  @override
  String couldNotSubmitBooking(String error) {
    return '无法提交预订：$error';
  }

  @override
  String couldNotUpdateBookingStatus(String error) {
    return '无法更新预订状态：$error';
  }

  @override
  String couldNotUpdateJobStatus(String error) {
    return '无法更新工作状态：$error';
  }

  @override
  String couldNotUpdateProfile(String error) {
    return '无法更新个人资料：$error';
  }

  @override
  String couldNotUpdateProviderVerification(String error) {
    return '无法更新服务提供者验证：$error';
  }

  @override
  String couldNotVerifyRole(String error) {
    return '无法验证账户角色：$error';
  }

  @override
  String get createAccountTitle => '创建账户';

  @override
  String get createClientAccountSubtitle => '创建客户账户以预订值得信赖的本地服务。';

  @override
  String get createPost => '发布贴文';

  @override
  String get creatingAccountEllipsis => '正在创建账户...';

  @override
  String currentIncidentsShown(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '当前显示 $countString 起交通事件。',
      one: '当前显示 $countString 起交通事件。',
    );
    return '$_temp0';
  }

  @override
  String get dataSourcesLabel => '数据来源';

  @override
  String get deals => '优惠';

  @override
  String get delete => '删除';

  @override
  String get describeIssueHint => '告诉我们需要维修或完成的内容。';

  @override
  String get describeIssueLabel => '描述问题';

  @override
  String get describeIssueValidator => '描述问题';

  @override
  String get describeServiceSubtitle => '描述您在卡尔加里需要的服务。';

  @override
  String get developmentNearYouTitle => '您附近的开发项目';

  @override
  String get dining => '餐饮';

  @override
  String get diningPost => '餐饮贴文';

  @override
  String get diningPostsTitle => '餐饮帖子';

  @override
  String get discussionFallback => '讨论';

  @override
  String discussionsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString 条讨论',
      one: '$countString 条讨论',
    );
    return '$_temp0';
  }

  @override
  String get displayNameLabel => '显示名称';

  @override
  String get diyHome => '居家修缮';

  @override
  String get diyHomePost => '居家修缮贴文';

  @override
  String get diyHomeTitle => '居家修缮';

  @override
  String get edit => '编辑';

  @override
  String get emailAddressLabel => '电子邮件地址';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get emailLabel => '电子邮件';

  @override
  String get enterAtLeast3Characters => '请输入至少 3 个字符。';

  @override
  String get enterDisplayName => '请输入要在应用中显示的名称。';

  @override
  String get enterEmailAddress => '请输入您的电子邮件地址';

  @override
  String get enterEmailAndPassword => '请输入电子邮件和密码。';

  @override
  String get enterEmailFirstResend => '请先输入电子邮件地址，再重新发送确认信。';

  @override
  String get enterFirstName => '请输入您的名字。';

  @override
  String get enterFullName => '请输入您的全名';

  @override
  String get enterLastName => '请输入您的姓氏。';

  @override
  String get enterLocation => '请输入您的位置';

  @override
  String get enterLoginName => '请输入登录名称';

  @override
  String get enterNeighbourhood => '请输入社区名称。';

  @override
  String get enterPhoneNumber => '请输入电话号码';

  @override
  String get enterServiceCategory => '请输入服务类别';

  @override
  String get enterSignupDetails => '请输入您的全名、电话号码、电子邮件和密码。';

  @override
  String get enterValidEmailAddress => '请输入有效的电子邮件地址';

  @override
  String get enterYourNameHint => '请输入您的名称';

  @override
  String estimatedAmountValue(String amount) {
    return '预估金额：$amount';
  }

  @override
  String get expiryDate => '有效日期';

  @override
  String get exploreNeighbourCare => '探索 NeighbourCare';

  @override
  String get exploreSubtitle => '实用的卡尔加里信息、本地连接与日常资源，一站式获取。';

  @override
  String get filter => '筛选';

  @override
  String get filterAll => '全部';

  @override
  String get filterLabelPrefix => '筛选：';

  @override
  String get findAssessedValueNote => '查询卡尔加里特定房产的市政评估价值。';

  @override
  String get firstNameLabel => '名字';

  @override
  String get fontSizeLarge => '大';

  @override
  String get fontSizeNormal => '正常';

  @override
  String get fontSizeSmall => '小';

  @override
  String get forceAcceptButton => '强制接受';

  @override
  String get forceDeclineButton => '强制拒绝';

  @override
  String get fullNameHint => '您的名字与姓氏';

  @override
  String get fullNameLabel => '全名';

  @override
  String get getDirections => '获取路线';

  @override
  String groceryDealsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString 项杂货优惠',
      one: '$countString 项杂货优惠',
    );
    return '$_temp0';
  }

  @override
  String get heroSubtitle => '本地新闻、交通、省钱攻略、住房与邻里动态。';

  @override
  String get heroTitle => '您的卡加利社区，尽在一处。';

  @override
  String get hideReplies => '隐藏回复';

  @override
  String get home => '首页';

  @override
  String get homeRepairDiyHelp => '居家维修 / DIY 帮助';

  @override
  String get homeServiceFallback => '居家服务';

  @override
  String get housing => '住房';

  @override
  String get housingAndDevelopment => '房屋与发展';

  @override
  String get housingDataRefreshed => '住房数据已更新。';

  @override
  String get housingDataSourcesText =>
      '住房统计数据来自卡尔加里市住房研究与 CMHC 市场信息。房产评估与开发详情则通过卡尔加里市官方工具提供。';

  @override
  String get housingInfoDescription => '探索租赁市场趋势、近期房价变化、官方房产评估，以及即将进行的开发活动。';

  @override
  String get housingTypeApartment => '公寓';

  @override
  String get housingTypeDetached => '独立屋';

  @override
  String get housingTypeRowTownhouse => '排屋';

  @override
  String get housingTypeSemiDetached => '半独立屋';

  @override
  String get jobAlreadyClaimed => '此工作已被其他服务提供者接取，列表现在将刷新。';

  @override
  String get jobClaimedSuccess => '已成功接取工作。';

  @override
  String get jobListings => '职位空缺';

  @override
  String jobOpeningsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString 个职位空缺',
      one: '$countString 个职位空缺',
    );
    return '$_temp0';
  }

  @override
  String jobStatusChanged(String status) {
    return '工作状态已变更为 $status。';
  }

  @override
  String get jobs => '职位';

  @override
  String get joinConversation => '加入讨论';

  @override
  String get joinNeighbourCare => '加入 NeighbourCare';

  @override
  String get lastNameLabel => '姓氏';

  @override
  String lastRefreshedPrefix(String time) {
    return '上次刷新：$time';
  }

  @override
  String get listLabel => '列表';

  @override
  String get live => '实时';

  @override
  String get liveDealsSubtitle => '来自参与本地商店的实时优惠，下拉即可刷新。';

  @override
  String get loading => '加载中...';

  @override
  String get loadingDeals => '正在加载优惠...';

  @override
  String get loadingDiscussions => '正在加载讨论...';

  @override
  String get loadingJobs => '正在加载职位信息...';

  @override
  String get loadingLiveUpdates => '正在加载实时更新...';

  @override
  String get loadingPosts => '正在加载帖子...';

  @override
  String get loadingTrafficUpdates => '正在加载交通更新...';

  @override
  String get localSavings => '本地优惠';

  @override
  String localSavingsCouldNotUpdate(String error) {
    return '省钱信息无法更新：\n\n$error';
  }

  @override
  String get localUpdateLabel => '本地动态';

  @override
  String get locationHint => '社区或邮政编码';

  @override
  String get locationLabel => '位置';

  @override
  String get locationRadiusNote =>
      '位置功能将为可选。启用后，您可以选择 2 公里、5 公里，或默认 10 公里的搜索范围。';

  @override
  String get locationUnavailable => '位置不可用';

  @override
  String locationValue(String location) {
    return '位置：$location';
  }

  @override
  String get loginNameHint => '其他成员将看到的显示方式';

  @override
  String get loginNameLabel => '登录名称';

  @override
  String get loginNameMinLength => '登录名称必须至少包含 3 个字符';

  @override
  String get loginNameTaken => '该登录名称已被使用，请选择其他名称。';

  @override
  String get mapLabel => '地图';

  @override
  String get markAsReadTooltip => '标记为已读';

  @override
  String get markCompletedButton => '标记为已完成';

  @override
  String get marketMetricsSubtitle => '市场指标与开发许可';

  @override
  String get marketPriceTrendsTitle => '市场价格趋势';

  @override
  String get marketplace => '跳蚤市场';

  @override
  String get marketplaceSubtitle => '买卖与分享';

  @override
  String get medianHomePricesTitle => '各建筑类型中位房价';

  @override
  String get memberFallback => '会员';

  @override
  String get myAssignedJobsTitle => '我接取的工作';

  @override
  String get myBookings => '我的预订';

  @override
  String get myProfileTitle => '我的个人资料';

  @override
  String get neighbourCareCalgaryTitle => 'NeighbourCare 卡尔加里';

  @override
  String get neighbourCareCommunity => 'NeighbourCare 社区';

  @override
  String get neighbourCareServicesTitle => 'NeighbourCare 服务';

  @override
  String get neighbourhoodExampleHint => '例如：Beltline';

  @override
  String get neighbourhoodHint => '例如：Beltline 或 Tuscany';

  @override
  String get neighbourhoodLabel => '社区';

  @override
  String get neighbourhoodOptionalLabel => '卡尔加里社区（选填）';

  @override
  String get newToNeighbourCareSignUp => '首次使用 NeighbourCare？立即注册';

  @override
  String get newestApplicationsNote => '卡尔加里全市最新的申请将优先显示在此处。';

  @override
  String get news => '新闻';

  @override
  String get noActiveDealsMatch => '没有符合此搜索或类别的优惠。';

  @override
  String get noActiveIncidents => '没有进行中的事件';

  @override
  String get noActiveIncidentsListed => '目前没有列出进行中的事件。';

  @override
  String get noBookingsYet => '暂无预订记录，请提交您的第一个服务请求。';

  @override
  String get noClaimedJobsYet => '您尚未接取任何工作。';

  @override
  String get noCommunityPosts => '暂无社区贴文。';

  @override
  String get noCurrentDeals => '目前没有优惠';

  @override
  String get noCurrentTrafficIncidents => '目前没有列出进行中的交通事件。';

  @override
  String get noDealsAvailable => '目前没有可用的优惠。';

  @override
  String get noEmailAvailable => '没有可用的电子邮件';

  @override
  String get noJobsFound => '未找到职位信息。';

  @override
  String get noNotifications => '没有通知。';

  @override
  String get noOpenRequests => '目前没有可接取的开放请求。';

  @override
  String get noPostsShareFirst => '暂无帖子，成为第一个分享的人吧。';

  @override
  String get noProviderApplicationsFound => '未找到服务提供者申请。';

  @override
  String get noProviderProfileLinked =>
      '此账户尚未关联任何服务提供者资料。请使用该用户的 Auth UUID 创建一条 providers 记录。';

  @override
  String get noRecentDiscussions => '没有最新讨论。';

  @override
  String get noRecentPosts => '没有最新帖子。';

  @override
  String get noRepliesYet => '暂无回复。';

  @override
  String get noVerifiedPriceReductions => '目前没有已验证的降价优惠。';

  @override
  String get notAvailable => '不可用';

  @override
  String get notProvided => '未提供';

  @override
  String notesValue(String notes) {
    return '备注：$notes';
  }

  @override
  String get notificationFallback => '通知';

  @override
  String get notificationsTitle => '通知';

  @override
  String get officialSourceLabel => '官方来源';

  @override
  String get openCalgaryDevelopmentMap => '打开卡尔加里开发地图';

  @override
  String get openCalgaryMyTax => '打开卡尔加里市 myTax';

  @override
  String get openCityTrafficReport => '打开市政交通报告';

  @override
  String get openRequestsTitle => '开放请求';

  @override
  String get optionsTooltip => '选项';

  @override
  String get otherLocalAssistance => '其他本地协助';

  @override
  String get passwordHelperText => '请使用至少 8 个字符。';

  @override
  String get passwordLabel => '密码';

  @override
  String get passwordMinLength => '密码必须包含至少 6 个字符。';

  @override
  String get passwordMinLength8 => '密码必须至少包含 8 个字符。';

  @override
  String get passwordTooShort => '请使用至少 8 个字符';

  @override
  String get passwordsDoNotMatch => '两次输入的密码不一致';

  @override
  String get permitFeedComingNext => '许可证动态即将推出';

  @override
  String get phoneNumberLabel => '电话号码';

  @override
  String get postFallback => '帖子';

  @override
  String get posted => '已发布';

  @override
  String postedOn(String date) {
    return '发布于 $date';
  }

  @override
  String get preferredTimeHint => '今天下午 5–7 点或周六上午';

  @override
  String get preferredTimeLabel => '偏好时间';

  @override
  String preferredTimeValue(String time) {
    return '偏好时间：$time';
  }

  @override
  String get price => '价格';

  @override
  String get pricesTermsMayChange => '价格、库存、会员资格要求及促销条款可能会变动，前往之前请直接向商店确认。';

  @override
  String get privacyReminderText => '请勿包含住址、面部、车牌、电话号码或其他私人信息。';

  @override
  String get profileUpdatedSuccess => '个人资料已成功更新。';

  @override
  String get providerApplicationTitle => '服务提供者申请';

  @override
  String get providerApprovalTitle => '服务提供者审核';

  @override
  String get providerApprovedSuccess => '服务提供者已成功批准。';

  @override
  String providerIdFallback(String id) {
    return '服务提供者 $id';
  }

  @override
  String get providerLabelPrefix => '服务提供者：';

  @override
  String get providerNotVerified =>
      '您的服务提供者资料尚未通过验证，请让管理员将 pvsc_verified 设置为 true。';

  @override
  String get providerPortal => '服务提供者入口';

  @override
  String get providerPortalTitle => '服务提供者入口';

  @override
  String get providerPortalTooltip => '服务提供者入口';

  @override
  String get providerVerificationRemoved => '已移除服务提供者验证。';

  @override
  String get publishReportButton => '发布报告';

  @override
  String get publishingEllipsis => '发布中…';

  @override
  String get rankedByVerifiedSavings => '按已验证省钱百分比排序';

  @override
  String ratingValue(String rating) {
    return '评分：$rating';
  }

  @override
  String get refreshBookings => '刷新预订';

  @override
  String get refreshTooltip => '刷新';

  @override
  String get refreshTraffic => '刷新交通';

  @override
  String get regularPrice => '原价';

  @override
  String regularPriceValue(String price) {
    return '原价：$price';
  }

  @override
  String get rentalAvailabilityChangesNote => '卡尔加里租赁供应状况与近期房价中位数变化。';

  @override
  String get rentalMarketVacancyRateTitle => '租赁市场空置率';

  @override
  String get rentalVacancyRateLabel => '租赁空置率';

  @override
  String get replyAction => '回复';

  @override
  String get reportLocalConditionsTitle => '报告本地状况';

  @override
  String get requestHelp => '请求协助';

  @override
  String requestedFromCommunityPost(String title) {
    return '来自社区帖子的请求：$title\n\n请描述所需的帮助：';
  }

  @override
  String get resendConfirmationEmail => '重新发送确认信';

  @override
  String get retry => '重试';

  @override
  String get save => '保存';

  @override
  String get saveOnGroceriesTitle => '在卡尔加里省钱购买杂货';

  @override
  String get saveProfileButton => '保存个人资料';

  @override
  String get savingEllipsis => '保存中...';

  @override
  String get savings => '省钱';

  @override
  String get search => '搜索';

  @override
  String get searchByProductOrStore => '按商品或商店搜索';

  @override
  String get serviceCategoryHint => '水管、暖炉、除雪...';

  @override
  String get serviceCategoryLabel => '服务类别';

  @override
  String get serviceFallback => '服务';

  @override
  String get shareAnUpdate => '分享动态';

  @override
  String get shareFactualConditionsHint => '请分享真实、及时的状况。';

  @override
  String get shareLocalConditionsWarning => '分享当前的本地状况。如遇紧急情况，请立即拨打 911。';

  @override
  String get showList => '显示列表';

  @override
  String get showMap => '显示地图';

  @override
  String get signIn => '登录';

  @override
  String get signInAsProvider => '请以服务提供者身份登录。';

  @override
  String get signInBeforeBooking => '请先登录才能提交预订。';

  @override
  String get signInBeforePosting => '请先登录才能发帖。';

  @override
  String get signInBeforeUpdatingProfile => '请先登录才能更新您的个人资料。';

  @override
  String signInFailed(String error) {
    return '登录失败：$error';
  }

  @override
  String get signInRequired => '需要登录';

  @override
  String get signInSubtitle => '登录以预订并管理居家服务。';

  @override
  String get signInToCreatePost => '请先以客户或服务提供者身份登录，再发布社区贴文。';

  @override
  String get signInToReply => '请登录以回复。';

  @override
  String get signInToRequestHelp => '请登录以对社区贴文请求协助。';

  @override
  String get signInToViewBookings => '请登录以查看您的预订。';

  @override
  String get signInToViewNotifications => '请登录以查看您的通知。';

  @override
  String get signInToViewProfile => '请登录以查看您的个人资料。';

  @override
  String get signOut => '退出登录';

  @override
  String get signOutTooltip => '登出';

  @override
  String get signedInFallback => '已登录';

  @override
  String get signedInMember => '已登录成员';

  @override
  String get sourceCalgaryOpenData => '来源：卡尔加里市开放数据。';

  @override
  String get startJobButton => '开始工作';

  @override
  String get statusAccepted => '已接受';

  @override
  String get statusAssigned => '已指派';

  @override
  String get statusCancelled => '已取消';

  @override
  String get statusCompleted => '已完成';

  @override
  String get statusDeclined => '已拒绝';

  @override
  String get statusInProgress => '进行中';

  @override
  String get statusPending => '待处理';

  @override
  String statusValue(String status) {
    return '状态：$status';
  }

  @override
  String get store => '商店';

  @override
  String get submit => '提交';

  @override
  String get submitApplicationButton => '提交申请';

  @override
  String get submitApplicationSubtitle => '提交您的申请以供管理员审核。';

  @override
  String get submitBookingButton => '提交预订';

  @override
  String get submittingEllipsis => '提交中...';

  @override
  String get suspendButton => '停用';

  @override
  String get textSizeLabel => '文字大小';

  @override
  String get traffic => '交通';

  @override
  String get trafficDetailsWarning =>
      '交通状况可能瞬息万变，出发前请查阅卡尔加里市报告以了解封闭路段、绕道、监控摄像头与路况更新。';

  @override
  String get trafficIncidentFallback => '交通事件';

  @override
  String get trafficIncidentReported => '已报告交通事件。';

  @override
  String get trafficRoadConditions => '道路状况';

  @override
  String get trafficSourceNote => '交通数据来源：卡尔加里市开放数据。出发前请再次确认路况。';

  @override
  String get trafficUpdatesUnavailable => '目前无法获取交通更新。';

  @override
  String get tryAgainButton => '重试';

  @override
  String get unassigned => '未指派';

  @override
  String get updateTimeUnavailable => '更新时间不可用';

  @override
  String updatedPrefix(String time) {
    return '更新时间：$time';
  }

  @override
  String get vacancyRate2025Note => '卡尔加里 2025 年市场空置率，较 2024 年的 4.6% 上升。';

  @override
  String get vacancyRateExplainer => '较高的空置率可能意味着更多租房选择，但实际供应与租金仍因社区和住房类型而异。';

  @override
  String get vacancyRateIncreaseNote =>
      '市场空置率已从 2023 年的 1.4% 上升至 2025 年的 5.1%。';

  @override
  String get verifiedLabel => '已验证';

  @override
  String get viewAllGroceryDeals => '查看所有杂货优惠';

  @override
  String get viewCityHousingTrends => '查看市政住房趋势';

  @override
  String get viewDetails => '查看详情';

  @override
  String get viewLatestStatistics => '查看最新统计数据';

  @override
  String get viewModeLabel => '显示模式';

  @override
  String get weather => '天气';

  @override
  String get weatherRelatedHomeHelp => '天气相关居家帮助';

  @override
  String get weatherUpdate => '天气动态';

  @override
  String get weatherUpdatePublished => '天气动态已发布。';

  @override
  String get weatherUpdatesTitle => '天气动态';

  @override
  String get welcomeToNeighbourCare => '欢迎使用 NeighbourCare';

  @override
  String get whatIsHappeningLabel => '发生了什么事？';

  @override
  String get writeAReplyHint => '输入回复...';

  @override
  String get yourAccountTitle => '您的账户';

  @override
  String get yoyChangeQ22026 => '同比变化，2026 年第二季度';

  @override
  String get updatingWeather => '正在更新天气...';

  @override
  String weatherUpdateUnavailable(String error) {
    return '无法更新天气：$error';
  }

  @override
  String get weatherAlertIssued => '已发布天气警报';

  @override
  String get calgaryIntlAirport => '卡尔加里国际机场';

  @override
  String weatherHumidity(String humidity) {
    return '湿度：$humidity%';
  }

  @override
  String weatherWind(String wind) {
    return '风向风速：$wind';
  }

  @override
  String weatherVisPres(String visibility, String pressure) {
    return '能见度：$visibility • 气压：$pressure';
  }

  @override
  String get hideForecast => '隐藏预报';

  @override
  String get showFullForecast => '显示 24 小时及多日预报';

  @override
  String get hourlyForecastTitle => '24 小时预报';

  @override
  String get multiDayOutlookTitle => '多日展望';

  @override
  String weatherHigh(String temp) {
    return '最高 $temp';
  }

  @override
  String weatherLow(String temp) {
    return '最低 $temp';
  }
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get aboutNeighbourCare => 'NeighbourCare 讓卡加利的鄰居更容易獲得實用的本地資訊與社區資源。';

  @override
  String get account => '帳戶';

  @override
  String get accountCreatedCheckEmail => '帳戶已建立。請查看您的電子郵件以確認帳戶，然後登入。';

  @override
  String get accountCreatedCheckEmailReturn => '帳戶已建立。請查看您的電子郵件以確認帳戶，然後回到此處登入。';

  @override
  String get accountCreatedSignedIn => '帳戶已建立並已登入。';

  @override
  String activeIncidentsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString 起進行中的事件',
      one: '$countString 起進行中的事件',
    );
    return '$_temp0';
  }

  @override
  String get adminPortalTitle => '管理員入口';

  @override
  String get adminPortalTooltip => '管理員入口';

  @override
  String get alertTypeLabel => '提醒類型';

  @override
  String get all => '全部';

  @override
  String amountValue(String amount) {
    return '金額：$amount';
  }

  @override
  String get appName => 'NeighbourCare';

  @override
  String get applicationSubmittedPendingApproval =>
      '申請已送出。管理員必須先核准您的服務提供者資料，才能接取工作。';

  @override
  String get applyNow => '立即申請';

  @override
  String get applyToBecomeProvider => '申請成為服務提供者';

  @override
  String get approveButton => '核准';

  @override
  String get assessedValueExplainer => '評估價值用於財產評估與稅務，並非目前市場售價的估算值。';

  @override
  String get assessedValueLookupTitle => '市府房產評估價值查詢';

  @override
  String get assignButton => '指派';

  @override
  String get backToSignIn => '返回登入';

  @override
  String get becomeAProviderTitle => '成為服務提供者';

  @override
  String get bestDealsThisWeek => '本週最佳優惠';

  @override
  String get bookAHomeService => '預訂居家服務';

  @override
  String get bookServices => '預訂服務';

  @override
  String get bookingAssignedToProvider => '預訂已指派給服務提供者。';

  @override
  String bookingStartedFromPost(String title) {
    return '此預訂來自社區貼文：$title';
  }

  @override
  String bookingStatusUpdated(String status) {
    return '預訂狀態已更新為 $status。';
  }

  @override
  String bookingSubmittedSuccess(String id) {
    return '預訂已成功送出。\n預訂編號：$id';
  }

  @override
  String get bookingsTitle => '預訂';

  @override
  String get browseGroceryDeals => '瀏覽雜貨優惠';

  @override
  String get browseOpenings => '瀏覽職缺';

  @override
  String get calgary => '卡加利';

  @override
  String get calgaryAlberta => '卡加利，亞伯達省';

  @override
  String get calgaryCommunityHub => '卡加利社區資訊平台';

  @override
  String get calgaryCommunityHubTraffic => '卡加利社區中心 - 交通';

  @override
  String get calgaryHousingInfoTitle => '卡加利房屋資訊';

  @override
  String get calgaryHousingPortalTitle => '卡加利房屋入口網站';

  @override
  String get calgaryHousingSnapshotTitle => '卡加利房屋概況';

  @override
  String get calgaryMarketVacancyRateLabel => '卡加利市場租賃空置率';

  @override
  String get cancel => '取消';

  @override
  String get categoryBeef => '牛肉';

  @override
  String get categoryBreakfast => '早餐';

  @override
  String get categoryChicken => '雞肉';

  @override
  String get categoryDairy => '乳製品';

  @override
  String get categoryFish => '魚類';

  @override
  String get categoryOther => '其他';

  @override
  String get categoryPork => '豬肉';

  @override
  String categoryPostsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString 則貼文',
      one: '$countString 則貼文',
    );
    return '$_temp0';
  }

  @override
  String get chooseTopicToPost => '選擇發佈主題';

  @override
  String get citywideMedianPriceNote => '此為全市依建築類型計算的中位售價變化，並非個別房產的估價。';

  @override
  String get claimJobButton => '接取工作';

  @override
  String get claimUnassignedSubtitle => '接取一項尚未指派的請求，最先成功接取者得標。';

  @override
  String get claimingEllipsis => '接取中...';

  @override
  String get clientSignIn => '客戶登入';

  @override
  String get community => '社區';

  @override
  String get communityFeeds => '社區動態';

  @override
  String get communityForumTooltip => '社區論壇';

  @override
  String get communityPost => '社區貼文';

  @override
  String get completeButton => '完成';

  @override
  String get confirmPasswordLabel => '確認密碼';

  @override
  String get confirmationEmailResent => '已寄出新的確認電子郵件，請只使用最新的連結，並僅開啟一次。';

  @override
  String couldNotAssignProvider(String error) {
    return '無法指派服務提供者：$error';
  }

  @override
  String couldNotClaimJob(String error) {
    return '無法接取工作：$error';
  }

  @override
  String couldNotCreateAccount(String error) {
    return '無法建立帳戶：$error';
  }

  @override
  String couldNotLaunchUrl(String url) {
    return '無法開啟 $url';
  }

  @override
  String couldNotLoadAdminData(String error) {
    return '無法載入管理員資料：$error';
  }

  @override
  String couldNotLoadBookings(String error) {
    return '無法載入預訂：$error';
  }

  @override
  String get couldNotLoadJobs => '無法載入職缺。';

  @override
  String couldNotLoadNotifications(String error) {
    return '無法載入通知：$error';
  }

  @override
  String get couldNotLoadPosts => '無法載入貼文';

  @override
  String couldNotLoadPostsError(String error) {
    return '無法載入貼文：$error';
  }

  @override
  String couldNotLoadProfile(String error) {
    return '無法載入個人資料：$error';
  }

  @override
  String couldNotLoadProviderPortal(String error) {
    return '無法載入服務提供者入口：$error';
  }

  @override
  String couldNotLoadReplies(String error) {
    return '無法載入回覆：$error';
  }

  @override
  String couldNotMarkAsRead(String error) {
    return '無法標示為已讀：$error';
  }

  @override
  String get couldNotOpenDirections => '無法開啟路線指引。';

  @override
  String get couldNotOpenTrafficReport => '無法開啟卡加利官方交通報告。';

  @override
  String couldNotPublish(String error) {
    return '無法發佈：$error';
  }

  @override
  String couldNotResendConfirmation(String error) {
    return '無法重新傳送確認信：$error';
  }

  @override
  String couldNotSaveLoginName(String error) {
    return '無法儲存登入名稱：$error';
  }

  @override
  String couldNotSendReply(String error) {
    return '無法傳送回覆：$error';
  }

  @override
  String couldNotSignOut(String error) {
    return '無法登出：$error';
  }

  @override
  String couldNotSubmitApplication(String error) {
    return '無法送出服務提供者申請：$error';
  }

  @override
  String couldNotSubmitBooking(String error) {
    return '無法送出預訂：$error';
  }

  @override
  String couldNotUpdateBookingStatus(String error) {
    return '無法更新預訂狀態：$error';
  }

  @override
  String couldNotUpdateJobStatus(String error) {
    return '無法更新工作狀態：$error';
  }

  @override
  String couldNotUpdateProfile(String error) {
    return '無法更新個人資料：$error';
  }

  @override
  String couldNotUpdateProviderVerification(String error) {
    return '無法更新服務提供者驗證：$error';
  }

  @override
  String couldNotVerifyRole(String error) {
    return '無法驗證帳戶角色：$error';
  }

  @override
  String get createAccountTitle => '建立帳戶';

  @override
  String get createClientAccountSubtitle => '建立客戶帳戶以預訂值得信賴的本地服務。';

  @override
  String get createPost => '發佈貼文';

  @override
  String get creatingAccountEllipsis => '建立帳戶中...';

  @override
  String currentIncidentsShown(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '目前顯示 $countString 起交通事件。',
      one: '目前顯示 $countString 起交通事件。',
    );
    return '$_temp0';
  }

  @override
  String get dataSourcesLabel => '資料來源';

  @override
  String get deals => '優惠';

  @override
  String get delete => '刪除';

  @override
  String get describeIssueHint => '告訴我們需要修復或完成的內容。';

  @override
  String get describeIssueLabel => '描述問題';

  @override
  String get describeIssueValidator => '描述問題';

  @override
  String get describeServiceSubtitle => '描述您在卡加利需要的服務。';

  @override
  String get developmentNearYouTitle => '您附近的開發案';

  @override
  String get dining => '餐飲';

  @override
  String get diningPost => '餐飲貼文';

  @override
  String get diningPostsTitle => '餐飲貼文';

  @override
  String get discussionFallback => '討論';

  @override
  String discussionsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString 則討論',
      one: '$countString 則討論',
    );
    return '$_temp0';
  }

  @override
  String get displayNameLabel => '顯示名稱';

  @override
  String get diyHome => '居家修繕';

  @override
  String get diyHomePost => '居家修繕貼文';

  @override
  String get diyHomeTitle => '居家修繕';

  @override
  String get edit => '編輯';

  @override
  String get emailAddressLabel => '電子郵件地址';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get emailLabel => '電子郵件';

  @override
  String get enterAtLeast3Characters => '請輸入至少 3 個字元。';

  @override
  String get enterDisplayName => '請輸入要在應用程式中顯示的名稱。';

  @override
  String get enterEmailAddress => '請輸入您的電子郵件地址';

  @override
  String get enterEmailAndPassword => '請輸入電子郵件和密碼。';

  @override
  String get enterEmailFirstResend => '請先輸入電子郵件地址，再重新傳送確認信。';

  @override
  String get enterFirstName => '請輸入您的名字。';

  @override
  String get enterFullName => '請輸入您的全名';

  @override
  String get enterLastName => '請輸入您的姓氏。';

  @override
  String get enterLocation => '請輸入您的位置';

  @override
  String get enterLoginName => '請輸入登入名稱';

  @override
  String get enterNeighbourhood => '請輸入社區名稱。';

  @override
  String get enterPhoneNumber => '請輸入電話號碼';

  @override
  String get enterServiceCategory => '請輸入服務類別';

  @override
  String get enterSignupDetails => '請輸入您的全名、電話號碼、電子郵件和密碼。';

  @override
  String get enterValidEmailAddress => '請輸入有效的電子郵件地址';

  @override
  String get enterYourNameHint => '請輸入您的名稱';

  @override
  String estimatedAmountValue(String amount) {
    return '預估金額：$amount';
  }

  @override
  String get expiryDate => '有效日期';

  @override
  String get exploreNeighbourCare => '探索 NeighbourCare';

  @override
  String get exploreSubtitle => '實用的卡加利資訊、本地連結與日常資源，一站掌握。';

  @override
  String get filter => '篩選';

  @override
  String get filterAll => '全部';

  @override
  String get filterLabelPrefix => '篩選：';

  @override
  String get findAssessedValueNote => '查詢卡加利特定房產的市府評估價值。';

  @override
  String get firstNameLabel => '名字';

  @override
  String get fontSizeLarge => '大';

  @override
  String get fontSizeNormal => '正常';

  @override
  String get fontSizeSmall => '小';

  @override
  String get forceAcceptButton => '強制接受';

  @override
  String get forceDeclineButton => '強制拒絕';

  @override
  String get fullNameHint => '您的名字與姓氏';

  @override
  String get fullNameLabel => '全名';

  @override
  String get getDirections => '取得路線';

  @override
  String groceryDealsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString 項雜貨優惠',
      one: '$countString 項雜貨優惠',
    );
    return '$_temp0';
  }

  @override
  String get heroSubtitle => '本地新聞、交通、優惠、住房與鄰里即時動態。';

  @override
  String get heroTitle => '您的卡加利社區，一站掌握。';

  @override
  String get hideReplies => '隱藏回覆';

  @override
  String get home => '首頁';

  @override
  String get homeRepairDiyHelp => '居家修繕 / DIY 協助';

  @override
  String get homeServiceFallback => '居家服務';

  @override
  String get housing => '住房';

  @override
  String get housingAndDevelopment => '房屋與發展';

  @override
  String get housingDataRefreshed => '房屋資料已更新。';

  @override
  String get housingDataSourcesText =>
      '房屋統計資料來源為卡加利市房屋研究與 CMHC 市場資訊。房產評估與開發詳情則透過卡加利市官方工具提供。';

  @override
  String get housingInfoDescription => '探索租賃市場趨勢、近期房價變化、官方房產評估，以及即將進行的開發活動。';

  @override
  String get housingTypeApartment => '公寓';

  @override
  String get housingTypeDetached => '獨立屋';

  @override
  String get housingTypeRowTownhouse => '排屋';

  @override
  String get housingTypeSemiDetached => '半獨立屋';

  @override
  String get jobAlreadyClaimed => '此工作已被其他服務提供者接取，列表現在將重新整理。';

  @override
  String get jobClaimedSuccess => '已成功接取工作。';

  @override
  String get jobListings => '職位空缺';

  @override
  String jobOpeningsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString 個職缺',
      one: '$countString 個職缺',
    );
    return '$_temp0';
  }

  @override
  String jobStatusChanged(String status) {
    return '工作狀態已變更為 $status。';
  }

  @override
  String get jobs => '職位';

  @override
  String get joinConversation => '加入討論';

  @override
  String get joinNeighbourCare => '加入 NeighbourCare';

  @override
  String get lastNameLabel => '姓氏';

  @override
  String lastRefreshedPrefix(String time) {
    return '上次更新：$time';
  }

  @override
  String get listLabel => '列表';

  @override
  String get live => '即時';

  @override
  String get liveDealsSubtitle => '來自參與本地商店的即時優惠，下拉即可重新整理。';

  @override
  String get loading => '載入中...';

  @override
  String get loadingDeals => '載入優惠中...';

  @override
  String get loadingDiscussions => '載入討論中...';

  @override
  String get loadingJobs => '載入職缺中...';

  @override
  String get loadingLiveUpdates => '載入即時更新中...';

  @override
  String get loadingPosts => '載入貼文中...';

  @override
  String get loadingTrafficUpdates => '載入交通更新中...';

  @override
  String get localSavings => '本地優惠';

  @override
  String localSavingsCouldNotUpdate(String error) {
    return '省錢資訊無法更新：\n\n$error';
  }

  @override
  String get localUpdateLabel => '本地動態';

  @override
  String get locationHint => '社區或郵遞區號';

  @override
  String get locationLabel => '位置';

  @override
  String get locationRadiusNote =>
      '位置功能將為選填。啟用後，您可選擇 2 公里、5 公里，或預設 10 公里的搜尋範圍。';

  @override
  String get locationUnavailable => '位置無法取得';

  @override
  String locationValue(String location) {
    return '位置：$location';
  }

  @override
  String get loginNameHint => '其他成員將看到的顯示方式';

  @override
  String get loginNameLabel => '登入名稱';

  @override
  String get loginNameMinLength => '登入名稱必須至少包含 3 個字元';

  @override
  String get loginNameTaken => '此登入名稱已被使用，請選擇另一個。';

  @override
  String get mapLabel => '地圖';

  @override
  String get markAsReadTooltip => '標示為已讀';

  @override
  String get markCompletedButton => '標示為已完成';

  @override
  String get marketMetricsSubtitle => '市場指標與開發許可';

  @override
  String get marketPriceTrendsTitle => '市場價格趨勢';

  @override
  String get marketplace => '跳蚤市場';

  @override
  String get marketplaceSubtitle => '買賣與分享';

  @override
  String get medianHomePricesTitle => '各建築類型中位房價';

  @override
  String get memberFallback => '會員';

  @override
  String get myAssignedJobsTitle => '我指派到的工作';

  @override
  String get myBookings => '我的預訂';

  @override
  String get myProfileTitle => '我的個人資料';

  @override
  String get neighbourCareCalgaryTitle => 'NeighbourCare 卡加利';

  @override
  String get neighbourCareCommunity => 'NeighbourCare 社區';

  @override
  String get neighbourCareServicesTitle => 'NeighbourCare 服務';

  @override
  String get neighbourhoodExampleHint => '例如：Beltline';

  @override
  String get neighbourhoodHint => '例如：Beltline 或 Tuscany';

  @override
  String get neighbourhoodLabel => '社區';

  @override
  String get neighbourhoodOptionalLabel => '卡加利社區（選填）';

  @override
  String get newToNeighbourCareSignUp => '第一次使用 NeighbourCare？立即註冊';

  @override
  String get newestApplicationsNote => '卡加利全市最新的申請案將優先顯示於此。';

  @override
  String get news => '新聞';

  @override
  String get noActiveDealsMatch => '沒有符合此搜尋或分類的優惠。';

  @override
  String get noActiveIncidents => '沒有進行中的事件';

  @override
  String get noActiveIncidentsListed => '目前沒有列出進行中的事件。';

  @override
  String get noBookingsYet => '尚無預訂記錄，請送出您的第一個服務請求。';

  @override
  String get noClaimedJobsYet => '您尚未接取任何工作。';

  @override
  String get noCommunityPosts => '尚無社區貼文。';

  @override
  String get noCurrentDeals => '目前沒有優惠';

  @override
  String get noCurrentTrafficIncidents => '目前沒有列出進行中的交通事件。';

  @override
  String get noDealsAvailable => '目前沒有可用的優惠。';

  @override
  String get noEmailAvailable => '沒有可用的電子郵件';

  @override
  String get noJobsFound => '找不到職缺。';

  @override
  String get noNotifications => '沒有通知。';

  @override
  String get noOpenRequests => '目前沒有可接取的開放請求。';

  @override
  String get noPostsShareFirst => '尚無貼文，成為第一個分享的人吧。';

  @override
  String get noProviderApplicationsFound => '找不到服務提供者申請。';

  @override
  String get noProviderProfileLinked =>
      '此帳戶尚未連結任何服務提供者資料。請使用此使用者的 Auth UUID 建立一筆 providers 資料。';

  @override
  String get noRecentDiscussions => '沒有最新討論。';

  @override
  String get noRecentPosts => '沒有最新貼文。';

  @override
  String get noRepliesYet => '尚無回覆。';

  @override
  String get noVerifiedPriceReductions => '目前沒有已驗證的降價優惠。';

  @override
  String get notAvailable => '無法取得';

  @override
  String get notProvided => '未提供';

  @override
  String notesValue(String notes) {
    return '備註：$notes';
  }

  @override
  String get notificationFallback => '通知';

  @override
  String get notificationsTitle => '通知';

  @override
  String get officialSourceLabel => '官方來源';

  @override
  String get openCalgaryDevelopmentMap => '開啟卡加利開發地圖';

  @override
  String get openCalgaryMyTax => '開啟卡加利市 myTax';

  @override
  String get openCityTrafficReport => '開啟市府交通報告';

  @override
  String get openRequestsTitle => '開放請求';

  @override
  String get optionsTooltip => '選項';

  @override
  String get otherLocalAssistance => '其他本地協助';

  @override
  String get passwordHelperText => '請使用至少 8 個字元。';

  @override
  String get passwordLabel => '密碼';

  @override
  String get passwordMinLength => '密碼必須包含至少 6 個字元。';

  @override
  String get passwordMinLength8 => '密碼必須至少包含 8 個字元。';

  @override
  String get passwordTooShort => '請使用至少 8 個字元';

  @override
  String get passwordsDoNotMatch => '密碼不一致';

  @override
  String get permitFeedComingNext => '許可證動態即將推出';

  @override
  String get phoneNumberLabel => '電話號碼';

  @override
  String get postFallback => '貼文';

  @override
  String get posted => '已發布';

  @override
  String postedOn(String date) {
    return '發佈於 $date';
  }

  @override
  String get preferredTimeHint => '今天下午 5–7 點或週六上午';

  @override
  String get preferredTimeLabel => '偏好時間';

  @override
  String preferredTimeValue(String time) {
    return '偏好時間：$time';
  }

  @override
  String get price => '價格';

  @override
  String get pricesTermsMayChange => '價格、庫存、會員資格要求及優惠條款可能會變動，前往之前請直接向商店確認。';

  @override
  String get privacyReminderText => '請勿包含住家地址、臉部、車牌、電話號碼或其他私人資訊。';

  @override
  String get profileUpdatedSuccess => '個人資料已成功更新。';

  @override
  String get providerApplicationTitle => '服務提供者申請';

  @override
  String get providerApprovalTitle => '服務提供者審核';

  @override
  String get providerApprovedSuccess => '服務提供者已成功核准。';

  @override
  String providerIdFallback(String id) {
    return '服務提供者 $id';
  }

  @override
  String get providerLabelPrefix => '服務提供者：';

  @override
  String get providerNotVerified =>
      '您的服務提供者資料尚未通過驗證，請請管理員將 pvsc_verified 設為 true。';

  @override
  String get providerPortal => '服務提供者入口';

  @override
  String get providerPortalTitle => '服務提供者入口';

  @override
  String get providerPortalTooltip => '服務提供者入口';

  @override
  String get providerVerificationRemoved => '已移除服務提供者驗證。';

  @override
  String get publishReportButton => '發佈報告';

  @override
  String get publishingEllipsis => '發佈中…';

  @override
  String get rankedByVerifiedSavings => '依已驗證省錢百分比排序';

  @override
  String ratingValue(String rating) {
    return '評分：$rating';
  }

  @override
  String get refreshBookings => '重新整理預訂';

  @override
  String get refreshTooltip => '重新整理';

  @override
  String get refreshTraffic => '重新整理交通';

  @override
  String get regularPrice => '原價';

  @override
  String regularPriceValue(String price) {
    return '原價：$price';
  }

  @override
  String get rentalAvailabilityChangesNote => '卡加利租賃供給狀況與近期房價中位數變化。';

  @override
  String get rentalMarketVacancyRateTitle => '租賃市場空置率';

  @override
  String get rentalVacancyRateLabel => '租賃空置率';

  @override
  String get replyAction => '回覆';

  @override
  String get reportLocalConditionsTitle => '回報本地狀況';

  @override
  String get requestHelp => '請求協助';

  @override
  String requestedFromCommunityPost(String title) {
    return '來自社區貼文的請求：$title\n\n請描述所需的協助：';
  }

  @override
  String get resendConfirmationEmail => '重新傳送確認信';

  @override
  String get retry => '重試';

  @override
  String get save => '儲存';

  @override
  String get saveOnGroceriesTitle => '在卡加利省錢購買雜貨';

  @override
  String get saveProfileButton => '儲存個人資料';

  @override
  String get savingEllipsis => '儲存中...';

  @override
  String get savings => '省錢';

  @override
  String get search => '搜尋';

  @override
  String get searchByProductOrStore => '依商品或商店搜尋';

  @override
  String get serviceCategoryHint => '水管、暖爐、除雪...';

  @override
  String get serviceCategoryLabel => '服務類別';

  @override
  String get serviceFallback => '服務';

  @override
  String get shareAnUpdate => '分享動態';

  @override
  String get shareFactualConditionsHint => '請分享真實、即時的狀況。';

  @override
  String get shareLocalConditionsWarning => '分享目前的本地狀況。如遇緊急情況，請立即致電 911。';

  @override
  String get showList => '顯示列表';

  @override
  String get showMap => '顯示地圖';

  @override
  String get signIn => '登入';

  @override
  String get signInAsProvider => '請以服務提供者身分登入。';

  @override
  String get signInBeforeBooking => '請先登入才能送出預訂。';

  @override
  String get signInBeforePosting => '請先登入才能發文。';

  @override
  String get signInBeforeUpdatingProfile => '請先登入才能更新您的個人資料。';

  @override
  String signInFailed(String error) {
    return '登入失敗：$error';
  }

  @override
  String get signInRequired => '需要登入';

  @override
  String get signInSubtitle => '登入以預訂並管理居家服務。';

  @override
  String get signInToCreatePost => '請先以客戶或服務提供者身分登入，再發布社區貼文。';

  @override
  String get signInToReply => '請登入以回覆。';

  @override
  String get signInToRequestHelp => '請登入以對社區貼文請求協助。';

  @override
  String get signInToViewBookings => '請登入以檢視您的預訂。';

  @override
  String get signInToViewNotifications => '請登入以檢視您的通知。';

  @override
  String get signInToViewProfile => '請登入以檢視您的個人資料。';

  @override
  String get signOut => '登出';

  @override
  String get signOutTooltip => '登出';

  @override
  String get signedInFallback => '已登入';

  @override
  String get signedInMember => '已登入會員';

  @override
  String get sourceCalgaryOpenData => '來源：卡加利市開放資料。';

  @override
  String get startJobButton => '開始工作';

  @override
  String get statusAccepted => '已接受';

  @override
  String get statusAssigned => '已指派';

  @override
  String get statusCancelled => '已取消';

  @override
  String get statusCompleted => '已完成';

  @override
  String get statusDeclined => '已拒絕';

  @override
  String get statusInProgress => '進行中';

  @override
  String get statusPending => '待處理';

  @override
  String statusValue(String status) {
    return '狀態：$status';
  }

  @override
  String get store => '商店';

  @override
  String get submit => '提交';

  @override
  String get submitApplicationButton => '送出申請';

  @override
  String get submitApplicationSubtitle => '送出您的申請以供管理員審核。';

  @override
  String get submitBookingButton => '送出預訂';

  @override
  String get submittingEllipsis => '送出中...';

  @override
  String get suspendButton => '停權';

  @override
  String get textSizeLabel => '文字大小';

  @override
  String get traffic => '交通';

  @override
  String get trafficDetailsWarning =>
      '交通狀況可能瞬息萬變，出發前請查閱卡加利市報告以了解封閉路段、繞道、監視器與路況更新。';

  @override
  String get trafficIncidentFallback => '交通事件';

  @override
  String get trafficIncidentReported => '已回報交通事件。';

  @override
  String get trafficRoadConditions => '道路狀況';

  @override
  String get trafficSourceNote => '交通資料來源：卡加利市開放資料。出發前請再次確認路況。';

  @override
  String get trafficUpdatesUnavailable => '目前無法取得交通更新。';

  @override
  String get tryAgainButton => '再試一次';

  @override
  String get unassigned => '未指派';

  @override
  String get updateTimeUnavailable => '更新時間無法取得';

  @override
  String updatedPrefix(String time) {
    return '更新時間：$time';
  }

  @override
  String get vacancyRate2025Note => '卡加利 2025 年市場空置率，較 2024 年的 4.6% 上升。';

  @override
  String get vacancyRateExplainer => '較高的空置率可能代表更多租屋選擇，但實際供給與租金仍依社區與房屋類型而異。';

  @override
  String get vacancyRateIncreaseNote =>
      '市場空置率已從 2023 年的 1.4% 上升至 2025 年的 5.1%。';

  @override
  String get verifiedLabel => '已驗證';

  @override
  String get viewAllGroceryDeals => '查看所有雜貨優惠';

  @override
  String get viewCityHousingTrends => '查看市府房屋趨勢';

  @override
  String get viewDetails => '查看詳情';

  @override
  String get viewLatestStatistics => '查看最新統計數據';

  @override
  String get viewModeLabel => '顯示模式';

  @override
  String get weather => '天氣';

  @override
  String get weatherRelatedHomeHelp => '天氣相關居家協助';

  @override
  String get weatherUpdate => '天氣動態';

  @override
  String get weatherUpdatePublished => '天氣動態已發佈。';

  @override
  String get weatherUpdatesTitle => '天氣動態';

  @override
  String get welcomeToNeighbourCare => '歡迎使用 NeighbourCare';

  @override
  String get whatIsHappeningLabel => '發生了什麼事？';

  @override
  String get writeAReplyHint => '輸入回覆...';

  @override
  String get yourAccountTitle => '您的帳戶';

  @override
  String get yoyChangeQ22026 => '年比變化，2026 年第二季';

  @override
  String get updatingWeather => '正在更新天氣...';

  @override
  String weatherUpdateUnavailable(String error) {
    return '無法更新天氣：$error';
  }

  @override
  String get weatherAlertIssued => '已發布天氣警報';

  @override
  String get calgaryIntlAirport => '卡加利國際機場';

  @override
  String weatherHumidity(String humidity) {
    return '濕度：$humidity%';
  }

  @override
  String weatherWind(String wind) {
    return '風速：$wind';
  }

  @override
  String weatherVisPres(String visibility, String pressure) {
    return '能見度：$visibility • 氣壓：$pressure';
  }

  @override
  String get hideForecast => '隱藏預報';

  @override
  String get showFullForecast => '顯示 24 小時及多日預報';

  @override
  String get hourlyForecastTitle => '24小時天氣預報';

  @override
  String get multiDayOutlookTitle => '多日展望';

  @override
  String weatherHigh(String temp) {
    return '最高 $temp';
  }

  @override
  String weatherLow(String temp) {
    return '最低 $temp';
  }
}
