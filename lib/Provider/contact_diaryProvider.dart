import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactProvider extends ChangeNotifier {
  late bool _isDark;
  late bool _isGridView;

  bool get isDark => _isDark;

  ThemeProvider() {
    _isDark = false;
    _isGridView = false;
    notifyListeners();
  }

  set isDark(bool value) {
    _isDark = value;
    notifyListeners();
  }

  set isGridView(bool value) {
    _isGridView = value;
    notifyListeners();
  }

  late final SharedPreferences prefs;
  static const String isUserNew = 'isUserNew';
  initPreference() async {
    prefs = await SharedPreferences.getInstance();
    print("prefs");
  }

  saveNewUserValue(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isUserNew, value);
  }

  Future<bool> getNewUserValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isUserNew) ?? true;
  }

  final LocalAuthentication auth = LocalAuthentication();

  useAuth() {
    try {
      final bool didAuthenticate = auth.authenticate(
        localizedReason: "Please Authenticate First",
        options: AuthenticationOptions(useErrorDialogs: false),
      ) as bool;
      print("dfdf");
    } on PlatformException catch (e) {
      print("Error :: $e");
    }
  }

  int activeStep = 5;
  int upperBound = 6;

  String header() {
    switch (activeStep) {
      case 1:
        return "Preface";
      case 2:
        return "Contents";
      case 3:
        return "About the Author";
      case 4:
        return "Publisher Information";
      case 5:
        return "Reviews";
      case 6:
        return "Chapters #1";
      default:
        return "Introduction";
    }
  }

  updateActiveStep(int index) {
    activeStep = index;
    notifyListeners();
  }

  updateNextButton() {
    if (activeStep < upperBound) {
      activeStep++;
    }
    notifyListeners();
  }

  updatePreviousButton() {
    if (activeStep > 0) {
      activeStep--;
    }
    notifyListeners();
  }
}
