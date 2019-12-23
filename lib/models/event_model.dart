class EventModel {
  String id;
  String eventName;
  String eventStart;
  String eventDesc;
  String eventContact;
  String eventPerson;
  String eventPicture;
  String categoryName;

  EventModel(
      {this.id,
      this.eventName,
      this.eventStart,
      this.eventDesc,
      this.eventContact,
      this.eventPerson,
      this.eventPicture,
      this.categoryName});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['event_name'];
    eventStart = json['event_start'];
    eventDesc = json['event_desc'];
    eventContact = json['event_contact'];
    eventPerson = json['event_person'];
    eventPicture = json['event_picture'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_name'] = this.eventName;
    data['event_start'] = this.eventStart;
    data['event_desc'] = this.eventDesc;
    data['event_contact'] = this.eventContact;
    data['event_person'] = this.eventPerson;
    data['event_picture'] = this.eventPicture;
    data['category_name'] = this.categoryName;
    return data;
  }
}


class GalleryModel {
  String id;
  String galleryPath;
  String galleryDate;
  String galleryAlbum;
  String galleryFormat;

  GalleryModel(
      {this.id,
      this.galleryPath,
      this.galleryDate,
      this.galleryAlbum,
      this.galleryFormat});

  GalleryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    galleryPath = json['gallery_path'];
    galleryDate = json['gallery_date'];
    galleryAlbum = json['gallery_album'];
    galleryFormat = json['gallery_format'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gallery_path'] = this.galleryPath;
    data['gallery_date'] = this.galleryDate;
    data['gallery_album'] = this.galleryAlbum;
    data['gallery_format'] = this.galleryFormat;
    return data;
  }
}