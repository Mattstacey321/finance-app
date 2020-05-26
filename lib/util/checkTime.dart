bool isDifference(String time) {
    return DateTime.parse(time).difference(DateTime.now()).inDays == 0;
  }