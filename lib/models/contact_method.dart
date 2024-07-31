class ContactMethod {
  String contactMethod;
  String value;

  ContactMethod({required this.contactMethod, required this.value});

  factory ContactMethod.fromJson(Map<String, dynamic> json) {
    return ContactMethod(
      contactMethod: json['contactMethod'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contactMethod': contactMethod,
      'value': value,
    };
  }
}
