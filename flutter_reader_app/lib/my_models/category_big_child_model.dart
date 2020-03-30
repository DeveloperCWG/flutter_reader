class CategoryBigAndChildModel {
  List<ChildCategoryTag> male;
  List<ChildCategoryTag> female;
  List<ChildCategoryTag> picture;
  List<ChildCategoryTag> press;
  bool ok;

  CategoryBigAndChildModel(
      {this.male, this.female, this.picture, this.press, this.ok});

  CategoryBigAndChildModel.fromJson(Map<String, dynamic> json) {
    if (json['male'] != null) {
      male = new List<ChildCategoryTag>();
      json['male'].forEach((v) {
        male.add(new ChildCategoryTag.fromJson(v));
      });
    }
    if (json['female'] != null) {
      female = new List<ChildCategoryTag>();
      json['female'].forEach((v) {
        female.add(new ChildCategoryTag.fromJson(v));
      });
    }
    if (json['picture'] != null) {
      picture = new List<ChildCategoryTag>();
      json['picture'].forEach((v) {
        picture.add(new ChildCategoryTag.fromJson(v));
      });
    }
    if (json['press'] != null) {
      press = new List<ChildCategoryTag>();
      json['press'].forEach((v) {
        press.add(new ChildCategoryTag.fromJson(v));
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

class ChildCategoryTag {
  String major;
  List<String> mins;

  ChildCategoryTag({this.major, this.mins});

  ChildCategoryTag.fromJson(Map<String, dynamic> json) {
    major = json['major'];
    mins = json['mins']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['major'] = this.major;
    data['mins'] = this.mins;
    return data;
  }
}

