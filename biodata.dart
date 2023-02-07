
class biodata{
  late int? id;
  late String? name,email,gender,status;

  biodata({this.id, this.name, this.email, this.gender, this.status});

  factory biodata.forMap(Map<String,dynamic> v){
    return biodata(
        id :int.parse(v["id"].toString()),
        name :  v['name'].toString(),
        email : v['email'].toString(),
        gender : v['gender'].toString(),
        status : v['status'].toString(),
    );
  }
}

