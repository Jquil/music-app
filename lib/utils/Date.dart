class Date{

  static String getDate(){
    var dt = DateTime.now();
    return "${dt.year}-${dt.month}-${dt.day}";
  }
}