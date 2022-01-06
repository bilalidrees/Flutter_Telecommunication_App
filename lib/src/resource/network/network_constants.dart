enum Status {
  none,
  timeOutException,
}

class NetworkConstants {
  static const String BASE_URL = "https://vp.vxt.net:31443";

  static  String UFONE_INFO_URL =
      "https://api01.vectracom.net:8443/zong-info/";

  static const String CORONA_STATS = "corona";
  static const String CORONA_NEWS = "corona-news";
  static const String FINANCE_INFORMATION = "finance";
  static const String WEATHER_INFORMATION = "weather";
  static const String PRAYER_INFORMATION = "https://vp.vxt.net:31443/api/pt";

  static const String CATEGORIES_URL =
      "https://vp.vxt.net:41538/itgn/viperapp-menulist-en_v2.json";

  static const String CATEGORIES_URL_URDU =
      "https://vp.vxt.net:41538/zong/viperapp-menulist-ur_v1.json";

  static const String NEWS_FEED_URL = "https://vp.vxt.net:9443/rdrss/v3/api";
  static const String REGISTER_URL =
      "https://api01.vectracom.net:8443/itgn/users/register";
  static const String LOGIN_URL = "https://api01.vectracom.net:8443/itgn/auth";
  static const String PROFILE_UPDATE_URL =
      "https://api01.vectracom.net:8443/itgn/users/update";
  static const String IMAGE_UPLOAD_URL =
      "https://api01.vectracom.net:8443/itgn/users/image";
  static const String SOCIAL_LOGIN_URL =
      "https://api01.vectracom.net:8443/itgn/auth/social";
  static const String FORGOT_PASSWORD_URL =
      "https://api01.vectracom.net:8443/itgn/users/forgot";
  static const String SERVER_ERROR = "internel server error";
}
