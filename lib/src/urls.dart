// ignore_for_file: non_constant_identifier_names
class BASEURL {
  static var URL = '';
  static var DEBUG = '';
  static var DEV = '';
  static var QA = '';
  static var OTHER = '';
  static var PROD = '';

  /// Base URL initialization
  BASEURL.init({required debug, dev, qa, other, prod}) {
    BASEURL.DEBUG = debug;
    BASEURL.DEV = dev ?? '';
    BASEURL.QA = qa ?? '';
    BASEURL.DEBUG = debug ?? '';
    BASEURL.OTHER = other ?? '';
    BASEURL.PROD = prod ?? '';
    BASEURL.URL = debug;
  }
}
