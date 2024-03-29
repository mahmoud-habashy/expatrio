import 'package:coding_challenge/shared/app_strings.dart';
import 'package:coding_challenge/data/models/item_dropdown.dart';

RegExp _emailReq = RegExp(
    r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
RegExp _passwordReq = RegExp(r"^.{6,100}$");

class AppValidators {
  static String? isValidEmail(String? email) {
    email = email?.trim().toLowerCase();
    if (email == null || email.isEmpty) {
      return AppStrings.emailRequired;
    } else if (!_emailReq.hasMatch(email)) {
      return AppStrings.emailNotValid;
    }
    return null;
  }

  static String? isValidPassword(String? password) {
    password = password?.trim();
    if (password == null || password.isEmpty) {
      return AppStrings.passwordRequired;
    } else if (!_passwordReq.hasMatch(password)) {
      return AppStrings.passwordNotValid;
    }
    return null;
  }

  static String? isValidTaxId(String? taxId) {
    // TODO(Mahmoud) RegExp for validating the tax id if any.
    taxId = taxId?.trim();
    if (taxId == null || taxId.isEmpty) {
      return AppStrings.taxIdRequired;
    } else if (taxId.length < 2) {
      return AppStrings.taxIdNotValid;
    }
    return null;
  }

  static String? isValidCountry(ItemDropDown? itemDropDown) {
    if (itemDropDown == null) {
      return AppStrings.countryRequired;
    }
    return null;
  }
}
