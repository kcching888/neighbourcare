import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AuthService extends ChangeNotifier {
  Session? _session;
  bool _isAdmin = false;
  bool _loading = true;
  String? _error;

  Session? get session => _session;
  bool get isAdmin => _isAdmin;
  bool get loading => _loading;
  String? get error => _error;

  String? get userId => _session?.user.id;
  String? get email => _session?.user.email;

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
    _loading = false;
    notifyListeners();
  }

  Future<void> _onAuthChanged(AuthState authState) async {
    _session = authState.session;
    await _loadAdminStatus();
    notifyListeners();
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
       debugPrint(
      'Admin check: user=${_session!.user.id}, '
      'role=${row?['role']}, isAdmin=$_isAdmin',
       );
    } catch (e) {
      debugPrint('Failed to load admin role: $e');
      _isAdmin = false;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      debugPrint(
        'Sign-in completed. '
        'User ID: ${response.user?.id}, '
        'Session exists: ${response.session != null}',
      );
    } on AuthException catch (error) {
      debugPrint(
        'Sign-in error: ${error.message}, '
        'status: ${error.statusCode}, '
        'code: ${error.code}',
      );
      rethrow;
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}