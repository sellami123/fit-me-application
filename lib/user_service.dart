import 'user_model.dart';

class UserService {
  static final List<User> _users = [];

  static void addUser(String email, String password) {
    _users.add(User(email: email, password: password));
  }

  static bool userExists(String email, String password) {
    return _users
        .any((user) => user.email == email && user.password == password);
  }

  static List<User> getUsers() {
    return _users;
  }
}
