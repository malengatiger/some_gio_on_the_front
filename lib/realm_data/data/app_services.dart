import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

final RealmAppServices realmAppServices = RealmAppServices();

class RealmAppServices with ChangeNotifier {
  //String id;
  //Uri baseUrl;
  App app;
  User? currentUser;
  static const email = 'aubrey@aftarobot.com',
      password = 'kkTiger3#',
      id = '6478402d6358d2b0e1ba6abe';

  RealmAppServices() : app = App(AppConfiguration(id));

  Future<User> logInUserEmailPassword(String email, String password) async {
    User loggedInUser =
        await app.logIn(Credentials.emailPassword(email, password));
    currentUser = loggedInUser;
    notifyListeners();
    return loggedInUser;
  }

  Future<User> registerUserEmailPassword(String email, String password) async {
    EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(app);
    await authProvider.registerUser(email, password);
    User loggedInUser =
        await app.logIn(Credentials.emailPassword(email, password));
    currentUser = loggedInUser;
    notifyListeners();
    return loggedInUser;
  }

  Future<void> logOut() async {
    await currentUser?.logOut();
    currentUser = null;
  }
}
