import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../pages/client_profile_page.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class TopBannerWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double fontScale;
  final ValueChanged<Locale>? onLanguageChanged;
  final ValueChanged<double>? onFontScaleChanged;
  final VoidCallback? onRefresh;
  final VoidCallback? onSignInPressed;
  final List<Widget>? extraActions;
  final bool isProvider;
  final VoidCallback? onProviderPortalPressed;

  const TopBannerWidget({
    super.key,
    required this.title,
    this.fontScale = 1.0,
    this.onLanguageChanged,
    this.onFontScaleChanged,
    this.onRefresh,
    this.onSignInPressed,
    this.isProvider = false, // Default to false for non-providers
    this.onProviderPortalPressed,
    this.extraActions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.canPop ?? false;
    final authService = context.watch<AuthService>();
    final isSignedIn = authService.session != null;
    final loginName = authService.loginName ?? authService.email;

    // Obtain user session from Supabase
    final user = Supabase.instance.client.auth.currentUser;
    
    // Explicitly derived from AuthService state; will cleanly show account_circle for clients and business for providers
   final bool showProviderIcon = isSignedIn && 
      (isProvider || 
       authService.isProvider || 
       user?.userMetadata?['role'] == 'provider' || 
       user?.userMetadata?['is_provider'] == true);

    return AppBar(
      backgroundColor: const Color(0xFF0C7A6C),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      leading: canPop
          ? IconButton(
              icon: const Icon(Icons.arrow_back, size: 28),
              padding: const EdgeInsets.all(12),
              constraints: const BoxConstraints(
                minWidth: 48,
                minHeight: 48,
              ),
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: () => Navigator.of(context).maybePop(),
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18 * fontScale,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: [
        if (showProviderIcon)
          IconButton(
            icon: const Icon(Icons.business_center_outlined),
            tooltip: 'Provider Portal',
            onPressed: onProviderPortalPressed,
          ),
        if (isSignedIn)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ClientProfilePage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 130),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isProvider ? Icons.business : Icons.account_circle, 
                          size: 18, 
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            loginName ?? AppLocalizations.of(context)!.signedInFallback,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        if (onRefresh != null)
          IconButton(
            icon: const Icon(Icons.refresh, size: 24),
            padding: const EdgeInsets.all(10),
            constraints: const BoxConstraints(
              minWidth: 48,
              minHeight: 48,
            ),
            tooltip: AppLocalizations.of(context)!.refreshTooltip,
            onPressed: onRefresh,
          ),
        if (extraActions != null)
          IconTheme.merge(
            data: const IconThemeData(color: Colors.white),
            child: Row(mainAxisSize: MainAxisSize.min, children: extraActions!),
          ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, size: 26, color: Colors.white),
          tooltip: AppLocalizations.of(context)!.optionsTooltip,
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                enabled: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.textSizeLabel,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFontScaleButton(context, AppLocalizations.of(context)!.fontSizeSmall, 1.00),
                        _buildFontScaleButton(context, AppLocalizations.of(context)!.fontSizeNormal, 1.20),
                        _buildFontScaleButton(context, AppLocalizations.of(context)!.fontSizeLarge, 1.40),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'en',
                child: Row(
                  children: [
                    Icon(Icons.language, size: 22, color: Color(0xFF0C7A6C)),
                    SizedBox(width: 8),
                    Text('English'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'zh_TW',
                child: Row(
                  children: [
                    Icon(Icons.language, size: 22, color: Color(0xFF0C7A6C)),
                    SizedBox(width: 8),
                    Text('繁體中文'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'zh_CN',
                child: Row(
                  children: [
                    Icon(Icons.language, size: 22, color: Color(0xFF0C7A6C)),
                    SizedBox(width: 8),
                    Text('简体中文'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'fr',
                child: Row(
                  children: [
                    Icon(Icons.language, size: 22, color: Color(0xFF0C7A6C)),
                    SizedBox(width: 8),
                    Text('Français'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'es',
                child: Row(
                  children: [
                    Icon(Icons.language, size: 22, color: Color(0xFF0C7A6C)),
                    SizedBox(width: 8),
                    Text('Español'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'pa',
                child: Row(
                  children: [
                    Icon(Icons.language, size: 22, color: Color(0xFF0C7A6C)),
                    SizedBox(width: 8),
                    Text('ਪੰਜਾਬੀ'),
                  ],
                ),
              ),
              if (!isSignedIn && onSignInPressed != null) ...[
                const PopupMenuItem<String>(
                  enabled: false,
                  child: Divider(),
                ),
                PopupMenuItem<String>(
                  value: 'signin',
                  child: Row(
                    children: [
                      const Icon(Icons.login, size: 22, color: Color(0xFF0C7A6C)),
                      const SizedBox(width: 8),
                      Text(AppLocalizations.of(context)!.signIn),
                    ],
                  ),
                ),
              ],
              if (isSignedIn) ...[
                const PopupMenuItem<String>(
                  enabled: false,
                  child: Divider(),
                ),
                const PopupMenuItem<String>(
                  value: 'profile',
                  child: Row(
                    children: [
                      Icon(Icons.person, size: 22, color: Color(0xFF0C7A6C)),
                      SizedBox(width: 8),
                      Text('Profile'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'signout',
                  child: Row(
                    children: [
                      const Icon(Icons.logout, size: 22, color: Color(0xFF0C7A6C)),
                      const SizedBox(width: 8),
                      Text(AppLocalizations.of(context)!.signOutTooltip),
                    ],
                  ),
                ),
              ],
            ];
          },
          onSelected: (value) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (value == 'en') {
                onLanguageChanged?.call(const Locale('en'));
              } else if (value == 'zh_TW') {
                onLanguageChanged?.call(const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'));
              } else if (value == 'zh_CN') {
                onLanguageChanged?.call(const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'));
              } else if (value == 'fr') {
                onLanguageChanged?.call(const Locale('fr'));
              } else if (value == 'es') {
                onLanguageChanged?.call(const Locale('es'));
              } else if (value == 'pa') {
                onLanguageChanged?.call(const Locale('pa'));
              } else if (value == 'signin') {
                onSignInPressed?.call();
              } else if (value == 'profile') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ClientProfilePage(),
                  ),
                );
              } else if (value == 'signout') {
                authService.signOut();
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildFontScaleButton(
    BuildContext context,
    String label,
    double scale,
  ) {
    final isSelected = (fontScale - scale).abs() < 0.05;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
      selected: isSelected,
      selectedColor: const Color(0xFF0C7A6C),
      onSelected: (_) {
        onFontScaleChanged?.call(scale);
        Navigator.of(context).pop();
      },
    );
  }
}