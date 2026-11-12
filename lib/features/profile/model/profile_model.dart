class ProfileModel {
  final String login;
  final String name;
  final String email;
  final String phone;
  final String accountType;
  final String status;

  static const fallback = ProfileModel(
    login: '20234561',
    name: 'Sohel Rana',
    email: 'sohel@example.com',
    phone: '+880 1XXX-XXXXXX',
    accountType: 'Trading Account',
    status: 'Active',
  );

  const ProfileModel({
    required this.login,
    required this.name,
    required this.email,
    required this.phone,
    required this.accountType,
    required this.status,
  });

  factory ProfileModel.fromJson({
    required Map<String, dynamic> json,
    required String login,
    required String phone,
  }) {
    return ProfileModel(
      login: _displayValue(login, fallback: fallback.login),
      name: _displayValue(json['name'], fallback: fallback.name),
      email: _displayValue(json['email'], fallback: fallback.email),
      phone: _displayValue(phone, fallback: fallback.phone),
      accountType: _displayValue(json['type'], fallback: fallback.accountType),
      status: _displayValue(json['status'], fallback: fallback.status),
    );
  }

  static String _displayValue(dynamic value, {required String fallback}) {
    if (value == null || value.toString().trim().isEmpty) {
      return fallback;
    }
    return value.toString();
  }
}
