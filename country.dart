class universitty {
  late String? alpha_two_code,
      name,
      web_pages,
      state_province,
      domains,
      country;

  universitty(
      {this.alpha_two_code,
      this.name,
      this.web_pages,
      this.state_province,
      this.domains,
      this.country});

  factory universitty.forMap(Map<String, dynamic> v) {
    return universitty(
        alpha_two_code: v["alpha_two_code"].toString(),
        name: v['name'].toString(),
        web_pages: v['web_pages'].toString(),
        state_province: v['state_province'].toString(),
        domains: v['domains'].toString(),
        country: v['country'].toString());
  }
}
