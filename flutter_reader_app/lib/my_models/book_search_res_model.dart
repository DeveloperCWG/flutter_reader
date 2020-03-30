import 'all_books_charts_model.dart';
class BookSearchInfo {
  List<Book> books;
  int total;
  bool ok;

  BookSearchInfo({this.books, this.total, this.ok});

  BookSearchInfo.fromJson(Map<String, dynamic> json) {
    if (json['books'] != null) {
      books = new List<Book>();
      json['books'].forEach((v) {
        books.add(new Book.fromJson(v));
      });
    }
    total = json['total'];
    ok = json['ok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.books != null) {
      data['books'] = this.books.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['ok'] = this.ok;
    return data;
  }
}
