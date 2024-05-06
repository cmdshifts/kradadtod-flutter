import 'package:intl/intl.dart';

class KAppFormatters {
  static String formatDate(DateTime? date, String? format) {
    date ??= DateTime.now();
    format ??= 'dd MMM, yyyy';
    return DateFormat(format).format(date);
  }

  static String formatMoney(double amount, {int decimalDigits = 2}) {
    final formatter = NumberFormat.currency(
      locale: 'th_TH',
      symbol: '',
      decimalDigits: decimalDigits,
    );
    return '${formatter.format(amount)} THB';
  }

  static String capitalizeWord(String word) {
    if (word.isEmpty) {
      return word;
    }

    return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
  }

  static String capitalizeWords(String sentence) {
    List<String> words = sentence.split(' ');
    List<String> capitalizedWords = [];

    for (String word in words) {
      capitalizedWords.add(capitalizeWord(word));
    }

    return capitalizedWords.join(' ');
  }
}
