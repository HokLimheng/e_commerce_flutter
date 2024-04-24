class AppUrl {
  static String baseUrl = "https://cms.istad.co";
  static var getAllProduct = "$baseUrl/api/e-commerce-products?populate=*";
  static var getAllCategory = "$baseUrl/api/e-commerce-categories?populate=*";
  static var uploadImage = "$baseUrl/api/upload";
  static var postProduct = "$baseUrl/api/e-commerce-products";
}