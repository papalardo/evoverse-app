class AppDateUtils {
  static String toBrDateFormat(DateTime datetime) {
    return datetime.toString().split(' ').first.split('-').reversed.join('/');
  }
}