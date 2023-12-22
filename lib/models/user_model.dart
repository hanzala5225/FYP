class UserModel {
  final String uid;
  final String name;
  final String email;
  final DateTime createdAt;

//<editor-fold desc="Data Methods">
  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          name == other.name &&
          email == other.email &&
          createdAt == other.createdAt
      );

  @override
  int get hashCode =>
      uid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      createdAt.hashCode;

  @override
  String toString() {
    return 'UserModel{' +
        ' uid: $uid,' +
        ' name: $name,' +
        ' email: $email,' +
        ' createdAt: $createdAt,' +
        '}';
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'name': this.name,
      'email': this.email,
      'createdAt':  this.createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

}
