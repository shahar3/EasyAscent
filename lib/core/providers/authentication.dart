import 'package:easy_ascent/core/enums/enums.dart';
import 'package:easy_ascent/core/models/user.dart';
import 'package:easy_ascent/core/services/authentication.dart';

import '../../locator.dart';
import './base_model.dart';

class AuthProvider extends BaseModel {
  final Auth _authenticationService = locator<Auth>();

  String errorMessage;
  String uid;

  AuthStatus get authStatus => _authenticationService.status;
  User get user => _authenticationService.user;

  AuthProvider() {
    _authenticationService.notifyListeners = notifyListeners;
  }

  Future login(String email, String password) async {
    setState(ViewState.Busy);
    try {
      uid = await _authenticationService.signIn(email, password);
    } catch (e) {
      errorMessage = _getErrorMessage(e);
    } finally {
      setState(ViewState.Idle);
    }
  }

  String _getErrorMessage(e) {
    if (e.toString().contains('EMAIL_EXISTS')) {
      return 'This email address is already in use';
    } else if (e.toString().contains('INVALID_EMAIL')) {
      return 'This is not a valid email';
    } else if (e.toString().contains('EMAIL_NOT_FOUND')) {
      return 'Could not found user with that email';
    } else if (e.toString().contains('ERROR_WRONG_PASSWORD')) {
      return 'The password is incorrect';
    } else if (e.toString().contains('USER_NOT_FOUND')) {
      return 'The user doesn\'t exist in the system';
    } else {
      return 'Authentication failed';
    }
  }

  Future signUp(String email, String password) async {
    setState(ViewState.Busy);
    try {
      uid = await _authenticationService.signUp(email, password);
    } catch (e) {
      errorMessage = _getErrorMessage(e);
    } finally {
      setState(ViewState.Idle);
    }
  }

  Future<User> getCurrentUser() async {
    return await _authenticationService.getCurrentUser();
  }

  Future signOut() async {
    return await _authenticationService.signOut();
  }
}
