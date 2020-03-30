class BookSearchHotModel {
  List<String> hotWords;
  List<NewHotWords> newHotWords;
  bool ok;

  BookSearchHotModel({this.hotWords, this.newHotWords, this.ok});

  BookSearchHotModel.fromJson(Map<String, dynamic> json) {
    hotWords = json['hotWords'].cast<String>();
    if (json['newHotWords'] != null) {
      newHotWords = new List<NewHotWords>();
      json['newHotWords'].forEach((v) {
        newHotWords.add(new NewHotWords.fromJson(v));
      });
    }
    ok = json['ok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotWords'] = this.hotWords;
    if (this.newHotWords != null) {
      data['newHotWords'] = this.newHotWords.map((v) => v.toJson()).toList();
    }
    data['ok'] = this.ok;
    return data;
  }
}

class NewHotWords {
  String word;
  String book;

  NewHotWords({this.word, this.book});

  NewHotWords.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    book = json['book'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['word'] = this.word;
    data['book'] = this.book;
    return data;
  }
}
