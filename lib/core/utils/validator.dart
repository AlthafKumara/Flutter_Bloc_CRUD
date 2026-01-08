class Validator {
  String? validatorTitle(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your Title";
    }
    return null;
  }

  String? validatorSynopsis(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your synopsis";
    }
    return null;
  }

  String? validatorAuthor(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your author  ";
    }
    return null;
  }

  String? validatorEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    } else if (!value.contains("@")) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? validatorPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }
}
