import 'package:flutter_driver/driver_extension.dart';
//import 'package:forecanvass/streetList.dart' as app;
import 'package:forecanvass/main.dart' as app;

void main() {
  // This line enables the extension
  enableFlutterDriverExtension();

  // Call the `main()` function of your app or call `runApp` with any widget you
  // are interested in testing.
  app.main();
}