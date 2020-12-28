import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shady_market/models/Person.dart';

class CurrentUserProvider extends ChangeNotifier {
  Person _currentUser;

  Person get currentUser {
    return _currentUser.copyWith();
  }

  void set currentUser(Person newUser) {
    _currentUser = newUser;
    notifyListeners();
  }

  void set name(String newName) {
    _currentUser = _currentUser.copyWith(name: newName);
    notifyListeners();
  }

  void set password(String newPassword) {
    _currentUser = _currentUser.copyWith(password: newPassword);
    notifyListeners();
  }

  void set email(String newEmail) {
    _currentUser = _currentUser.copyWith(email: newEmail);
    notifyListeners();
  }

  void set pictureUrl(String newPictureUrl) {
    _currentUser = _currentUser.copyWith(pictureUrl: newPictureUrl);
    notifyListeners();
  }

  void set location(String newLocation) {
    _currentUser = _currentUser.copyWith(location: newLocation);
    notifyListeners();
  }

  void set credit(double newCredit) {
    _currentUser = _currentUser.copyWith(credit: newCredit);
    notifyListeners();
  }

  bool get isLogedIn {
    return _currentUser != null;
  }
}
