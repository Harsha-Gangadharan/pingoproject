class UserModel{
  String name;
  String occupation;
  int age;
  String email;
  String? id;
  UserModel(
    {required this.name,
    required this.age,
    required this.email,
    required this.occupation,
});
Map<String,dynamic>data(docId)=>
{'name':name,'age':age,'occupation':occupation,'email':email,'id':docId};
factory UserModel.fromData(Map<String,dynamic>i){
  return UserModel(
    name: i['name'], 
    age: i['age'], 
    email: i['email'], 
    occupation: i['occupation']);
}
}