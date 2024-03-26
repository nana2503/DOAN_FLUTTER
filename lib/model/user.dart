class User {
  final String userId;
  final String username;
  final String address;
  final String sex;
  final String phone;
  final String className;

  User({
    required this.userId,
    required this.username,
    required this.address,
    required this.sex,
    required this.phone,
    required this.className,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      username: json['username'],
      address: json['address'] ?? 'Chưa cập nhật',
      sex: json['sex'] ?? 'Chưa cập nhật',
      phone: json['phone'],
      className: json['Class']['className'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'address': address,
      'sex': sex,
      'phone': phone,
      'classId': className,
    };
  }

  @override
  String toString() {
    return "MSSV: " +
        this.userId +
        "\nHọ và tên: " +
        this.username +
        "\nĐịa chỉ: " +
        this.address +
        "\nGiới tính: " +
        this.sex +
        "\nSố điện thoại: " +
        this.phone;
  }
}
