import 'package:api/Getx/Getx_Api/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class ShoppingHomeScr extends StatelessWidget {
  ApiController apiController = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping App')),
      body: Obx(
        () {
          if (apiController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return MasonryGridView.count(
              itemCount: apiController.shoppingList.length,
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                final info = apiController.shoppingList[index];
                return Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network('${info.image}'),
                        SizedBox(
                          height: Get.height * .02,
                        ),
                        Text(
                          '${info.id}',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: Get.height * .02,
                        ),
                        Text('Title :${info.title}'),
                        SizedBox(
                          height: Get.height * .02,
                        ),
                        Text(
                          'Category :${info.category}',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: Get.height * .02,
                        ),
                        Text(
                          'Discription :${info.description}',
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: Get.height * .02,
                        ),
                        Text(
                          'Rs. : ${info.price}',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
