import 'package:flutter/material.dart';

class UserProfileModel extends ChangeNotifier {
  String _name = 'Daniel Filho Manoel';
  int _age = 30;
  String _email = 'daniel.filho@example.com';
  bool _isOnline = false;
  List<String> _hobbies = ['Programação', 'Leitura'];

  String get name => _name;
  int get age => _age;
  String get email => _email;
  bool get isOnline => _isOnline;
  List<String> get hobbies => List.unmodifiable(_hobbies);

  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void updateAge(int newAge) {
    _age = newAge;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  void toggleOnlineStatus() {
    _isOnline = !_isOnline;
    notifyListeners();
  }

  void addHobby(String hobby) {
    if (!_hobbies.contains(hobby)) {
      _hobbies.add(hobby);
      notifyListeners();
    }
  }

  void removeHobby(String hobby) {
    _hobbies.remove(hobby);
    {
      notifyListeners();
    }
  }

  void reset() {
    _name = 'Daniel Filho Manoel';
    _age = 30;
    _email = 'daniel.filho@example.com';
    _isOnline = false;
    _hobbies = ['Programação', 'Leitura'];
    notifyListeners();
  }
}
