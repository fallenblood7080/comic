class ComicDataModel {
  int? num;
  String? day;
  String? month;
  String? year;
  String? alt;
  String? img;
  String? title;

  ComicDataModel(
      {this.num,
      this.day,
      this.month,
      this.year,
      this.alt,
      this.img,
      this.title});

  ComicDataModel.fromJson(Map<dynamic, dynamic> json) {
    num = json['num'];
    day = json['day'];
    month = json['month'];
    year = json['year'];
    alt = json['alt'];
    img = json['img'];
    title = json['title'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['num'] = num;
    data['day'] = day;
    data['month'] = month;
    data['year'] = year;
    data['alt'] = alt;
    data['img'] = img;
    data['title'] = title;
    return data;
  }
}
