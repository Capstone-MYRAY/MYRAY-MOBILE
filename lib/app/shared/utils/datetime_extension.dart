extension ExDateTime on DateTime {
  bool isDateInRange(DateTime dMin, DateTime dMax) {
    if (compareTo(dMin) < 0) return false;
    if (compareTo(dMax) > 0) return false;
    return true;
  }

  bool isToday() {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }
}
