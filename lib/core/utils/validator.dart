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
}
