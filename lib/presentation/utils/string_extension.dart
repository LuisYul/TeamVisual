extension StringExtensions on String {
  bool equalsIgnoreCase(String secondString)
  => toLowerCase().contains(secondString.toLowerCase());
}