// providers/user_provider.dart
import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserProvider with ChangeNotifier {
  final ApiService _apiService;

  List<User> _users = [];
  bool _loading = false;
  String? _error;

  UserProvider(this._apiService);

  List<User> get users => _users;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchUsers() async {
    _setLoading(true);
    _setError(null);

    try {
      _users = await _apiService.getUsers();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addUser(User user) async {
    _setLoading(true);
    _setError(null);

    try {
      final newUser = await _apiService.createUser(user);
      _users.add(newUser);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateUser(User user) async {
    _setLoading(true);
    _setError(null);

    try {
      final updatedUser = await _apiService.updateUser(user);
      final index = _users.indexWhere((u) => u.id == user.id);
      if (index != -1) {
        _users[index] = updatedUser;
        notifyListeners();
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteUser(String userId) async {
    _setLoading(true);
    _setError(null);

    try {
      await _apiService.deleteUser(userId);
      _users.removeWhere((user) => user.id == userId);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }
}