/// List of api end points
class ApiRoutes {
  ApiRoutes._();

  static String base = 'http://10.0.2.2:8080';
  static String meta = '$base/meta';
  static String register = '$base/signup';
  static String login = '$base/login';
  static String vendors = '$base/vendors';
  static String tables = '$base/tables';
  static String vendorTables(String vendorId) =>
      '$base/tables?vendor_id=$vendorId';

  static String vendor(id) => '$base/vendors/$id';
}
