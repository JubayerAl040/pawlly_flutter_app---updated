import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pawlly/main.dart';
import 'package:pawlly/screens/pet_sitter/pet_sitter_controller.dart';
import 'package:pawlly/screens/pet_sitter/pet_sitter_item_component.dart';
import 'package:pawlly/screens/pet_sitter/pet_sitter_model.dart';
import '../../../components/app_scaffold.dart';
import '../../../components/loader_widget.dart';
import '../../../utils/empty_error_state_widget.dart';

class PetSitterListScreen extends StatelessWidget {
  PetSitterListScreen({Key? key}) : super(key: key);
  final PetSitterController petSitterController = Get.put(PetSitterController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: locale.value.petSitters,
      isLoading: petSitterController.isLoading,
      body: Column(
        children: [
          Obx(
            () => SnapHelperWidget(
              future: petSitterController.getPetSitterList.value,
              errorBuilder: (error) {
                return SizedBox(
                  height: Get.height * 0.7,
                  child: NoDataWidget(
                    title: error,
                    retryText: locale.value.reload,
                    imageWidget: const ErrorStateWidget(),
                    onRetry: () {
                      petSitterController.init();
                    },
                  ).paddingSymmetric(horizontal: 16),
                );
              },
              loadingWidget: petSitterController.isLoading.value
                  ? const Offstage()
                  : SizedBox(
                      height: Get.height * 0.7,
                      child: const LoaderWidget().center(),
                    ),
              onSuccess: (petSitters) {
                log('pets.isEmpty: ${petSitters.isEmpty}');
                return AnimatedScrollView(
                  padding: const EdgeInsets.only(bottom: 50),
                  physics: const AlwaysScrollableScrollPhysics(),
                  onSwipeRefresh: () async {
                    petSitterController.page(1);
                    petSitterController.init(showloader: false);
                    return await Future.delayed(const Duration(seconds: 2));
                  },
                  onNextPage: () async {
                    if (!petSitterController.isLastPage.value) {
                      petSitterController.page(petSitterController.page.value + 1);
                      petSitterController.init();
                    }
                  },
                  children: [
                    16.height,
                    Obx(
                      () => Wrap(
                        runSpacing: 16,
                        spacing: 16,
                        children: List.generate(petSitters.length, (index) {
                          return PetSitterItemComponent(
                            petSitter: PetSitterItem(
                              id: petSitters[index].id,
                              fullName: petSitters[index].fullName,
                              email: petSitters[index].email,
                              mobile: petSitters[index].mobile,
                              profileImage: petSitters[index].profileImage.value,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
