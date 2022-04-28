
final String tableUser = 'user';

class UserFields{
  static final List<String> values = [
    id, email, login, password, floors
  ];

  static final String id = 'id';
  static final String email = 'email';
  static final String login = 'login';
  static final String password = 'password';
  static final String floors = 'floors';
}

class User{
  final int? id;
  final String email;
  final String login;
  final String password;
  final int floors;

  const User({
    this.id,
    required this.email,
    required this.login,
    required this.password,
    required this.floors,
});

  User copy({
    int? id,
    String? email,
    String? login,
    String? password,
    int? floors,
  }) =>
    User(
     id:id ?? this.id,
      email: email ?? this.email,
      login: login ?? this.login,
      password: password ?? this.password,
      floors: floors ?? this.floors,
    );

static User fromJson(Map<String,Object?> json) => User(
  id: json[UserFields.id] as int?,
  email: json[UserFields.email] as String,
  login: json[UserFields.login] as String,
  password: json[UserFields.password] as String,
  floors: json[UserFields.floors] as int,
);

  Map<String, Object?> toJson() => {
    UserFields.id: id,
    UserFields.email: email,
    UserFields.login: login,
    UserFields.password: password,
    UserFields.floors: floors,
  };
}