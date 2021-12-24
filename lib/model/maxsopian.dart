class MaxsopianFields {
  static final String id = 'id';
  static final String name = 'name';
  static final String email = 'email';
  static final String mobile = 'mobile';
  static final String isIntern = 'isIntern';

  static List<String> getFields() => [id, name, email, mobile, isIntern];
}

class Maxsopian {
  final int? id;
  final String name;
  final String email;
  final String mobile;
  final bool isIntern;

  const Maxsopian({
    this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.isIntern,
  });

  Maxsopian copy({
    int? id,
    String? name,
    String? email,
    String? mobile,
    bool? isIntern,
  }) => Maxsopian(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      isIntern: isIntern ?? this.isIntern
  );

  Map<String, dynamic> toJson() => {
    MaxsopianFields.id: id,
    MaxsopianFields.name: name,
    MaxsopianFields.email: email,
    MaxsopianFields.mobile: mobile,
    MaxsopianFields.isIntern: isIntern,
  };

}