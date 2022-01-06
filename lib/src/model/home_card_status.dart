import 'package:ufone_web/src/ui/ui_constants/theme/string.dart';

class HomeCardStatus {
  final String text;
  bool? value;

  HomeCardStatus(this.text, this.value);

  static Map<int, bool> homeCardMap = {
    0: true,
    1: true,
    2: true,
    3: true,
  };

  static List<HomeCardStatus> getList() {
    List<HomeCardStatus> list = [
      HomeCardStatus(AppString.corona , homeCardMap[0]),
      HomeCardStatus(AppString.prayer, homeCardMap[1]),
      HomeCardStatus(AppString.weather, homeCardMap[2]),
      HomeCardStatus(AppString.exchange, homeCardMap[3]),
    ];
    return list;
  }
}
