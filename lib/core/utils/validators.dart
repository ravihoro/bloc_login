String? isValidEmail(String? email) {
  if (email == null) return "Enter Email";
  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

  return emailRegex.hasMatch(email) ? null : "Invalid Email";
}

String? isValidPassword(String? password) {
  if (password == null || password.isEmpty)
    return "Enter Password";
  else if (password.length < 6)
    return "Password should be at least 6 characters long";
  return null;
}

String? isValidName(String? name) {
  if (name == null || name.isEmpty) return "Enter Name";
  return null;
}
