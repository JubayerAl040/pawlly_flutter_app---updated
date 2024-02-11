import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pawlly/main.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/screens/book_lawyer_screen.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/screens/book_pet_travel_screen.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/screens/book_photograph_screen.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/screens/book_taxi_screen.dart';

import '../../components/app_scaffold.dart';
import 'home_controller.dart';
import 'components/service_card.dart';
import '../booking_module/services/service_navigation.dart';
import '../dashboard/dashboard_res_model.dart';

class ChooseService extends StatelessWidget {
  ChooseService({Key? key}) : super(key: key);
  final HomeScreenController dashboardController = Get.find();
  @override
  Widget build(BuildContext context) {
    final List<Map> dummyData = [
      {
        'name': 'Taxi',
        'description': 'Reliable pet taxi: safe transport for your pet!',
        'img':
            'https://i.ibb.co/4Z9wzkK/9152d010-2a62-4fa7-bd74-d1ab398e07ed-1-removebg-preview.png',
      },
      {
        'name': 'Photography',
        'description': "Capture your pet's charm beautifully!",
        'img':
            'https://i.ibb.co/NFvKf4Q/412365774-386374887177449-7875267707700283037-n-removebg-preview.png',
      },
      {
        'name': 'Travel',
        'description':
            "Tailored pet travel experiences, ensuring joy on the go!",
        'img':
            'https://i.ibb.co/L5k5kR4/412085986-755892376567662-6533268400057984425-n-removebg-preview.png',
      },
      {
        'name': 'Lawyer',
        'description': "Protecting pet rights: legal advocacy for you.",
        'img':
            'https://i.ibb.co/NmZmxKF/412265801-1097167598107253-6882099999172725069-n-removebg-preview.png',
      },
    ];
    return AppScaffold(
      appBarTitle: Hero(
        tag: "choose_service",
        child: Text(
          locale.value.chooseService,
          style: primaryTextStyle(size: 18, decoration: TextDecoration.none),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            // services come from
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
                Wrap(
                  runSpacing: 16,
                  spacing: 16,
                  children: List.generate(
                    dashboardController
                        .dashboardData.value.systemService.length,
                    (index) {
                      SystemService service = dashboardController
                          .dashboardData.value.systemService[index];
                      return GestureDetector(
                        onTap: () {
                          navigateToService(dashboardController
                              .dashboardData.value.systemService[index]);
                        },
                        child: ServiceCard(
                          service: service,
                          width: Get.width / 2 - 24,
                          height: Get.width / 2 - 16,
                          showSubTexts: true,
                        ),
                      );
                    },
                  ),
                ).paddingSymmetric(horizontal: 16),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
                Wrap(
                  runSpacing: 16,
                  spacing: 16,
                  children: List.generate(
                    4,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BookTaxiScreen(
                                    img: dummyData[index]["img"]),
                              ),
                            );
                          } else if (index == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BookPhotographScreen(
                                      img: dummyData[index]["img"])),
                            );
                          } else if (index == 2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BookPetTravelScreen(
                                      img: dummyData[index]["img"])),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BookLawyerScreen(
                                      img: dummyData[index]["img"])),
                            );
                          }
                        },
                        child: ServiceCard(
                          dummy: dummyData[index]['name'],
                          service: SystemService(
                              description: dummyData[index]['description'],
                              serviceImage: dummyData[index]['img']),
                          width: Get.width / 2 - 24,
                          height: Get.width / 2 - 16,
                          showSubTexts: true,
                        ),
                      );
                    },
                  ),
                ).paddingSymmetric(horizontal: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
