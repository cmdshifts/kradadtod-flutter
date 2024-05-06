import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  final carouselCurrentIndex = 0.obs;

  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }
}
