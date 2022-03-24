class Employee {
  String? profile_pic;
  int? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? role;
  String? managerid;
  String? status;
  int? darkTheme;
  Employee(
      {this.profile_pic,
      this.id,
      this.name,
      this.email,
      this.phone,
      this.password,
      this.role,
      this.managerid,
      this.status,
      this.darkTheme});

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
        profile_pic: json['profile_pic'],
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        password: json['password'],
        role: json['role'],
        managerid: json['managerid'],
        status: json['status'],
        darkTheme: json['darkTheme'],
      );
  Map<String, dynamic> toMap() {
    return {
      'profile_pic': profile_pic,
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
      'managerid': managerid,
      'status': status,
      'darkTheme': darkTheme
    };
  }
}
