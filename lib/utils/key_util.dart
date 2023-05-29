class KeyUtil {
  String getPrimaryKeyFromLatLong(double lat, double long) {
    return "$lat$long}".hashCode.toString();
  }
}
