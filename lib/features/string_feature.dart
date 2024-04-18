extension MyExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

responsive<T>(double media, T val, T val2) {
    if (media > 800) {
      return val;
    } else {
      return val2;
    }
  }

