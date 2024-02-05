import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../dashboard/dashboard_res_model.dart';
import '../../pet/model/pet_list_res_model.dart';
import '../../pet/my_pets_controller.dart';
import '../model/booking_data_model.dart';
import '../model/choose_pet_widget.dart';
import 'model/book_grooming_req.dart';
import '../model/employe_model.dart';
import '../model/service_model.dart';
import '../payment_screen.dart';
import '../services/services_form_api.dart';
import '../../../utils/app_common.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../payment_controller.dart';

class GroomingController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool showBookBtn = false.obs;
  RxBool isRefresh = false.obs;
  BookGroomingReq bookGroomingReq = BookGroomingReq();

  //Service
  Rx<ServiceModel> selectedService = ServiceModel().obs;
  RxList<ServiceModel> serviceList = RxList();

  //Error Service
  RxBool hasErrorFetchingService = false.obs;
  RxString errorMessageService = "".obs;

  //Groomer
  Rx<EmployeeModel> selectedGroomer = EmployeeModel(profileImage: "".obs).obs;
  RxList<EmployeeModel> groomerList = RxList();
  Rx<BookingDataModel> bookingFormData = BookingDataModel(service: SystemService(), payment: PaymentDetails(), training: Training()).obs;

  //Error Groomer
  RxBool hasErrorFetchingGroomer = false.obs;
  RxString errorMessageGroomer = "".obs;

  RxBool isUpdateForm = false.obs;
  TextEditingController dateCont = TextEditingController();
  TextEditingController timeCont = TextEditingController();
  TextEditingController serviceCont = TextEditingController();
  TextEditingController groomerCont = TextEditingController();
  TextEditingController additionalInfoCont = TextEditingController();

  @override
  void onInit() {
    bookGroomingReq.systemServiceId = currentSelectedService.value.id;
    if (Get.arguments is BookingDataModel) {
      try {
        isUpdateForm(true);
        bookingFormData(Get.arguments as BookingDataModel);
        additionalInfoCont.text = bookingFormData.value.note;
        getService();
        selectedPet(myPetsScreenController.myPets.firstWhere((element) => element.name.toLowerCase() == bookingFormData.value.petName.toLowerCase(), orElse: () => PetData()));
      } catch (e) {
        log('grooming book again E: $e');
      }
    } else {
      getService();
      // getGroomer();
    }
    super.onInit();
  }

  void reloadWidget() {
    isRefresh(true);
    isRefresh(false);
  }

  ///Get Service List
  getService({String searchtext = ""}) {
    isLoading(true);
    PetServiceFormApis.getService(
      type: ServicesKeyConst.grooming,
      search: searchtext,
    ).then((value) {
      isLoading(false);
      serviceList(value.data);
      hasErrorFetchingService(false);
      if (isUpdateForm.value) {
        log('VALUE.DATA: bookingFormData.value.service.id: ${bookingFormData.value.veterinaryServiceId}');
        for (var i = 0; i < value.data.length; i++) {
          log('VALUE.DATA: ${value.data[i].id}');
        }
        selectedService(value.data.firstWhere((p0) => p0.id == bookingFormData.value.veterinaryServiceId, orElse: () => ServiceModel()));
        bookGroomingReq.petId = selectedPet.value.id;
        serviceCont.text = selectedService.value.name;
        getGroomer();
      }
    }).onError((error, stackTrace) {
      hasErrorFetchingService(true);
      errorMessageService(error.toString());
      isLoading(false);
      // toast(error.toString());
    });
  }

  void clearGroomerSelection() {
    groomerCont.clear();
    selectedGroomer(EmployeeModel(profileImage: "".obs));
  }

  ///Get Groomer List
  getGroomer({String searchtext = ""}) {
    isLoading(true);
    PetServiceFormApis.getEmployee(
      role: EmployeeKeyConst.grooming,
      serviceId: selectedService.value.id.toString(),
      search: searchtext,
    ).then((value) {
      isLoading(false);
      groomerList(value.data);
      hasErrorFetchingGroomer(false);
      if (isUpdateForm.value) {
        selectedGroomer(groomerList.firstWhere((p0) => p0.id == bookingFormData.value.employeeId, orElse: () => EmployeeModel(profileImage: "".obs)));
        groomerCont.text = selectedGroomer.value.fullName;
      }
    }).onError((error, stackTrace) {
      hasErrorFetchingGroomer(true);
      errorMessageGroomer(error.toString());
      isLoading(false);
      // toast(error.toString());
    });
  }

  handleBookNowClick() {
    bookGroomingReq.additionalInfo = additionalInfoCont.text.trim();
    bookGroomingReq.totalAmount = totalAmount;
    bookGroomingReq.groomServiceId = selectedService.value.id;
    bookGroomingReq.serviceName = selectedService.value.name;
    bookGroomingReq.duration = selectedService.value.durationMin.toString();
    bookingSuccessDate("${bookGroomingReq.date} ${bookGroomingReq.time}".trim());
    log('BOOKBOARDINGREQ.TOJSON(): ${bookGroomingReq.toJson()}');
    hideKeyBoardWithoutContext();
    paymentController = PaymentController(bookingService: currentSelectedService.value);
    Get.to(() => const PaymentScreen());
  }
}
