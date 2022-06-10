part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const login = _Paths.login;
  static const chooseRole = _Paths.chooseRole;
  static const forgotPassword = _Paths.forgotPassword;
  static const signup = _Paths.signup;
  static const enterOtp = _Paths.enterOtp;
  static const resetPassword = _Paths.resetPassword;
  static const home = _Paths.home;
}

abstract class _Paths {
  static const login = '/login';
  static const chooseRole = '/choose_role';
  static const forgotPassword = '/forgot_password';
  static const signup = '/signup';
  static const enterOtp = '/enter_otp';
  static const resetPassword = '/reset_password';
  static const home = '/home';
}
