class ContactModels {
  int? _id;
  String? _number;
  String? _name;

  ContactModels(this._name, this._number);

  ContactModels.withId(this._id, this._number, this._name);

  //// geter out of class me make it getter
  int get id => _id!;
  String get number => _number!;
  String get name => _name!;

  @override
  String toString() {
    return 'Contact: {id: $_id, name:$_name, number: $_number}';
  }

  //// setters when we call id setter call auto
  set number(String newNumber) => this._number = newNumber;
  set name(String newName) => this._name = newName;

  /// convert contact  object to map oject

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['id'] = this._id;
    map['number'] = this._number;
    map['name'] = this._name;

    return map;
  }

  /// extract contact object to map object
 ContactModels.fromMapObject(Map<String,dynamic> map){
    this._id =map['id'];
    this._name =map['name'];
    this._number = map['number'];
 }
}
