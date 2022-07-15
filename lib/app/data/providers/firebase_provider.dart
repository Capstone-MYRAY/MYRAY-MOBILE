import 'package:firebase_auth/firebase_auth.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class FirebaseProvider {
  String verificationId = '';
  PhoneAuthCredential? phoneAuthCredential;
  UserCredential? user;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseProvider._();
  static final FirebaseProvider _instance = FirebaseProvider._();
  static FirebaseProvider get instance => _instance;

  Future<void> fetchOtp({
    required String phoneNumber,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          throw Exception('Invalid phone number');
        }
        print(e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(seconds: CommonConstants.otpTimer),
    );
  }

  Future<void> verify({required String otp}) async {
    try {
      phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      user = await _firebaseAuth.signInWithCredential(phoneAuthCredential!);
    } on Exception catch (e) {
      if (e.toString().contains('invalid-verification-code')) {
        throw Exception('Wrong OTP');
      }
    }
  }
}
