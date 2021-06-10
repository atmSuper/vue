String getYMD(DateTime dateTime) {
  return dateTime == null
      ? ""
      : dateTime.year.toString() +
          "-" +
          dateTime.month.toString() +
          "-" +
          dateTime.day.toString();
}
