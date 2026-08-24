class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String avatar;
  final String createdAt;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.avatar,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar,
      'createdAt': createdAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      avatar: map['avatar'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
}
