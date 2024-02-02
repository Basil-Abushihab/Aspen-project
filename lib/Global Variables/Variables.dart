class GlobalVariables {
  static String _id = "Aspen, USA";

  static String _type = "Locations";

  static String get type => _type;

  static String get id => _id;

  static set id(String value) {
    _id = value;
  }

  static set type(String value) {
    _type = value;
  }
}
