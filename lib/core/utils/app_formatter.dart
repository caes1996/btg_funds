import 'package:fondo_btg/core/constants/app_constants.dart';
import 'package:intl/intl.dart';

class AppFormatter {

  static String formatCurrency(num amount) {
    final formatter = NumberFormat.currency(
      locale: AppConstants.currencyLocale,
      symbol: '',
      decimalDigits: 0,
    );
    return '${AppConstants.currencySymbol} \$${formatter.format(amount)}';
  }

  static String formatCurrencySimple(num amount) {
    final formatter = NumberFormat.currency(
      locale: AppConstants.currencyLocale,
      symbol: '',
      decimalDigits: 0,
    );
    return '\$${formatter.format(amount)}';
  }

  static String formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    
    final day = date.day.toString().padLeft(2, '0');
    final month = months[date.month - 1];
    final year = date.year;
    
    return '$day $month $year';
  }
}