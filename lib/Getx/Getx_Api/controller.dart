import 'package:api/Getx/Getx_Api/service.dart';
import 'package:api/Getx/Getx_Api/shopping_model.dart';
import 'package:get/get.dart';

class ApiController extends GetxController {
  RxBool isLoading = true.obs;

  var shoppingList = <ShoppingModel>[].obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    isLoading(true);

    try {
      final Data = await ApiService.apiData();

      if (Data != null) {
        shoppingList.value = Data;
      }
    } finally {
      isLoading(false);
    }
  }
}
