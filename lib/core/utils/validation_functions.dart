extension ValidString on String? {
  String? isValid() {
    if (this == null || this!.isEmpty) {
      return "Field is mandatory";
    } else {
      return null;
    }
  }
}