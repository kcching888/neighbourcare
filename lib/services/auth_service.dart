import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AuthService extends ChangeNotifier {
  Session? _session;
  bool _isAdmin = false;
  bool _loading = true;
  String? _error;
  String? _loginName;
  int _goldPoint = 0;

  Session? get session => _session;
  bool get isAdmin => _isAdmin;
  bool get loading => _loading;
  String? get error => _error;

  String? get userId => _session?.user.id;
  String? get email => _session?.user.email;
  String? get loginName =>
      _loginName ?? _session?.user.userMetadata?['login_name']?.toString();
  int get goldPoint => _goldPoint;

  AuthService() {
    _init();
  }

  void _init() {
    supabase.auth.onAuthStateChange.listen(
      _onAuthChanged,
      onError: (error, stackTrace) {
        debugPrint('Auth stream error: $error');
        _error = error.toString();
        _loading = false;
        notifyListeners();
      },
    );

    _session = supabase.auth.currentSession;
    _loadAdminStatus();
    _loadUserDataAndCheckDailyLogin();
    _loading = false;
    notifyListeners();
  }

  Future<void> _onAuthChanged(AuthState authState) async {
    _session = authState.session;
    await _loadAdminStatus();
    await _loadUserDataAndCheckDailyLogin();
    notifyListeners();
  }

  Future<void> _loadUserDataAndCheckDailyLogin() async {
    if (_session == null) {
      _loginName = null;
      _goldPoint = 0;
      return;
    }

    try {
      // 1. Fetch profile details
      final row = await supabase
          .from('users')
          .select('login_name, gold_point')
          .eq('id', _session!.user.id)
          .maybeSingle();

      _loginName = row?['login_name']?.toString();
      _goldPoint = (row?['gold_point'] as num?)?.toInt() ?? 0;

      // 2. Rule 1: Award Daily Login Points (2 gold/day) automatically
      await claimDailyLogin();
    } catch (e) {
      debugPrint('Failed to load user data: $e');
    }
  }

  Future<void> _loadAdminStatus() async {
    if (_session == null) {
      _isAdmin = false;
      return;
    }

    try {
      final row = await supabase
          .from('admin_roles')
          .select('role')
          .eq('user_id', _session!.user.id)
          .maybeSingle();

      _isAdmin = row?['role'] == 'admin';
    } catch (e) {
      debugPrint('Failed to load admin role: $e');
      _isAdmin = false;
    }
  }

  /// Rule 1: Daily Login (+2 Gold)
  Future<void> claimDailyLogin() async {
    if (_session == null) return;

    try {
      final updatedPoints = await supabase.rpc(
        'award_gold_points',
        params: {
          'target_user_id': _session!.user.id,
          'points_to_add': 2,
          'point_reason': 'daily_login',
        },
      ) as int?;

      if (updatedPoints != null && updatedPoints != _goldPoint) {
        _goldPoint = updatedPoints;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to claim daily login bonus: $e');
    }
  }

  /// Rule 2: Member Referral (+10 Gold to referrer)
  Future<void> awardReferralBonus(String referrerUserId, String newMemberId) async {
    try {
      await supabase.rpc(
        'award_gold_points',
        params: {
          'target_user_id': referrerUserId,
          'points_to_add': 10,
          'point_reason': 'referral',
          'ref_id': newMemberId,
        },
      );
    } catch (e) {
      debugPrint('Failed to award referral bonus: $e');
    }
  }

  /// Rule 3: Order Service (+10 Gold per completed order)
  Future<void> awardOrderBonus(String orderId) async {
    if (_session == null) return;

    try {
      final updatedPoints = await supabase.rpc(
        'award_gold_points',
        params: {
          'target_user_id': _session!.user.id,
          'points_to_add': 10,
          'point_reason': 'order_service',
          'ref_id': orderId,
        },
      ) as int?;

      if (updatedPoints != null) {
        _goldPoint = updatedPoints;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to award order bonus: $e');
    }
  }

 /// Sign in using either email address or login_name
Future<void> signIn({
  required String emailOrLoginName, // Updated parameter name
  required String password,
}) async {
  try {
    String targetEmail = emailOrLoginName.trim();

    // If user typed a login_name instead of an email address
    if (!targetEmail.contains('@')) {
      final userRow = await supabase
          .from('users')
          .select('id')
          .eq('login_name', targetEmail)
          .maybeSingle();

      if (userRow == null) {
        throw const AuthException('Invalid login name or password.');
      }
    }

    final response = await supabase.auth.signInWithPassword(
      email: targetEmail,
      password: password,
    );

    debugPrint(
      'Sign-in completed. User ID: ${response.user?.id}, Session exists: ${response.session != null}',
    );
  } on AuthException catch (error) {
    debugPrint('Sign-in error: ${error.message}');
    rethrow;
  }
}

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}