class Comment {
  int id = 0;
  String comment = "";
  DateTime createdAt = DateTime.now();
  int partnerId = 0;
  double rank = 0;
  String username = "";
  String userUid = "";
  String userCityName = "";

  bool enable = false;
  DateTime? approvalAt;
  String approvalBy = "";

  String imageUrl = "";

  Comment();

  Map<String, dynamic> toJson() => {
        'comment': comment,
        'createdAt': createdAt,
        'userUid': userUid,
        'partnerId': partnerId,
        'rank': rank,
        'id': id,
        'username': username,
        'userCityName': userCityName,
        'approvalAt': approvalAt,
        'approval_by': approvalBy,
        'enable': enable,
      };

  Comment.fromJson(Map<String, dynamic> json, {String? uid})
      : comment = json['comment'],
        enable = json['enable'] ?? false,
        id = int.parse(uid ?? json['id']?.toString() ?? "0"),
        createdAt = json['createdAt'].toDate(),
        userUid = json['userUid'],
        partnerId = json['partnerId'],
        rank = double.parse(json['rank'].toString()),
        username = json['username'],
        userCityName = json['userCityName'];
}
