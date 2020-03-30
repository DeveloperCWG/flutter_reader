import 'package:flutter_reader_app/my_models/all_books_charts_model.dart';

class ChildCategoryAllBooksModel {
  int total;
  List<Book> books;
  bool ok;

  ChildCategoryAllBooksModel({this.total, this.books, this.ok});

  ChildCategoryAllBooksModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['books'] != null) {
      books = new List<Book>();
      json['books'].forEach((v) {
        books.add(new Book.fromJson(v));
      });
    }
    ok = json['ok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.books != null) {
      data['books'] = this.books.map((v) => v.toJson()).toList();
    }
    data['ok'] = this.ok;
    return data;
  }
}