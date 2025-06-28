import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../services/preferences_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final PreferencesService _prefsService = PreferencesService();
  
  User? _user;
  bool _isLoading = false;
  String _error = '';

  User? get user => _user;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _authService.authStateChanges.listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<bool> signUp(String email, String password) async {
    try {
      _setLoading(true);
      _clearError();
      
      final result = await _authService.signUp(email, password);
      if (result != null) {
        await _prefsService.setLoggedIn(true, userId: result.user!.uid);
        return true;
      }
      return false;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _setLoading(true);
      _clearError();
      
      final result = await _authService.signIn(email, password);
      if (result != null) {
        await _prefsService.setLoggedIn(true, userId: result.user!.uid);
        return true;
      }
      return false;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    await _prefsService.setLoggedIn(false);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = '';
    notifyListeners();
  }
}