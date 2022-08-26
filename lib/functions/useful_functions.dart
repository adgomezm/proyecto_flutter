String capitalizeOnlyFirstLater(String data) {
  if (data.trim().isEmpty) return "";

  return "${data[0].toUpperCase()}${data.substring(1)}";
}
