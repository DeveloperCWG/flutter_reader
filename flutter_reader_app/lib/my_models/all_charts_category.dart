class AllBooksChartsCategory {
  List<ChartsModel> female;
  List<ChartsModel> picture;
  List<ChartsModel> male;
  List<ChartsModel> epub;
  bool ok;

  AllBooksChartsCategory(
      {this.female, this.picture, this.male, this.epub, this.ok});

  AllBooksChartsCategory.fromJson(Map<String, dynamic> json) {
    if (json['female'] != null) {
      female = new List<ChartsModel>();
      json['female'].forEach((v) {
        female.add(new ChartsModel.fromJson(v));
      });
    }
    if (json['picture'] != null) {
      picture = new List<ChartsModel>();
      json['picture'].forEach((v) {
        picture.add(new ChartsModel.fromJson(v));
      });
    }
    if (json['male'] != null) {
      male = new List<ChartsModel>();
      json['male'].forEach((v) {
        male.add(new ChartsModel.fromJson(v));
      });
    }
    if (json['epub'] != null) {
      epub = new List<ChartsModel>();
      json['epub'].forEach((v) {
        epub.add(new ChartsModel.fromJson(v));
      });
    }
    ok = json['ok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.female != null) {
      data['female'] = this.female.map((v) => v.toJson()).toList();
    }
    if (this.picture != null) {
      data['picture'] = this.picture.map((v) => v.toJson()).toList();
    }
    if (this.male != null) {
      data['male'] = this.male.map((v) => v.toJson()).toList();
    }
    if (this.epub != null) {
      data['epub'] = this.epub.map((v) => v.toJson()).toList();
    }
    data['ok'] = this.ok;
    return data;
  }
}

class ChartsModel {
  String sId;
  String title;
  String cover;
  bool collapse;
  String monthRank;
  String totalRank;
  String shortTitle;

  ChartsModel(
      {this.sId,
      this.title,
      this.cover,
      this.collapse,
      this.monthRank,
      this.totalRank,
      this.shortTitle});

  ChartsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    cover = json['cover'];
    collapse = json['collapse'];
    monthRank = json['monthRank'];
    totalRank = json['totalRank'];
    shortTitle = json['shortTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['collapse'] = this.collapse;
    data['monthRank'] = this.monthRank;
    data['totalRank'] = this.totalRank;
    data['shortTitle'] = this.shortTitle;
    return data;
  }
}