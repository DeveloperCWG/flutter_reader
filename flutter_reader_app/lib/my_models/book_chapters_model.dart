class BookChapters {
  MixToc mixToc;
  bool ok;

  BookChapters({this.mixToc, this.ok});

  BookChapters.fromJson(Map<String, dynamic> json) {
    mixToc =
        json['mixToc'] != null ? new MixToc.fromJson(json['mixToc']) : null;
    ok = json['ok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mixToc != null) {
      data['mixToc'] = this.mixToc.toJson();
    }
    data['ok'] = this.ok;
    return data;
  }
}

class MixToc {
  String sId;
  int chaptersCount1;
  String book;
  String chaptersUpdated;
  List<Chapters> chapters;
  String updated;

  MixToc(
      {this.sId,
      this.chaptersCount1,
      this.book,
      this.chaptersUpdated,
      this.chapters,
      this.updated});

  MixToc.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    chaptersCount1 = json['chaptersCount1'];
    book = json['book'];
    chaptersUpdated = json['chaptersUpdated'];
    if (json['chapters'] != null) {
      chapters = new List<Chapters>();
      json['chapters'].forEach((v) {
        chapters.add(new Chapters.fromJson(v));
      });
    }
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['chaptersCount1'] = this.chaptersCount1;
    data['book'] = this.book;
    data['chaptersUpdated'] = this.chaptersUpdated;
    if (this.chapters != null) {
      data['chapters'] = this.chapters.map((v) => v.toJson()).toList();
    }
    data['updated'] = this.updated;
    return data;
  }
}

class Chapters {
  String title;
  String link;
  bool unreadble;

  Chapters({this.title, this.link, this.unreadble});

  Chapters.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    unreadble = json['unreadble'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['link'] = this.link;
    data['unreadble'] = this.unreadble;
    return data;
  }
}
