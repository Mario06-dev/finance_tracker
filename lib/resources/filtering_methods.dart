/* 

    Methods for filtering used throughout the app for filtering variuos data.

 */

class FilteringMethods {
  DateTime getFilteredDate(int timeFilter) {
    DateTime filterDate = DateTime.now();
    DateTime today = DateTime.now();
    switch (timeFilter) {

      // 7 Day Time Filter
      case 0:
        filterDate = DateTime(today.year, today.month, today.day - 7);
        return filterDate;

      // 30 Day Time Filter
      case 1:
        filterDate = DateTime(today.year, today.month, today.day - 30);
        return filterDate;

      // 12 Weeks Time Filter
      case 2:
        filterDate = DateTime(today.year, today.month, today.day - 84);
        return filterDate;

      // 6 Months Time Filter
      case 3:
        filterDate = DateTime(today.year, today.month - 6, today.day);
        return filterDate;

      // 1 Year Time Filter
      case 4:
        filterDate = DateTime(today.year - 1, today.month, today.day);
        return filterDate;

      default:
        return DateTime.now();
    }
  }
}
