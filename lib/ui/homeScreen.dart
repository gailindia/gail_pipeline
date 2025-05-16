import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gail_pipeline/constants/app_constants.dart';
import 'package:gail_pipeline/controller/home_controller.dart';
import 'package:gail_pipeline/ui/graphScreen.dart';
import 'package:gail_pipeline/ui/mapType.dart';
import 'package:gail_pipeline/ui/table_dataScreen.dart';
import 'package:gail_pipeline/utils/logout_dialog.dart';
import 'package:gail_pipeline/widgets/homeBoxWidget.dart';
import 'package:gail_pipeline/widgets/styles/mytextStyle.dart';
import 'package:get/get.dart';

class Homescreen extends StatefulWidget {
  
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  HomeController homeController = Get.find<HomeController>();
  // RxString selectedTitle = "Line Pack".obs;
  ValueNotifier<String> selectedTitle = ValueNotifier("Line Pack");
  RxString selectedSubType = 'DVPL-VDPL'.obs;
  RxString selectedSectorType = 'CGD'.obs;
  RxBool isDrawerOpen = false.obs;
  int selectedIndex = 0;
  TabController? tabController;
  RxBool showGraph = false.obs;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController?.addListener(() {
      if (tabController!.indexIsChanging) {
        selectedSubType.value = tabController?.index == 0 ? 'DVPL-VDPL' : 'HVJ';
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.getGasStaionApi();
      homeController.getGasDataApi();
    });
    super.initState();
  }

