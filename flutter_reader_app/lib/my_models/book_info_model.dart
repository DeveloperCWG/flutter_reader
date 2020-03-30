class BookInfo {
  Rating rating;
  List<String> tags;
  List<String> gender;
  String lastChapter;
  int chaptersCount;
  bool isSerial;
  String retentionRatio;
  int serializeWordCount;
  int wordCount;
  int followerCount;
  int latelyFollower;
  int totalFollower;
  int postCount;
  int banned;
  bool hasCp;
  bool allowBeanVoucher;
  bool allowVoucher;
  bool allowMonthly;
  bool bLe;
  String contentType;
  int currency;
  String superscript;
  int sizetype;
  int buytype;
  bool hasCopyright;
  String authorDesc;
  String originalAuthor;
  bool allowFree;
  int safelevel;
  bool isFineBook;
  int contentLevel;
  bool isMakeMoneyLimit;
  int starRatingCount;
  String sId;
  String longIntro;
  String cover;
  String updated;
  String author;
  String minorCateV2;
  String minorCate;
  String majorCate;
  String title;
  String creater;
  List<dynamic> anchors;
  String majorCateV2;
  List<StarRatings> starRatings;
  Map bookVideos;
  int latelyFollowerBase;
  int minRetentionRatio;
  bool advertRead;
  String cat;
  bool donate;
  String copyright;
  bool bGg;
  bool isForbidForFreeApp;
  bool isAllowNetSearch;
  bool limit;
  String copyrightInfo;
  String copyrightDesc;
  Null discount;

  BookInfo(
      {this.rating,
      this.tags,
      this.gender,
      this.lastChapter,
      this.chaptersCount,
      this.isSerial,
      this.retentionRatio,
      this.serializeWordCount,
      this.wordCount,
      this.followerCount,
      this.latelyFollower,
      this.totalFollower,
      this.postCount,
      this.banned,
      this.hasCp,
      this.allowBeanVoucher,
      this.allowVoucher,
      this.allowMonthly,
      this.bLe,
      this.contentType,
      this.currency,
      this.superscript,
      this.sizetype,
      this.buytype,
      this.hasCopyright,
      this.authorDesc,
      this.originalAuthor,
      this.allowFree,
      this.safelevel,
      this.isFineBook,
      this.contentLevel,
      this.isMakeMoneyLimit,
      this.starRatingCount,
      this.sId,
      this.longIntro,
      this.cover,
      this.updated,
      this.author,
      this.minorCateV2,
      this.minorCate,
      this.majorCate,
      this.title,
      this.creater,
      this.anchors,
      this.majorCateV2,
      this.starRatings,
      this.bookVideos,
      this.latelyFollowerBase,
      this.minRetentionRatio,
      this.advertRead,
      this.cat,
      this.donate,
      this.copyright,
      this.bGg,
      this.isForbidForFreeApp,
      this.isAllowNetSearch,
      this.limit,
      this.copyrightInfo,
      this.copyrightDesc,
      this.discount});

  BookInfo.fromJson(Map<String, dynamic> json) {
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    tags = json['tags'].cast<String>();
    gender = json['gender'].cast<String>();
    lastChapter = json['lastChapter'];
    chaptersCount = json['chaptersCount'];
    isSerial = json['isSerial'];
    retentionRatio = json['retentionRatio'].toString();
    serializeWordCount = json['serializeWordCount'];
    wordCount = json['wordCount'];
    followerCount = json['followerCount'];
    latelyFollower = json['latelyFollower'];
    totalFollower = json['totalFollower'];
    postCount = json['postCount'];
    banned = json['banned'];
    hasCp = json['hasCp'];
    allowBeanVoucher = json['allowBeanVoucher'];
    allowVoucher = json['allowVoucher'];
    allowMonthly = json['allowMonthly'];
    bLe = json['_le'];
    contentType = json['contentType'];
    currency = json['currency'];
    superscript = json['superscript'];
    sizetype = json['sizetype'];
    buytype = json['buytype'];
    hasCopyright = json['hasCopyright'];
    authorDesc = json['authorDesc'];
    originalAuthor = json['originalAuthor'];
    allowFree = json['allowFree'];
    safelevel = json['safelevel'];
    isFineBook = json['isFineBook'];
    contentLevel = json['contentLevel'];
    isMakeMoneyLimit = json['isMakeMoneyLimit'];
    starRatingCount = json['starRatingCount'];
    sId = json['_id'];
    longIntro = json['longIntro'];
    cover = json['cover'];
    updated = json['updated'];
    author = json['author'];
    minorCateV2 = json['minorCateV2'];
    minorCate = json['minorCate'];
    majorCate = json['majorCate'];
    title = json['title'];
    creater = json['creater'];
    anchors = json["anchors"];
    majorCateV2 = json['majorCateV2'];
    if (json['starRatings'] != null) {
      starRatings = new List<StarRatings>();
      json['starRatings'].forEach((v) {
        starRatings.add(new StarRatings.fromJson(v));
      });
    }
    bookVideos = json['bookVideos'];
    latelyFollowerBase = json['latelyFollowerBase'];
    minRetentionRatio = json['minRetentionRatio'];
    advertRead = json['advertRead'];
    cat = json['cat'];
    donate = json['donate'];
    copyright = json['copyright'];
    bGg = json['_gg'];
    isForbidForFreeApp = json['isForbidForFreeApp'];
    isAllowNetSearch = json['isAllowNetSearch'];
    limit = json['limit'];
    copyrightInfo = json['copyrightInfo'];
    copyrightDesc = json['copyrightDesc'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
    data['tags'] = this.tags;
    data['gender'] = this.gender;
    data['lastChapter'] = this.lastChapter;
    data['chaptersCount'] = this.chaptersCount;
    data['isSerial'] = this.isSerial;
    data['retentionRatio'] = this.retentionRatio;
    data['serializeWordCount'] = this.serializeWordCount;
    data['wordCount'] = this.wordCount;
    data['followerCount'] = this.followerCount;
    data['latelyFollower'] = this.latelyFollower;
    data['totalFollower'] = this.totalFollower;
    data['postCount'] = this.postCount;
    data['banned'] = this.banned;
    data['hasCp'] = this.hasCp;
    data['allowBeanVoucher'] = this.allowBeanVoucher;
    data['allowVoucher'] = this.allowVoucher;
    data['allowMonthly'] = this.allowMonthly;
    data['_le'] = this.bLe;
    data['contentType'] = this.contentType;
    data['currency'] = this.currency;
    data['superscript'] = this.superscript;
    data['sizetype'] = this.sizetype;
    data['buytype'] = this.buytype;
    data['hasCopyright'] = this.hasCopyright;
    data['authorDesc'] = this.authorDesc;
    data['originalAuthor'] = this.originalAuthor;
    data['allowFree'] = this.allowFree;
    data['safelevel'] = this.safelevel;
    data['isFineBook'] = this.isFineBook;
    data['contentLevel'] = this.contentLevel;
    data['isMakeMoneyLimit'] = this.isMakeMoneyLimit;
    data['starRatingCount'] = this.starRatingCount;
    data['_id'] = this.sId;
    data['longIntro'] = this.longIntro;
    data['cover'] = this.cover;
    data['updated'] = this.updated;
    data['author'] = this.author;
    data['minorCateV2'] = this.minorCateV2;
    data['minorCate'] = this.minorCate;
    data['majorCate'] = this.majorCate;
    data['title'] = this.title;
    data['creater'] = this.creater;
    data['anchors'] = this.anchors;
    data['majorCateV2'] = this.majorCateV2;
    if (this.starRatings != null) {
      data['starRatings'] = this.starRatings.map((v) => v.toJson()).toList();
    }
    data['bookVideos'] = this.bookVideos;
    data['latelyFollowerBase'] = this.latelyFollowerBase;
    data['minRetentionRatio'] = this.minRetentionRatio;
    data['advertRead'] = this.advertRead;
    data['cat'] = this.cat;
    data['donate'] = this.donate;
    data['copyright'] = this.copyright;
    data['_gg'] = this.bGg;
    data['isForbidForFreeApp'] = this.isForbidForFreeApp;
    data['isAllowNetSearch'] = this.isAllowNetSearch;
    data['limit'] = this.limit;
    data['copyrightInfo'] = this.copyrightInfo;
    data['copyrightDesc'] = this.copyrightDesc;
    data['discount'] = this.discount;
    return data;
  }
}

class Rating {
  double score;
  int count;
  String tip;
  bool isEffect;

  Rating({this.score, this.count, this.tip, this.isEffect});

  Rating.fromJson(Map<String, dynamic> json) {
    score = (json['score'] is String)?double.parse(json['score']):json['score'];
    count = json['count'];
    tip = json['tip'];
    isEffect = json['isEffect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this.score;
    data['count'] = this.count;
    data['tip'] = this.tip;
    data['isEffect'] = this.isEffect;
    return data;
  }
}

class StarRatings {
  int star;
  int count;

  StarRatings({this.star, this.count});

  StarRatings.fromJson(Map<String, dynamic> json) {
    star = json['star'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['star'] = this.star;
    data['count'] = this.count;
    return data;
  }
}

