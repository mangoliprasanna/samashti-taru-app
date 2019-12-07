class UserModel {
  int id;
  String userName;
  String userEmail;
  String userToken;
  String userProfile;
  String userContact;
  String userUsn;
  String userCourse;
  String userYear;

  UserModel(
      {this.id,
      this.userName,
      this.userEmail,
      this.userToken,
      this.userProfile,
      this.userContact,
      this.userUsn,
      this.userCourse,
      this.userYear});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userToken = json['user_token'];
    userProfile = json['user_profile'];
    userContact = json['user_contact'];
    userUsn = json['user_usn'];
    userCourse = json['user_course'];
    userYear = json['user_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['user_token'] = this.userToken;
    data['user_profile'] = this.userProfile;
    data['user_contact'] = this.userContact;
    data['user_usn'] = this.userUsn;
    data['user_course'] = this.userCourse;
    data['user_year'] = this.userYear;
    return data;
  }
}