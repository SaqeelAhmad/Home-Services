class sessioncontroller {
  static final sessioncontroller _session = sessioncontroller.internal();

  String? userId;

  factory sessioncontroller() {
    return _session;
  }

  sessioncontroller.internal() {}
}



