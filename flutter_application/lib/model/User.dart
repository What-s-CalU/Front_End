class User {
  int? id;
  String? name;
  String? checksum;

  User({required this.id, required this.name, required this.checksum});

  int get getId => id!;
  String get getName => name!;
  String get getChecsum => checksum!;

  set setId(int newId) => id = newId;
  set setName(String newName) => name = newName;
  set setChecksum(String newChecksum) => checksum = newChecksum;

  void setnull(){
    id = null;
    name = null;
    checksum = null;
  }
}