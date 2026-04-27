import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_model.dart';

class AuthService {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('current_user');
    if (userData != null) {
      _currentUser = UserModel.fromJson(json.decode(userData));
      return true;
    }
    return false;
  }

  // Register user
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Get existing users
      final usersJson = prefs.getString('users') ?? '[]';
      final List<dynamic> users = json.decode(usersJson);

      // Check if email already exists
      final existingUser = users.firstWhere(
            (u) => u['email'] == email,
        orElse: () => null,
      );

      if (existingUser != null) {
        return false; // Email already registered
      }

      // Create new user
      final newUser = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': name,
        'email': email,
        'password': password,
      };

      users.add(newUser);
      await prefs.setString('users', json.encode(users));

      return true;
    } catch (e) {
      print('Registration error: $e');
      return false;
    }
  }

  // Login user
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString('users') ?? '[]';
      final List<dynamic> users = json.decode(usersJson);

      // Find user
      final userMap = users.firstWhere(
            (u) => u['email'] == email && u['password'] == password,
        orElse: () => null,
      );

      if (userMap == null) {
        return null; // Invalid credentials
      }

      // Create UserModel
      _currentUser = UserModel(
        id: userMap['id'],
        name: userMap['name'],
        email: userMap['email'],
      );

      // Save current user
      await prefs.setString('current_user', json.encode(_currentUser!.toJson()));

      return _currentUser;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user');
    _currentUser = null;
  }

  // Update user profile
  Future<bool> updateProfile({
    required String name,
    String? phoneNumber,
    String? medicalAidNumber,
  }) async {
    try {
      if (_currentUser == null) return false;

      _currentUser = _currentUser!.copyWith(
        name: name,
        phoneNumber: phoneNumber,
        medicalAidNumber: medicalAidNumber,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user', json.encode(_currentUser!.toJson()));

      return true;
    } catch (e) {
      print('Update profile error: $e');
      return false;
    }
  }

  // Update medical information
  Future<bool> updateMedicalInfo({
    String? bloodGroup,
    String? allergies,
    String? chronicConditions,
    String? medications,
    String? emergencyContactName,
    String? emergencyContactNumber,
  }) async {
    try {
      if (_currentUser == null) return false;

      _currentUser = _currentUser!.copyWith(
        bloodGroup: bloodGroup,
        allergies: allergies,
        chronicConditions: chronicConditions,
        medications: medications,
        emergencyContactName: emergencyContactName,
        emergencyContactNumber: emergencyContactNumber,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user', json.encode(_currentUser!.toJson()));

      // Also update in users list
      final usersJson = prefs.getString('users') ?? '[]';
      final List<dynamic> users = json.decode(usersJson);

      final index = users.indexWhere((u) => u['id'] == _currentUser!.id);
      if (index != -1) {
        users[index] = _currentUser!.toJson();
        await prefs.setString('users', json.encode(users));
      }

      return true;
    } catch (e) {
      print('Update medical info error: $e');
      return false;
    }
  }
}