import 'package:myray_mobile/app/shared/utils/utils.dart';

class FilterPrice {
  double? salaryFrom;
  double? salaryTo;

  String toPriceString() {
    if (salaryFrom != null && salaryTo != null) {
      return '${Utils.vietnameseCurrencyFormat.format(salaryFrom)} - ${Utils.vietnameseCurrencyFormat.format(salaryTo)}';
    }
    if (salaryFrom == null && salaryTo == null) {
      return 'Tất cả';
    }

    if(salaryFrom == null) {
      return 'Dưới ${Utils.vietnameseCurrencyFormat.format(salaryTo)}';
    }

    if(salaryTo == null) {
      return 'Từ ${Utils.vietnameseCurrencyFormat.format(salaryFrom)}';
    }
    return 'Không có mức giá nào';
  }

  FilterPrice({this.salaryFrom, this.salaryTo});
}

class PriceList {
  static List<FilterPrice> priceList = [
    FilterPrice(
      salaryFrom: null,
      salaryTo: null,
    ),
    FilterPrice(
      salaryFrom: null,
      salaryTo: 80000,
    ),
    FilterPrice(
      salaryFrom: 80000,
      salaryTo: 100000,
    ),
    FilterPrice(
      salaryFrom: 100000,
      salaryTo: 150000,
    ),
    FilterPrice(
      salaryFrom: 150000,
      salaryTo: 200000,
    ),
    FilterPrice(
      salaryFrom: 200000,
      salaryTo: 500000,
    ),
    FilterPrice(
      salaryFrom: 500000,
      salaryTo: 1000000,
    ),
    FilterPrice(
      salaryFrom: 1000000,
      salaryTo: 5000000,
    ),
    FilterPrice(
      salaryFrom: 5000000,
      salaryTo: null,
    ),
  ];
}
