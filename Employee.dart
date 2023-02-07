class Album
{
  late int userId,id;
  late String title;

  Album(this.userId,this.id,this.title);

  Album.fromMap(Map<String,dynamic> d)
  {
    userId = d["userId"];
    id = d["id"];
    title = d["title"];
  }
}

