class CoronaNews {
  String? title;
  String? language;
  String? description;
  String? updateDT;
  String? image;
  String? source;
  String? date;

  CoronaNews(
      {this.title,
        this.language,
        this.description,
        this.updateDT,
        this.image,
        this.source,
        this.date});

  CoronaNews.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    language = json['language'];
    description = json['description'];
    updateDT = json['updateDT'];
    image = json['image'];
    source = json['source'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['language'] = this.language;
    data['description'] = this.description;
    data['updateDT'] = this.updateDT;
    data['image'] = this.image;
    data['source'] = this.source;
    data['date'] = this.date;
    return data;
  }
}