  Widget _buildMenuItem(String title) {
    return ListTile(
      selectedColor: Color(0xffBCBCBC),
      title: Text(title, style: TextStyle(color: Color(0xffBCBCBC))),
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      onTap: () {
        if (title == "Log Out") {
          logout(context);
          // setState(() =>
          isDrawerOpen.value = false;
          //  );
        } else {
          selectedTitle.value = title;
          log("else seleted ${selectedTitle.value}");
          // setState(() =>
          isDrawerOpen.value = false;
          // );
        }
      },
    );
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Image.asset(kIconLogo),
          ),
          title: ValueListenableBuilder<String>(
            valueListenable: selectedTitle,
            builder:
                (context, value, _) => Text(
                  value.toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
          ), 
          actions: [
            IconButton(
              icon: Image.asset(
                refreshIcon,
                height: 25,
                width: 25,
                fit: BoxFit.cover,
              ),
              onPressed: () {
                homeController.getGasStaionApi();
              },
            ),
            IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                // setState(() {
                isDrawerOpen.value = !isDrawerOpen.value;
                // });
              },
            ),
          ],
        ),
        body: Obx(() {
          if (homeController.isLoading.value) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text(
                    'Loading gas station data...',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            );
          }
          final String currentType = mapTitleToType(selectedTitle.value);
          final String subRegion = selectedSubType.value;
          final String sectRegion = selectedSectorType.value;
          homeController.getGasStationRespModel
              .where((e) => e.type == 'CSCP')
              .forEach((e) => log('region for CSCP: ${e.region}'));

          final filteredDataList =
              homeController.getGasStationRespModel.value.where((item) {
                if (currentType == 'COMP') {
                  return item.type == currentType && item.region == subRegion;
                } else if (currentType == 'CSCP') {
                  return item.type == currentType && item.region == sectRegion;
                } else {
                  return item.type == currentType;
                }
              }).toList() ??
              [];
          final dataKeys =
              rowMap[currentType]
                  ?.where(
                    (key) =>
                        key.toLowerCase() != 'name' &&
                        key.toLowerCase() != 'parameter_code',
                  )
                  .toList() ??
              [];
          if (filteredDataList.isEmpty) {
            return const Center(child: Text("No Data Available"));
          }
          return Column(
            children: [
              AnimatedContainer(
                color: Color(0xff282824),
                duration: Duration(milliseconds: 300),
                height: isDrawerOpen.value ? 400 : 0,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildMenuItem('Compressor Station'),
                      _buildMenuItem('Gas Injection'),
                      _buildMenuItem('GPU'),
                      _buildMenuItem('End Point Pressure'),
                      _buildMenuItem('Sectorwise Consumption'),
                      _buildMenuItem('Gas Quality'),
                      _buildMenuItem('Line Pack'),
                      _buildMenuItem('RLNG Mixing'),
                      _buildMenuItem('Log Out'),
                    ],
                  ),
                ),
              ),

              Column(
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    color: Color(0xffCCCCCC),
                    child: Text(
                      "Last sync on : ${homeController.syncDate}",
                      style: TextStyle(
                        color: Color(0xff8c1818),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
              selectedTitle.value == 'Compressor Station'
                  ? PreferredSize(
                    preferredSize: Size.fromHeight(35),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: TabBar(
                        controller: tabController,
                        isScrollable: false,
                        labelPadding: EdgeInsets.zero,
                        unselectedLabelStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                        labelColor: Color(0xff8c1818),
                        unselectedLabelColor: Colors.black,
                        indicatorColor: Color(0xff8c1818),
                        indicatorWeight: 2.0,
                        dividerColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: List.generate(2, (index) {
                          return Tab(
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              color:
                                  tabController!.index == index
                                      ? Color(0xfff0f0f0)
                                      : Color(0xffa4a0a0),
                              child: Text(index == 0 ? 'DVPL-VDPL' : 'HVJ'),
                            ),
                          );
                        }),
                      ),
                    ),
                  )
                  : SizedBox.shrink(),

              // ////////////////////// CSCP ///////////////////////////////
              selectedTitle.value == 'Sectorwise Consumption'
                  ? Column(
                    children: [
                      ///////////////////////////////// CGD ////////////////////////////////////
                      Homeboxwidget(
                        onTapCall: () {
                          selectedSectorType.value = "CGD";
                          showGraph.value = false;
                        },
                        txtTitle: "CGD".toUpperCase(),
                      ),

                      // /////////////////////////////// Fertiliser ////////////////////////////////////
                      Homeboxwidget(
                        onTapCall: () {
                          selectedSectorType.value = "Fertiliser";
                          showGraph.value = false;
                        },
                        txtTitle: "Fertiliser",
                      ),

                      // /////////////////////////////// Power ////////////////////////////////////
                      Homeboxwidget(
                        onTapCall: () {
                          selectedSectorType.value = "Power";
                          showGraph.value = false;
                        },
                        txtTitle: "Power",
                      ),
                    ],
                  )
                  : SizedBox.shrink(),

              selectedTitle.value != 'Compressor Station' &&
                      selectedTitle.value != 'Sectorwise Consumption'
                  ? Homeboxwidget(
                    onTapCall: () {
                      showGraph.value = false;
                    },
                    txtTitle: "Trunk".toUpperCase(),
                  )
                  : SizedBox.shrink(),

              !showGraph.value
                  ? Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    color: Color(0xffCCCCCC),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.circle, size: 10, color: Color(0xff8c1818)),
                        SizedBox(width: 5),
                        Text(
                          "Table View",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                  : SizedBox.shrink(),
              Expanded(
                child:
                    showGraph.value
                        ? ListView.builder(
                          itemCount: dataKeys.length,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final key = dataKeys[index];
                            log("key  graph **** $key");
                            return Container(
                              height: 360,
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 16,
                              ),
                              child: GasInjectionGraph(
                                graphRespModel:
                                    homeController.getGraphRespModel ?? [],
                                dataKey: key,
                                areaColor:
                                    index % 2 == 0
                                        ? Color(0xffC6735F)
                                        : Color(0xff5A4B73),
                              ),
                            );
                          },
                        )
                        : Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 20,
                          ),
                          child: GasTableData(
                            getGasData:
                                (homeController
                                            .getGasDataRespModel
                                            ?.isNotEmpty ??
                                        false)
                                    ? (homeController.getGasDataRespModel ?? [])
                                        .map((g) => g.toJson())
                                        .toList()
                                    : [],
                            gasTableData:
                                filteredDataList
                                    .map((e) => e.toJson())
                                    .toList(),
                            type: mapTitleToType(selectedTitle.value),
                            onRowSelected: (item) async {
                              if (selectedTitle.value != 'Compressor Station') {
                                homeController.name.value = item['name'];
                                homeController.region.value = item['Region'];
                                homeController.type.value = item['Type'];

                                await homeController.getGraphApi();
                                // setState(() {
                                homeController.getGraphRespModel;
                                showGraph.value = true;
                                // });
                              }
                            },
                          ),
                        ),
              ),
              SizedBox(height: 10),
                Text.rich(
            TextSpan(
              text: 'Red Colour ',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600),
              children: <InlineSpan>[
                TextSpan(
                  text: ': Suspicious Data',
                  style: txtStyleWhite,
                )
              ]
            )
          ),

              SizedBox(height: 15),
            ],
          );
        }),
      ),
    );
  }
}
