class AppDateUtils {
  static String toBrDateFormat(DateTime? datetime) {
    if (datetime == null) {
      return "";
    }
    return datetime.toString().split(" ").first.split("-").reversed.join("/");
  }

  static String toHourFormat(DateTime? datetime) {
    if (datetime == null) {
      return "";
    }
    return datetime.toString().split(" ").last.substring(0, 5);
  }
}