class CountryStats {
  String? country;
  String? totalCases;
  String? newCases;
  String? totalDeaths;
  String? newDeaths;
  String? totalRecovered;
  String? activeCases;
  String? seriousCritical;
  String? totalCasessOr1MPop;
  String? deathsOr1MPop;
  String? firstCase;

  CountryStats(
      {this.country,
        this.totalCases,
        this.newCases,
        this.totalDeaths,
        this.newDeaths,
        this.totalRecovered,
        this.activeCases,
        this.seriousCritical,
        this.totalCasessOr1MPop,
        this.deathsOr1MPop,
        this.firstCase});

  CountryStats.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    totalCases = json['total_cases'];
    newCases = json['new_cases'];
    totalDeaths = json['total_deaths'];
    newDeaths = json['new_deaths'];
    totalRecovered = json['total_recovered'];
    activeCases = json['active_cases'];
    seriousCritical = json['serious_critical'];
    totalCasessOr1MPop = json['total_casess_or_1M_pop'];
    deathsOr1MPop = json['deaths_or_1M_pop'];
    firstCase = json['first_case'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['total_cases'] = this.totalCases;
    data['new_cases'] = this.newCases;
    data['total_deaths'] = this.totalDeaths;
    data['new_deaths'] = this.newDeaths;
    data['total_recovered'] = this.totalRecovered;
    data['active_cases'] = this.activeCases;
    data['serious_critical'] = this.seriousCritical;
    data['total_casess_or_1M_pop'] = this.totalCasessOr1MPop;
    data['deaths_or_1M_pop'] = this.deathsOr1MPop;
    data['first_case'] = this.firstCase;
    return data;
  }
}