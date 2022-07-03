class ApiUrl {

  // base url 
  // final String baseUrl = "http://10.0.2.2:8000";
  final String baseUrl = "https://mythicserver.herokuapp.com";
  // final String baseUrlImage = "http://10.0.2.2:8000/public/";
  final String baseUrlImage = "https://mythicserver.herokuapp.com/public/";
  // final String baseUrl = "http://127.0.0.1:8000";

  // auth user
  final String singUp = "/api/singup/";
  final String login = "/api/login/";

  // api user
  final String getUser = "/api/user/";

  // api product
  final String getProducts = "/api/home/";
  final String getProductDetail = "/api/product/";

  // api search
  final String searchProduct = "/api/search/";
  final String searchProductPopuler = "/api/search/populer";
  final String searchProductNew = "/api/search/new";
  final String searchProductHighPrice = "/api/search/highprice";
  final String searchProductLowPrice = "/api/search/lowprice";
  final String searchProductCosplay = "/api/search/cosplay";
  final String searchProductIllustration = "/api/search/illustration";

  // creator
  final String getCreator = "/api/creator/";
  final String getCreatorCollection= "/api/creator/collection/";

  // wishlist
  final String wishlistAdd = "/api/wishlist/";
  final String wishlistRead = "/api/wishlist/";
  final String wishlistDelete = "/api/wishlist/";
}
