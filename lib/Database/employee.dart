class Employee {
  String? profile_pic;
  int? id;
  String? name;
  String? email;
  String? password;
  String? role;
  String? status;
  Employee(
      {this.profile_pic,
      this.id,
      this.name,
      this.email,
      this.password,
      this.role,
      this.status});

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
      profile_pic: json['profile_pic'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      status: json['status']);
  Map<String, dynamic> toMap() {
    return {
      'profile_pic': profile_pic,
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'status': status
    };
  }
}
