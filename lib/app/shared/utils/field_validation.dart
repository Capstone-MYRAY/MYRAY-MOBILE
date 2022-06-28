import 'package:myray_mobile/app/data/models/garden/garden_models.dart';
import 'package:myray_mobile/app/shared/constants/app_msg.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class FieldValidation {
  FieldValidation._();
  static final FieldValidation _instance = FieldValidation._();
  static FieldValidation get instance => _instance;

  String? validateFullName(value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    if (!Utils.isAlphabet.hasMatch(value) ||
        value.length < 3 && value.length > 50) {
      return AppMsg.MSG6005;
    }

    return null;
  }

  String? validatePhone(value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    if (!Utils.vietnamesePhone.hasMatch(value)) {
      return AppMsg.MSG0003;
    }
    return null;
  }

  String? validateDob(value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    if (!Utils.isWorkingAge(value, 'dd/MM/yyyy')) {
      return AppMsg.MSG6007;
    }

    return null;
  }

  String? validatePassword(value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }
    return null;
  }

  String? validateProvince(value) {
    if (value == null) return AppMsg.MSG0002;
    if (Utils.isEmpty(value.value)) {
      return AppMsg.MSG0002;
    }
    return null;
  }

  String? validateDistrict(value) {
    if (value == null) return AppMsg.MSG0002;
    if (Utils.isEmpty(value.value)) {
      return AppMsg.MSG0002;
    }
    return null;
  }

  String? validateCommune(value) {
    if (value == null) return AppMsg.MSG0002;
    if (Utils.isEmpty(value.commune)) {
      return AppMsg.MSG0002;
    }
    return null;
  }

  String? validateAddress(value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }
    return null;
  }

  String? validateLandArea(value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    if (!Utils.isNumber.hasMatch(value)) {
      return AppMsg.MSG0005;
    }

    return null;
  }

  String? validateGardenName(value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }
    return null;
  }

  String? validateGardenSelection(Garden? garden) {
    if (garden == null) return AppMsg.MSG0002;
    return null;
  }
}
