part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const onboard = _Paths.onboard;
  static const login = _Paths.login;
  static const chooseRole = _Paths.chooseRole;
  static const forgotPassword = _Paths.forgotPassword;
  static const signup = _Paths.signup;
  static const enterOtp = _Paths.enterOtp;
  static const resetPassword = _Paths.resetPassword;
  static const enterPassword = _Paths.enterPassword;
  static const landownerDashboard = _Paths.landownerDashboard;
  static const farmerDashboard = _Paths.farmerDashboard;
}

abstract class _Paths {
  static const _landowner = '/landowner';
  static const _farmer = '/farmer';

  static const onboard = '/onboard';
  static const login = '/login';
  static const chooseRole = '/choose_role';
  static const forgotPassword = '/forgot_password';
  static const signup = '/signup';
  static const enterOtp = '/enter_otp';
  static const resetPassword = '/reset_password';
  static const enterPassword = '/enter_password';

  //Landowner views
  static const landownerDashboard = '$_landowner/dashboard';

  //farmer views
  static const farmerDashboard = '$_farmer/dashboard';
}
