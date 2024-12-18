extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this; // Si la cadena está vacía, la devuelve como está.
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
