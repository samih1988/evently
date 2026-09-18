import 'package:evently/model/my_user.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  MyUser? myUser;

  void updateMyUser(MyUser newMyUser) {
    myUser = newMyUser;
    notifyListeners();
  }
}
