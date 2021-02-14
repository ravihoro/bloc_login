import 'dart:convert';
import '../model/user.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

final url = "http://192.168.0.6:3000";

class AuthenticationRepository {
  final _userController = StreamController<User>();

  Stream<User> get user async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield User.empty;
    yield* _userController.stream;
  }

  // Future<bool> login(
  //     {@required String email, @required String password}) async {
  //   bool userPresent = false;
  //   await Future<void>.delayed(const Duration(milliseconds: 300), () {
  //     User user = UserModel.getUser(email);
  //     if (user == User.empty)
  //       userPresent = false;
  //     else {
  //       _userController.add(UserModel.getUser(email));
  //       userPresent = true;
  //     }
  //   });
  //   return userPresent;
  // }

  Future<bool> login(
      {@required String email, @required String password}) async {
    var response;
    try {
      Map data = {
        'email': email,
        'password': password,
      };

      String body = jsonEncode(data);

      response = await http.post(
        url + "/login",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
    } catch (e) {
      print(e.toString());
    }
    if (response.statusCode == 401) {
      return false;
    } else {
      var data = jsonDecode(response.body);
      _userController.add(User(
          name: data['name'],
          email: data['email'],
          password: data['password']));
      return true;
    }
  }

  void logOut() {
    _userController.add(User.empty);
  }

  Future<bool> signUp({
    @required String name,
    @required String email,
    @required String password,
  }) async {
    // print(name);
    // print(email);
    // print(password);
    var response; //; = await http.post(url + "/users");
    try {
      //response = await http.get(url + "/users");

      Map data = {
        'name': name,
        'email': email,
        'password': password,
      };

      String body = jsonEncode(data);

      response = await http.post(
        url + "/signup",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
    } catch (e) {
      print(e.toString());
    }

    //print(response.body);
    if (response.statusCode == 409) {
      return false;
    } else {
      return true;
    }
  }

  // bool signUp({
  //   @required String name,
  //   @required String email,
  //   @required String password,
  // }) {
  //   if (!UserModel.checkUserExists(email)) {
  //     UserModel.addUser(name, email, password);
  //     return true;
  //   }
  //   return false;
  // }

  void dispose() {
    _userController.close();
  }
}
