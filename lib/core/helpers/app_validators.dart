class AppValidators {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }


static String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'Please enter your password';
  }
  return null;
}


static String? validatePhone(String value) {
  if (value.isEmpty) {
    return 'Please enter your phone number';
  }
  
  // if (!RegExp(r'^01[0,1,2,5]{1}[0-9]{8}$').hasMatch(value)) {
  //   return 'Please enter a valid Egyptian phone number';
  // }
  return null;
}



static String? validateName(String value) {
  if (value.isEmpty) {
    return 'Please enter your name';
  }
  return null;
}


}
