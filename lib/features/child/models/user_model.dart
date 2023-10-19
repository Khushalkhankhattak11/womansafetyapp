class UserModel{

  String? name;
  String? phone;
  String? childEmail;
  String? parentEmail;
  String? id;


  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.childEmail,
    required this.parentEmail,
});

  Map<String,dynamic>  toJson()=>
      {
        'name': name,
        'phone': phone,
        'childEmail': childEmail,
        "parentEmail": parentEmail,
        'id': id,

      };
}