bool enablePrint = true;

class PrintUtils {
  static void debug(String dataToPrint) {
    try {
      if (enablePrint) {
        print(dataToPrint);
      } else {
        //DO NOTHING.
      }
    } catch (e) {
      print("e$e");
    }
  }
}
