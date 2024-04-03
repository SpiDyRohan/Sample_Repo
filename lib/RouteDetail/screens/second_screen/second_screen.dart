import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_sample/RouteDetail/screens/second_screen/second_screen_controller.dart';
import 'package:get/get.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final controller = Get.put(SecondScreenController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(blurRadius: 1, color: Colors.white),
                BoxShadow(
                    blurStyle: BlurStyle.outer,
                    blurRadius: 2,
                    color: Colors.white10),
              ]),
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Individual Meetup",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    prefix: Icon(Icons.search),
                    suffix: Icon(Icons.mic),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)),
              ),
            ),
            SizedBox(
              height: 300,
              child: PageView.builder(
                onPageChanged: (value) {
                  controller.currentIndex.value = value;
                },
                scrollDirection: Axis.horizontal,
                itemCount: controller.list.value.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              controller.list.value[index].imgPath,
                              width: Get.width,
                              height: 300,
                              fit: BoxFit.fill,
                            )),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(controller.list.value[index].name,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 30,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.list.value.length,
                itemBuilder: (context, index) {
                  return Obx(() => Container(
                        height: 10,
                        width: 10,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: controller.currentIndex.value == index
                                ? Color(0xFF4472c4)
                                : Color(0xFF4472c4).withOpacity(.5),
                            borderRadius: BorderRadius.circular(10)),
                      ));
                },
              ),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Trending Popular People"),
                )),

          ],
        ),
      ),
    );
  }
}
