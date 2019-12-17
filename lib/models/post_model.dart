class PostModel {
  int postId;
  int userId;
  String userName;
  String userProfile;
  String postDesc;
  String postMedia;
  String postType;
  int postLikes;
  int postComments;
  int postReported;
  String postDate;

  PostModel(
      {this.postId,
      this.userId,
      this.userName,
      this.postDesc,
      this.postMedia,
      this.postType,
      this.userProfile,
      this.postLikes,
      this.postComments,
      this.postReported,
      this.postDate});

  PostModel.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userProfile = json['user_profile'];
    postDesc = json['post_desc'];
    postMedia = json['post_media'];
    postType = json['post_type'];
    postLikes = json['post_likes'];
    postComments = json['post_comments'];
    postReported = json['post_reported'];
    postDate = json['post_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data["user_profile"] = this.userProfile;
    data['post_desc'] = this.postDesc;
    data['post_media'] = this.postMedia;
    data['post_type'] = this.postType;
    data['post_likes'] = this.postLikes;
    data['post_comments'] = this.postComments;
    data['post_reported'] = this.postReported;
    data['post_date'] = this.postDate;
    return data;
  }
}