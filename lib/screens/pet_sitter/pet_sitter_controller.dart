import 'package:get/get.dart';
import '../../utils/constants.dart';
import '../booking_module/model/employe_model.dart';
import '../booking_module/services/services_form_api.dart';

class PetSitterController extends GetxController {
  Rx<Future<RxList<EmployeeModel>>> getPetSitterList = Future(() => RxList<EmployeeModel>()).obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;
  RxList<EmployeeModel> petSittersList = RxList();
  RxInt page = 1.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init({bool showloader = true}) {
    if (showloader) {
      isLoading(true);
    }
    getPetSitterList(PetServiceFormApis.getPetSitters(
      role: EmployeeKeyConst.petSitter,
      perPage: 4,
      petSittersList: petSittersList,
      page: page.value,
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    )).whenComplete(() => isLoading(false));
  }
}
