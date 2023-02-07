class dataseries {
  late int timepoint,
      cloudcover,
      seeing,
      transparency,
      lifted_index,
      rh2m,
      temp2m;
  late String prec_type;
  wind10m? wind;

  dataseries({
    this.wind,
    required this.timepoint,
    required this.cloudcover,
    required this.seeing,
    required this.transparency,
    required this.lifted_index,
    required this.rh2m,
    required this.temp2m,
    required this.prec_type});

  factory dataseries.formap(Map<String, dynamic> D){
    return dataseries(
      wind: wind10m.frommap(D['win']),
        timepoint: int.parse(D['timepoint'].toString()),
        cloudcover: int.parse(D['cloudcover'].toString()),
        seeing: int.parse(D['seeing'].toString()),
        transparency: int.parse(D['transparency'].toString()),
        lifted_index: int.parse(D['lifted_index'].toString()),
        rh2m: int.parse(D['rh2m'].toString()),
        temp2m: int.parse(D['temp2m'].toString()),
        prec_type: D['prec_type'].toString());
  }

}

class wind10m{
  late String direction;
  late int speed;
  wind10m({required this.direction,required this.speed});

  factory wind10m.frommap(Map<String,dynamic>w){
    return wind10m(direction: w['direction'].toString(), speed: int.parse(w['speed'].toString()));
  }
}
