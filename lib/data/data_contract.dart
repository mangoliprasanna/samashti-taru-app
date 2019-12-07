class SamashtiDb {
  static int DATABASE_VERSION = 1;
  static String DATABASE_NAME = 'samashtiDB';
}

class UserTable {
  static String tableName = "tbl_users";
  static String colID = "id";
  static String colUserName = "user_name";
  static String colUserEmail = "user_email";
  static String colUserToken = "user_token";
  static String colUserProfile = "user_profile";
  static String colUserContact = "user_contact";
  static String colUserUsn = "user_usn";
  static String colUserCourse = "user_course";
  static String colUserYear = "user_year";

  static String createStatement = "CREATE TABLE " +
      tableName +
      "(" +
      colID +
      " INTEGER PRIMARY KEY," +
      colUserName +
      " TEXT NOT NULL," +
      colUserEmail +
      " TEXT NOT NULL," +
      colUserToken +
      " TEXT NOT NULL," +
      colUserProfile +
      " TEXT NOT NULL," +
      colUserContact +
      " TEXT NOT NULL," +
      colUserUsn +
      " TEXT NOT NULL," +
      colUserCourse +
      " TEXT NOT NULL," +
      colUserYear +
      " TEXT NOT NULL" +
      ")";
}
