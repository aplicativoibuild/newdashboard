class Agent {
  String agentUid = "";
  String email = "";
  String name = "";
  String phone = "";
  String role = "";

  bool isActive = false;
  DateTime registerDate = DateTime.now();

  Agent.fromJson(Map<String, dynamic> json) {
    agentUid = json['agenUid'] ?? "";
    email = json['email'] ?? "";
    name = json['name'] ?? "";
    phone = json['phone'] ?? "";
    role = json['role'] ?? "";
    isActive = json['isActive'] ?? false;

    registerDate = json['register_date']?.toDate() ?? DateTime.now();
  }

  Map<String, dynamic> toJson() {
    return {
      'agendUid': agentUid,
      'email': email,
      'name': name,
      'phone': phone,
      'role': role,
      'isActive': isActive,
      'register_date': registerDate,
    };
  }
}
