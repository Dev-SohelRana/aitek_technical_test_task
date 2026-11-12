class ProfileModel {
  final String login;
  final String name;
  final String? phone;
  final String accountType;
  final String status;

  static const fallback = ProfileModel(
    login: '-',
    name: '-',
    phone: null,
    accountType: '-',
    status: '-',
  );

  const ProfileModel({
    required this.login,
    required this.name,
    required this.phone,
    required this.accountType,
    required this.status,
  });

  factory ProfileModel.fromJson({
    required Map<String, dynamic> json,
    required String login,
    required String? phone,
  }) {
    return ProfileModel(
      login: _displayValue(login, fallback: fallback.login),
      name: _displayValue(json['name'], fallback: fallback.name),
      phone: _optionalDisplayValue(phone),
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

  static String? _optionalDisplayValue(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return value;
  }
}
