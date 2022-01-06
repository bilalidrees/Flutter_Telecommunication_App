class ImageAssetsResolver {
  static const DARK_THEME = 'assets/image/dark_image.jpg';
  static const LIGHT_THEME = 'assets/image/light_image.jpg';
  static const error_image = 'assets/image/error_image.png';
  static const APP_ICON = 'assets/image/f_logo.png';
  static const HOME_ICON = 'assets/image/home.png';
  static const ITGN_IMAGE = 'assets/image/itgn.png';
  static const ITGN_APP_ICON = 'assets/image/itgn_app_icon.png';
  static const ITGN_PLACEHOLDER_ICON = 'assets/image/placeholder.png';
  static const lowTemp ='https://myufoneinfoservice.vectracom.com/assets/imgs/temperatureLow1.png';
  static const highTemp ='https://myufoneinfoservice.vectracom.com/assets/imgs/temperatureHigh1.png';
  static const humidity = 'https://myufoneinfoservice.vectracom.com/assets/imgs/humidity.png';
  static const uv_index ='https://myufoneinfoservice.vectracom.com/assets/imgs/_uv_index_669263.png';
  static const WEATHER_BACKGROUND = 'assets/image/weather_background.png';
  static const ufoneLogo = 'assets/image/logo.png';
  //symptoms images
  static const cough ="https://myufoneinfoservice.vectracom.com/assets/imgs/caugh.png";
  static const fever = "https://myufoneinfoservice.vectracom.com/assets/imgs/fever.png";
  static const breath = "https://myufoneinfoservice.vectracom.com/assets/imgs/breath.png";
  static const throat = "https://myufoneinfoservice.vectracom.com/assets/imgs/throat.png";
  //demo images
  static const BUSINESS_LOGO =
      'https://vp.vxt.net:41538/itgn/assets/imgs/business.png';
  static const ENTERTAINMENT_LOGO =
      'https://vp.vxt.net:41538/itgn/assets/imgs/entertainment.png';
  static const LIFESTYLE_LOGO =
      'https://vp.vxt.net:41538/itgn/assets/imgs/lifestyle.png';
  static const NEWS_LOGO = 'https://vp.vxt.net:41538/itgn/assets/imgs/news.png';
  static const SPORTS_LOGO =
      'https://vp.vxt.net:41538/itgn/assets/imgs/sports.png';
  static const TECH_LOGO =
      'https://vp.vxt.net:41538/itgn/assets/imgs/science.png';

  static const String Mosque_Image = 'assets/image/masjid.png';
  static const String Mosque_PNG = 'assets/image/islamabad.png';
  static List<String> light_image_list = [
    "https://myufoneinfoservice.vectracom.com/assets/imgs/fajr.png",
    "https://myufoneinfoservice.vectracom.com/assets/imgs/zohr.png",
    "https://myufoneinfoservice.vectracom.com/assets/imgs/asr.png",
    "https://myufoneinfoservice.vectracom.com/assets/imgs/magrib.png",
    "https://myufoneinfoservice.vectracom.com/assets/imgs/isha.png"
  ];
  static const List<String> dark_image_list = [
    "https://myufoneinfoservice.vectracom.com/assets/imgs/fajr_dark.png",
    "https://myufoneinfoservice.vectracom.com/assets/imgs/zohr_dark.png",
    "https://myufoneinfoservice.vectracom.com/assets/imgs/asr_dark.png",
    "https://myufoneinfoservice.vectracom.com/assets/imgs/magrib_dark.png",
    "https://myufoneinfoservice.vectracom.com/assets/imgs/isha_dark.png"
  ];

  static getWeatherImage(String key) {
    return 'assets/image/$key.png';
  }
}
