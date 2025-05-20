class API {
  static final rootsApi = "https://api.cribsfinder.com/public/";
  static final rootsUserApi = "https://api.cribsfinder.com/user/";
  static final rootsAssets = "https://assets.cribsfinder.com/";

  static final blog = path(rootsApi, "blog");
  static final shop = path(rootsApi, "shop");
  static final home = path(rootsApi, "home");
  static final hotels = path(rootsApi, "hotels");
  static final hotel = path(rootsApi, "hotel");
  static final wallet = path(rootsApi, "wallet");
  static final profile = "https://api.cribsfinder.com/user/profile";
  static final filterHotels = path(rootsApi, "search-hotels");
  static final shortlets = path(rootsApi, "shortlets");
  static final shortlet = path(rootsApi, "shortlet");
  static final filterShortlets = path(rootsApi, "search-shortlets");
  static final events = path(rootsApi, "events");
  static final event = path(rootsApi, "event");
  static final filterEvents = path(rootsApi, "search-events");
  static final attractions = path(rootsApi, "attractions");
  static final attraction = path(rootsApi, "attraction");
  static final filterAttractions = path(rootsApi, "search-attractions");
  static final automobiles = path(rootsApi, "automobiles");
  static final automobile = path(rootsApi, "automobile");
  static final filterBoats = path(rootsApi, "search-boats");
  static final boats = path(rootsApi, "boats");
  static final boat = path(rootsApi, "boat");
  static final filterProperties = path(rootsApi, "search-properties");
  static final properties = path(rootsApi, "properties");
  static final property = path(rootsApi, "property");
  static final filterAutomobiles = path(rootsApi, "search-automobiles");
  static final orders = path(rootsApi, "orders");
  static final products = path(rootsApi, "products");
  static final product = path(rootsApi, "product");
  static final listing = path(rootsApi, "listing");
  static final checkout = path(rootsApi, "checkout");
  static final wishlist = path(rootsApi, "wishlist");
  static final cart = path(rootsApi, "cart");
  static final account = path(rootsApi, "account");
  static final contact = path(rootsApi, "support");
  static final pricing = path(rootsApi, "pricing");

  static final dashboard = path(rootsUserApi, "dashboard");
  static final bookings = path(rootsUserApi, "bookings");
  static final leads = path(rootsUserApi, "leads");
  static final userLogin = path(rootsUserApi, "login");
  static final verify = path(rootsUserApi, "verify");
  static final forgot = path(rootsUserApi, "forgot-password");
  static final userProfile = path(rootsUserApi, "profile");
  static final userWallet = path(rootsUserApi, "wallet");
  static final settings = path(rootsUserApi, "settings");
  static final userSignup = path(rootsUserApi, "signup");
  static final misc = path(rootsUserApi, "misc");
  static final log = path(rootsUserApi, "logs");
  static final earnings = path(rootsUserApi, "earnings");
  static final transactions = path(rootsUserApi, "transactions");
  static final reviews = path(rootsUserApi, "reviews");
  static final payment = path(rootsUserApi, "payment");
  static final support = path(rootsUserApi, "support");
  static final insights = path(rootsUserApi, "insights");
  static final messages = path(rootsUserApi, "messages");
  static final referrals = path(rootsUserApi, "referrals");
  static final staff = path(rootsUserApi, "staff");
  static final role = path(rootsUserApi, "roles");
  static final userWishlist = path(rootsUserApi, "wishlist");
  static final billPayments = path(rootsUserApi, "bill-payments");

  static final assetUsers = path(rootsAssets, "customers/");
  static final assetVendors = path(rootsAssets, "users/");
  static final assetHotels = path(rootsAssets, "listings/");
  static final assetEvents = path(rootsAssets, "events/");
  static final assetAutomobiles = path(rootsAssets, "automobiles/");
  static final assetShortlets = path(rootsAssets, "listings/");
  static final assetBoats = path(rootsAssets, "boats/");
  static final assetProperties = path(rootsAssets, "properties/");
  static final assetAttractions = path(rootsAssets, "events/");
  static final assetPost = path(rootsAssets, "posts/");
  static final assetAuthor = path(rootsAssets, "admins/");
  static final assetBlogCategory = path(rootsAssets, "categories/");

  static String path(String root, String sublink) {
    return "$root$sublink";
  }
}
