import 'dart:convert';

class AllBooksChartsModel {
	Ranking ranking;
	bool ok;

	AllBooksChartsModel({this.ranking, this.ok});

	AllBooksChartsModel.fromJson(Map<String, dynamic> json) {
		ranking = json['ranking'] != null ? new Ranking.fromJson(json['ranking']) : null;
		ok = json['ok'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.ranking != null) {
      data['ranking'] = this.ranking.toJson();
    }
		data['ok'] = this.ok;
		return data;
	}
}

class Ranking {
	String sId;
	String updated;
	String title;
	String tag;
	String cover;
	String icon;
	int iV;
	String monthRank;
	String totalRank;
	String shortTitle;
	String created;
	String biTag;
	bool isSub;
	bool collapse;
	bool isNew;
	String gender;
	int priority;
	List<Book> books;
	String id;
	int total;

	Ranking({this.sId, this.updated, this.title, this.tag, this.cover, this.icon, this.iV, this.monthRank, this.totalRank, this.shortTitle, this.created, this.biTag, this.isSub, this.collapse, this.isNew, this.gender, this.priority, this.books, this.id, this.total});

	Ranking.fromJson(Map<String, dynamic> json) {
		sId = json['_id'];
		updated = json['updated'];
		title = json['title'];
		tag = json['tag'];
		cover = json['cover'];
		icon = json['icon'];
		iV = json['__v'];
		monthRank = json['monthRank'];
		totalRank = json['totalRank'];
		shortTitle = json['shortTitle'];
		created = json['created'];
		biTag = json['biTag'];
		isSub = json['isSub'];
		collapse = json['collapse'];
		isNew = json['new'];
		gender = json['gender'];
		priority = json['priority'];
		if (json['books'] != null) {
			books = new List<Book>();
			json['books'].forEach((v) { books.add(new Book.fromJson(v)); });
		}
		id = json['id'];
		total = json['total'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['_id'] = this.sId;
		data['updated'] = this.updated;
		data['title'] = this.title;
		data['tag'] = this.tag;
		data['cover'] = this.cover;
		data['icon'] = this.icon;
		data['__v'] = this.iV;
		data['monthRank'] = this.monthRank;
		data['totalRank'] = this.totalRank;
		data['shortTitle'] = this.shortTitle;
		data['created'] = this.created;
		data['biTag'] = this.biTag;
		data['isSub'] = this.isSub;
		data['collapse'] = this.collapse;
		data['new'] = this.isNew;
		data['gender'] = this.gender;
		data['priority'] = this.priority;
		if (this.books != null) {
      data['books'] = this.books.map((v) => v.toJson()).toList();
    }
		data['id'] = this.id;
		data['total'] = this.total;
		return data;
	}
}


class Book {
	String sId;
	String cover;
	String site;
	String majorCate;
	String author;
	String minorCate;
	String title;
	String shortIntro;
	bool allowMonthly;
	int banned;
	int latelyFollower;
	String retentionRatio;
  
  bool hasCp;
  String aliases;
  String cat;
  String lastChapter;
  int wordCount;
  String contentType;
  String superscript;
  int sizetype;
  Map highlight;

  List<dynamic> tags;

	Book({
    this.sId, 
    this.cover, 
    this.site, 
    this.majorCate, 
    this.author, 
    this.minorCate, 
    this.title, 
    this.shortIntro, 
    this.allowMonthly, 
    this.banned, 
    this.latelyFollower, 
    this.retentionRatio,
    this.hasCp,
    this.aliases,
    this.cat,
    this.lastChapter,
    this.wordCount,
    this.contentType,
    this.superscript,
    this.sizetype,
    this.highlight,
    this.tags,
  });

	Book.fromJson(Map<String, dynamic> json) {
		sId = json['_id'];
		cover = json['cover'];
		site = json['site'];
		majorCate = json['majorCate'];
		author = json['author'];
		minorCate = json['minorCate'];
		title = json['title'];
		shortIntro = json['shortIntro'];
		allowMonthly = json['allowMonthly'];
		banned = json['banned'];
		latelyFollower = json['latelyFollower'];
		retentionRatio = json['retentionRatio'].toString();
    hasCp = json["hasCp"];
    aliases = json['aliases'];
    cat = json["cat"];
    lastChapter = json["lastChapter"];
    wordCount = json["wordCount"];
    contentType = json["contentType"];
    superscript = json["superscript"];
    sizetype = json["sizetype"];
    highlight = json["highlight"];
    tags = json["tags"];

	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['_id'] = this.sId;
		data['cover'] = this.cover;
		data['site'] = this.site;
		data['majorCate'] = this.majorCate;
		data['author'] = this.author;
		data['minorCate'] = this.minorCate;
		data['title'] = this.title;
		data['shortIntro'] = this.shortIntro;
		data['allowMonthly'] = this.allowMonthly;
		data['banned'] = this.banned;
		data['latelyFollower'] = this.latelyFollower;
		data['retentionRatio'] = this.retentionRatio;
    data["hasCp"] = this.hasCp;
    data['aliases'] = this.aliases;
    data["cat"] = this.cat;
    data["lastChapter"] = this.lastChapter;
    data["wordCount"] = this.wordCount;
    data["contentType"] = this.contentType;
    data["superscript"] = this.superscript;
    data["sizetype"] = this.sizetype;
    data["highlight"] = this.highlight;
    data["tags"] = this.tags;

		return data;
	}
}
