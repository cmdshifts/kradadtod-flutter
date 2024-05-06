import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kradadtod/common/widgets/components/bannerContainer.dart';
import 'package:kradadtod/common/widgets/components/bannerIndicator.dart';
import 'package:kradadtod/features/financial/controllers/bannerController.dart';
import 'package:kradadtod/utils/constants/colors.dart';
import 'package:kradadtod/utils/constants/sizes.dart';
import 'package:kradadtod/utils/devices/deviceUtility.dart';

class BannerCarousel extends StatelessWidget {
  const BannerCarousel({super.key, required this.banners});

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: banners.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return BannerContainer(
              backgroundColor: Colors.transparent,
              width: KAppDeviceUtils.getScreenWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: KAppSizes.md),
              imageUrl: banners[index],
            );
          },
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
        ),
        const SizedBox(
          height: KAppSizes.spaceBetweenItems,
        ),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < banners.length; i++)
                  BannerIndicator(
                    width: 20.0,
                    height: 4.0,
                    margin: const EdgeInsets.only(right: 10),
                    backgroundColor: controller.carouselCurrentIndex.value == i
                        ? KAppColors.azure
                        : Colors.grey,
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
