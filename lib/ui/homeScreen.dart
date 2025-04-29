import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gail_pipeline/constants/app_constants.dart';
import 'package:gail_pipeline/controller/home_controller.dart';
import 'package:gail_pipeline/ui/table_dataScreen.dart';
import 'package:get/get.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  HomeController homeController = Get.put(HomeController());
  RxString selectedTitle = "Line Pack".obs;
  bool isDrawerOpen = false;
  int selectedIndex = 0;
  TabController? tabController;

  @override
  void initState() {
    homeController.getGasDataApi();
    homeController.getGasStaionApi();
    tabController = TabController(length: 2, vsync: this);
    super.initState();

    log("initState called");
  }

  Widget _buildMenuItem(String title) {
    return ListTile(
      title: Text(title, style: TextStyle(color: Colors.white)),
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      onTap: () {
        selectedTitle.value = title;
        setState(() => isDrawerOpen = false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // log("msg ${homeController.syncDate}");
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover),
      ),
      
      child: Obx(() {
        
        final filteredDataList = homeController.getGasStationRespModel
          ?.where((item) => item.type == mapTitleToType(selectedTitle.value))
          .toList() ?? [];
        log("filteredDataList **** ${filteredDataList.length}");
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset(kIconLogo),
            ),
            title: Text(
              selectedTitle.value.toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 15),
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
                  // homeController.getGasDataApi();
                },
              ),
              IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  setState(() {
                    isDrawerOpen = !isDrawerOpen;
                  });
                },
              ),
            ],
          ),
          body: Column(
            children: [
              AnimatedContainer(
                color: Colors.black,
                duration: Duration(milliseconds: 300),
                height: isDrawerOpen ? 400 : 0,
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
          
              // Actual content pushed below
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                    color: Colors.grey[300],
                    child: Text("Last sync on : ${homeController.syncDate}"),
                  ),
                  SizedBox(height: 10),
                ],
              ),
              selectedTitle.value == 'Compressor Station'
                  ? Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: TabBar(
                          indicatorColor: Colors.transparent,
                          unselectedLabelColor: Colors.black,
                          indicator: BoxDecoration(
                            color: Colors.redAccent.shade100,
                            shape: BoxShape.rectangle,
                          ),
                          controller: tabController,
                          tabs: [
                            Container(
                              width: double.infinity,
                              color: Colors.transparent,
                              child: Tab(text: 'DVPL-VDPL'),
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.transparent,
                              child: Tab(text: 'HVJ'),
                            ),
                          ],
                        ),
                      ),
                      //  Text("data")
                    ],
                  )
                  : SizedBox.shrink(),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                color: Colors.grey[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.circle, size: 10, color: Colors.red),
                    SizedBox(width: 5),
                    Text(
                      "Line Pack",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GasTableData( 
                // gasTableData: homeController.getGasStationRespModel?.map((e) => e.toJson()).toList() ?? [],
                gasTableData: filteredDataList.map((e) => e.toJson()).toList(),
                type: mapTitleToType(selectedTitle.value), 
               
                )
              ),
            ],
          ),
        );
      }),
    );
  }

  String mapTitleToType(String title) {
  const typeMap = {
    'Compressor Station': 'COMP',
    'Gas Injection': 'INJT',
    'GPU': 'GPU',
    'End Point Pressure': 'EPP',
    'Sectorwise Consumption': 'CSCP',
    'Gas Quality': 'GASQ',
    'Line Pack': 'LPK',
    'RLNG Mixing': 'RMXN',
  };

  return typeMap[title] ?? 'OTHER';  
}
}
