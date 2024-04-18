class TaskHelper {
  static final String tableName = 'tasks';
  static final String idColumn = 'id';
  static final String textColumn = 'texto';
  static final String doneColumn = 'done';
  static final String imagePathColumn = 'imagePath';

  static String get createScript {
    return "CREATE TABLE ${tableName}($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, " +
        "$textColumn TEXT NOT NULL, $doneColumn INTEGER NOT NULL, $imagePathColumn STRING);";
  }
}
