part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const init = _Paths.init;
  static const login = _Paths.login;
  static const chooseRole = _Paths.chooseRole;
  static const forgotPassword = _Paths.forgotPassword;
  static const signup = _Paths.signup;
  static const enterOtp = _Paths.enterOtp;
  static const resetPassword = _Paths.resetPassword;
  static const enterPassword = _Paths.enterPassword;

  //landowner
  static const landownerDashboard = _Paths.landownerDashboard;
  static const landownerProfile = _Paths.landownerProfile;
  static const gardenHome = _Paths.gardenHome;
  static const gardenForm = _Paths.gardenForm;

  //farmer
  static const farmerDashboard = _Paths.farmerDashboard;
  static const farmerProfile = _Paths.farmerProfile;
}

abstract class _Paths {
  static const _landowner = '/landowner';
  static const _farmer = '/farmer';

  static const init = '/init';
  static const login = '/login';
  static const chooseRole = '/choose_role';
  static const forgotPassword = '/forgot_password';
  static const signup = '/signup';
  static const enterOtp = '/enter_otp';
  static const resetPassword = '/reset_password';
  static const enterPassword = '/enter_password';

  //Landowner views
  static const landownerDashboard = '$_landowner/dashboard';
  static const landownerProfile = '$_landowner/profile';
  static const gardenHome = '$_landowner/garden_home';
  static const gardenForm = '$_landowner/garden_form';

  //farmer views
  static const farmerDashboard = '$_farmer/dashboard';
  static const farmerProfile = '$_farmer/profile';
}
