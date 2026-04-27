import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  // Initialize auth state
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    final isLoggedIn = await _authService.isLoggedIn();
    if (isLoggedIn) {
      _user = _authService.currentUser;
    }

    _isLoading = false;
    notifyListeners();
  }

  // Register
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    final success = await _authService.register(
      name: name,
      email: email,
      password: password,
    );

    _isLoading = false;
    notifyListeners();

    return success;
  }

  // Login
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    final user = await _authService.login(
      email: email,
      password: password,
    );

    if (user != null) {
      _user = user;
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Logout
  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }

  // Update Profile
  Future<bool> updateProfile({
    required String name,
    String? phoneNumber,
    String? medicalAidNumber,
  }) async {
    final success = await _authService.updateProfile(
      name: name,
      phoneNumber: phoneNumber,
      medicalAidNumber: medicalAidNumber,
    );

    if (success && _user != null) {
      _user = _authService.currentUser;
      notifyListeners();
    }

    return success;
  }

  // Update Medical Info
  Future<bool> updateMedicalInfo({
    String? bloodGroup,
    String? allergies,
    String? chronicConditions,
    String? medications,
    String? emergencyContactName,
    String? emergencyContactNumber,
  }) async {
    final success = await _authService.updateMedicalInfo(
      bloodGroup: bloodGroup,
      allergies: allergies,
      chronicConditions: chronicConditions,
      medications: medications,
      emergencyContactName: emergencyContactName,
      emergencyContactNumber: emergencyContactNumber,
    );

    if (success && _user != null) {
      _user = _authService.currentUser;
      notifyListeners();
    }

    return success;
  }
}