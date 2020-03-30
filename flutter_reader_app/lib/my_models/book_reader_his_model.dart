class ReaderHisModel {
  String sId;
  String cover;
  String name;
  String author;
  String lastReaderTime;
  String lastChapter;
  double rate;

  ReaderHisModel({
    this.sId,
    this.cover,
    this.name,
    this.author,
    this.lastReaderTime,
    this.lastChapter,
    this.rate,
  });

  factory ReaderHisModel.fromJson(Map<String, dynamic> json){
    return ReaderHisModel(
      sId : json["sId"],
      cover : json["cover"],
      name :json["name"],
      author :json["author"],
      lastReaderTime :json["lastReaderTime"],
      lastChapter :json["lastChapter"],
      rate :json["rate"],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "sId" : this.sId,
      "cover" : this.cover,
      "name" : this.name,
      "author" :this.author,
      "lastReaderTime" : this.lastReaderTime,
      "lastChapter" : this.lastChapter,
      "rate" :this.rate,
    };
  }
}