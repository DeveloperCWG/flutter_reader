class ReaderBookContentModel {
  String title;
  String content;
  String chapterNum;

  ReaderBookContentModel({
    this.content,
    this.title,
    this.chapterNum,
  });

  factory ReaderBookContentModel.fromJson(Map<String,String> json){
    return ReaderBookContentModel(
      title: json["title"],
      content: json["content"],
      chapterNum: json["chapterNum"],
    );
  }

  Map<String,String> toJson(){
    return {
      "title":this.title,
      "content":this.content,
      "chapterNum":this.chapterNum,
    };
  }
}