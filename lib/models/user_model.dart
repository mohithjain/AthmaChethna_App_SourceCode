class User {
  String name;
  String username;
  String password;
  int semester;
  String email;
  String department;
  String phone;

  User({
    required this.name,
    required this.username,
    required this.password,
    required this.semester,
    required this.email,
    required this.department,
    required this.phone,
  });

  // Convert a User object to a Map (for sending to MongoDB)
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "username": username,
      "password": password,
      "semester": semester,
      "email": email,
      "department": department,
      "phone": phone,
    };
  }

  // Create a User object from a Map (for fetching from MongoDB)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"],
      username: json["username"],
      password: json["password"],
      semester: json["semester"],
      email: json["email"],
      department: json["department"],
      phone: json["phone"],
    );
  }
}
