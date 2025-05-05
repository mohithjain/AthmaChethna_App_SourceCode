import '../services/mongodb_service.dart';

class SignupController {
  static Future<String?> signupUser(
    String name,
    String username,
    String password,
    String confirmPassword,
    int semester,
    String email,
    String department,
    String phone,
  ) async {
    if (password != confirmPassword) {
      return "Passwords do not match";
    }
    if (!RegExp(r"^[0-9]{10}$").hasMatch(phone)) {
      return "Invalid phone number";
    }
    if (!email.endsWith("@bmsce.ac.in")) {
      return "Invalid email domain";
    }

    final userData = {
      "name": name,
      "username": username,
      "password": password,
      "semester": semester,
      "email": email,
      "department": department,
      "phone": phone,
    };

    final response = await MongoDBService.signupUser(userData);
    if (response.containsKey("error")) {
      return response["error"];
    }
    return null; // Success
  }
}
