class MediaModel {
  String _userId;
  String _mediaType;
  String _mediaCreated;
  String _mediaUrl;

  MediaModel(
      {String userId, String mediaType, String mediaCreated, String mediaUrl}) {
    this._userId = userId;
    this._mediaType = mediaType;
    this._mediaCreated = mediaCreated;
    this._mediaUrl = mediaUrl;
  }

  String get userId => _userId;
  set userId(String userId) => _userId = userId;
  String get mediaType => _mediaType;
  set mediaType(String mediaType) => _mediaType = mediaType;
  String get mediaCreated => _mediaCreated;
  set mediaCreated(String mediaCreated) => _mediaCreated = mediaCreated;
  String get mediaUrl => _mediaUrl;
  set mediaUrl(String mediaUrl) => _mediaUrl = mediaUrl;

  MediaModel.fromJson(Map<String, dynamic> json) {
    _userId = json['user_id'];
    _mediaType = json['media_type'];
    _mediaCreated = json['media_created'];
    _mediaUrl = json['media_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this._userId;
    data['media_type'] = this._mediaType;
    data['media_created'] = this._mediaCreated;
    data['media_url'] = this._mediaUrl;
    return data;
  }
}