import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regexed_validator/regexed_validator.dart';

import 'Colors.dart';

class Fieldvalidator {
  static String? validatename(String? value) {
    if (value == null) {
      return null;
    } else {
      if (value!.length == 0) {
        return "Name is Required";
      } else if (!validator.name(value)) {
        return "Must be a valid name";
      }
    }
  }

  static String? validateemail(String? value) {
    if (value == null) {
      return null;
    } else {
      if (value!.length == 0) {
        return "Email is Required";
      } else if (!validator.email(value)) {
        return "Must be a valid email address";
      }
    }
  }

  static String? validatepassword(String? value) {
    if (value == null) {
      return null;
    } else {
      if (value!.length == 0) {
        return "password is Required";
      } else if (!validator.password(value)) {
        return "Must be a valid password";
      }
    }
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null) {
      return null;
    } else {
      if (value!.length == 0) {
        return "Phone number is Required";
      } else if (!validator.phone(value)) {
        return "Must be a valid phone number";
      }
    }
  }

  static String? validatePinCode(String? value) {
    if (value == null) {
      return null;
    } else {
      if (value!.length == 0) {
        return "Code pin is Required";
      } else if (!isPin(value)) {
        return "Must be a valid pin code";
      }
    }
  }

  static String? validateisbn(String? value) {
    if (value == null) {
      return null;
    } else {
      if (value!.length == 0) {
        return "isbn is Required";
      } else if (!isIsbnValid(value)) {
        return "Must be a valid isbn";
      }
    }
  }

  static String? validateLibname(String? value) {
    if (value == null) {
      return null;
    } else {
      if (value!.length == 0) {
        return "Name is Required";
      }
    }
  }

  static bool isPin(String em) {
    String p = r'^[1-9][0-9]{5}$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  static bool isIsbnValid(String em) {
  String pattern = r'^[0-9]{10}$|^[0-9]{13}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(em);
}
}
