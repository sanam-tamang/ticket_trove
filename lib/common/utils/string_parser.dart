int stringToIntParser(String data) {
  try {
    final parseData = int.parse(data);
    return parseData;
  } catch (e) {
    return 0000;
  }
}


double stringToDoubleParser(String data) {
  try {
    final parseData = double.parse(data);
    return parseData;
  } catch (e) {
    return 0000;
  }
}
