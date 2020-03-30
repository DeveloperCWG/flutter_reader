class AllBooksCategory {
  List<ChildCategory> male;
  List<ChildCategory> female;
  List<ChildCategory> picture;
  List<ChildCategory> press;
  bool ok;

  AllBooksCategory({this.male, this.female, this.picture, this.press, this.ok});

  AllBooksCategory.fromJson(Map<String, dynamic> json) {
    if (json['male'] != null) {
      male = new List<ChildCategory>();
      json['male'].forEach((v) {
        male.add(new ChildCategory.fromJson(v));
      });
    }
    if (json['female'] != null) {
      female = new List<ChildCategory>();
      json['female'].forEach((v) {
        female.add(new ChildCategory.fromJson(v));
      });
    }
    if (json['picture'] != null) {
      picture = new List<ChildCategory>();
      json['picture'].forEach((v) {
        picture.add(new ChildCategory.fromJson(v));
      });
    }
    if (json['press'] != null) {
      press = new List<ChildCategory>();
      json['press'].forEach((v) {
        press.add(new ChildCategory.fromJson(v));
      });
    }
    ok = json['ok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.male != null) {
      data['male'] = this.male.map((v) => v.toJson()).toList();
    }
    if (this.female != null) {
      data['female'] = this.female.map((v) => v.toJson()).toList();
    }
    if (this.picture != null) {
      data['picture'] = this.picture.map((v) => v.toJson()).toList();
    }
    if (this.press != null) {
      data['press'] = this.press.map((v) => v.toJson()).toList();
    }
    data['ok'] = this.ok;
    return data;
  }
}

class ChildCategory {
  String name;
  int bookCount;
  int monthlyCount;
  String icon;
  List<String> bookCover;

  ChildCategory(
      {this.name,
      this.bookCount,
      this.monthlyCount,
      this.icon,
      this.bookCover});

  ChildCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bookCount = json['bookCount'];
    monthlyCount = json['monthlyCount'];
    icon = json['icon'];
    bookCover = json['bookCover'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['bookCount'] = this.bookCount;
    data['monthlyCount'] = this.monthlyCount;
    data['icon'] = this.icon;
    data['bookCover'] = this.bookCover;
    return data;
  }
}
