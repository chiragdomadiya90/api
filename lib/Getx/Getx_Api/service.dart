import 'package:api/Getx/Getx_Api/shopping_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<ShoppingModel>?> apiData() async {
    http.Response response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      return shoppingModelFromJson(response.body);
    }
  }
}
