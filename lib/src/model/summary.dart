class Summary {
  String? coronaviruscases;
  String? deathcoronaviruscases;
  String? recoverdcoronaviruscases;

  Summary(
      {this.coronaviruscases,
      this.deathcoronaviruscases,
      this.recoverdcoronaviruscases});

  Summary.fromJson(Map<String, dynamic> json) {
    coronaviruscases = json['coronaviruscases'];
    deathcoronaviruscases = json['deathcoronaviruscases'];
    recoverdcoronaviruscases = json['recoverdcoronaviruscases'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coronaviruscases'] = this.coronaviruscases;
    data['deathcoronaviruscases'] = this.deathcoronaviruscases;
    data['recoverdcoronaviruscases'] = this.recoverdcoronaviruscases;
    return data;
  }
}
