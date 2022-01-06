import 'dart:convert';
import 'dart:io';

import 'package:rxdart/subjects.dart';
import 'package:ufone_web/src/model/User.dart';
import 'package:ufone_web/src/resource/repository/user_repository.dart';
import 'bloc_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class AuthenticationBloc implements BlocBase {
  static AuthenticationBloc? _authenticationBloc;
  final userRepository = UserRepository();


  final loginDrawerStreamController = PublishSubject<void>();

  Stream<void> get loginDrawerStream => loginDrawerStreamController.stream;



  final imageStreamController = BehaviorSubject<User>();

  Stream<User> get imageStream => imageStreamController.stream;

  final userAuthStreamController = BehaviorSubject<User>();

  Stream<User> get userAuthStream => userAuthStreamController.stream;

  final forgotPasswordStreamController = BehaviorSubject<String>();

  Stream<String> get forgotPasswordStream =>
      forgotPasswordStreamController.stream;

  static AuthenticationBloc? getInstance() {
    if (_authenticationBloc == null) {
      _authenticationBloc = AuthenticationBloc();
    }
    return _authenticationBloc;
  }

  // void uploadImageToServer({File? image, String? url}) async {
  //   await userRepository.uploadImageToServer(file: image, url: url).then(
  //           (model) {
  //         imageStreamController.sink.add(model);
  //       }, onError: (exception) {
  //     imageStreamController.sink.addError(exception);
  //   });
  // }

  // void userAuth({User? user, String? url}) async {
  //   await userRepository.userAuth(user: user, url: url).then((model) {
  //     userAuthStreamController.sink.add(model);
  //   }, onError: (exception) {
  //     userAuthStreamController.sink.addError(exception);
  //   });
  // }

  void forgotPassword({String? email, String? url}) async {
    await userRepository.forgotPassword(email: email, url: url).then((model) {
      forgotPasswordStreamController.sink.add(model!);
    }, onError: (exception) {
      forgotPasswordStreamController.sink.addError(exception);
    });
  }







  void logout() {
    // _googleSignIn.isSignedIn().then((value) async {
    //   if (value) {
    //     _googleSignIn.signOut();
    //     SharedPref.createInstance().setToken(null);
    //     await SharedPref.createInstance().setCurrentUser(null);
    //   } else {
    //     SharedPref.createInstance().setToken(null);
    //     await SharedPref.createInstance().setCurrentUser(null);
    //   }
    // });
  }

  @override
  void dispose() {
    loginDrawerStreamController.close();
    userAuthStreamController.close();
    forgotPasswordStreamController.close();
    imageStreamController.close();
  }
}
