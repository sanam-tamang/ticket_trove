class CustomValidator {
  static String? nullCheck(String fieldName, String? query) {
    if (query == null || query.isEmpty) {
      return "$fieldName can't be empty";
    } else {
      return null;
    }
  }

   static String? email(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email address';
    }
    // You can add more complex email validation logic here
    // For a simple check, you can use a regular expression
    bool validEmail =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    if (!validEmail) {
      return 'Please enter a valid email address';
    }
    return null; // Return null if the email is valid
  }

  static String? password(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }
    // You can define your own password criteria here
    // For example, you might want to enforce a minimum length
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null; // Return null if the password is valid
  }
}
