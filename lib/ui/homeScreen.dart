import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gail_pipeline/constants/app_constants.dart';
import 'package:gail_pipeline/controller/home_controller.dart';
import 'package:gail_pipeline/ui/graphScreen.dart';
import 'package:gail_pipeline/ui/mapType.dart';
import 'package:gail_pipeline/ui/table_dataScreen.dart';
import 'package:gail_pipeline/utils/logout_dialog.dart';
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
  RxString selectedSubType = 'DVPL-VDPL'.obs;
  RxString selectedSectorType = 'CGD'.obs;
  bool isDrawerOpen = false;
  int selectedIndex = 0;
  TabController? tabController;
  bool showGraph = false;

  @override
  void initState() {
    homeController.getGasDataApi();
    homeController.getGasStaionApi();
    tabController = TabController(length: 2, vsync: this);
    tabController?.addListener(() {
      if (tabController!.indexIsChanging) {
        selectedSubType.value = tabController?.index == 0 ? 'DVPL-VDPL' : 'HVJ';
      }
    });
    super.initState();

    // log("initState called");
  }

  Widget _buildMenuItem(String title) {
    // log("title ** $title");
    return ListTile(
      selectedColor: Color(0xffBCBCBC),
      title: Text(title, style: TextStyle(color: Color(0xffBCBCBC))),
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      onTap: () {
        if(title == "Log Out"){ 
          logout(context);
        setState(() => isDrawerOpen = false);

        } else{
          selectedTitle.value = title;
        setState(() => isDrawerOpen = false);
        }
        
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover),
      ),

      child:  Scaffold(
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
          body: Obx( () {
              if (homeController.isLoading.value) {
         return  const Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        CircularProgressIndicator(),
        SizedBox(height: 12),
        Text(
          'Loading gas station data...',
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
      ],
    ),
  );
  }   
        final String currentType = mapTitleToType(selectedTitle.value);
        final String subRegion = selectedSubType.value;
        // final String sectRegion = selectedSectorType.value;
    //     homeController.getGasStationRespModel
    // ?.where((e) => e.type == 'CSCP')
    // .forEach((e) => log('region for CSCP: ${e.region}'));

        final filteredDataList =
            homeController.getGasStationRespModel.value.where((item) {
              if (currentType == 'COMP') {
                return item.type == currentType && item.region == subRegion;
              } 
              //  else if(currentType == 'CSCP'){
                
              //   return item.type == currentType && item.region == sectRegion ;
              // }
              else {
                return item.type == currentType;
              }
            }).toList() ??
            [];
      //  log("msg selectedSectorType $currentType  000 $sectRegion");
       log("msg filteredDataList obx******* &&& ${filteredDataList.length}");
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
        log(
          "filteredDataList **** ${dataKeys.length} %%% ${selectedTitle.value}",
        );
              return Column(
                children: [
                  AnimatedContainer(
                    color: Color(0xff282824),
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
                          // decoration: BoxDecoration(
                          //   color:Colors.white// background of whole tab bar
                          // ),
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: TabBar(
                            controller: tabController,
                            isScrollable: false,
                            labelPadding: EdgeInsets.zero,
                            unselectedLabelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                            labelStyle: TextStyle(fontWeight: FontWeight.w500),
                            labelColor: Color(
                              0xff8c1818,
                            ),  
                            unselectedLabelColor:
                                Colors.black, 
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
                  InkWell(
                    onTap: () {
                      setState(() {
                        showGraph = false;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 8, ),
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      color: Color(0xffCCCCCC),
                      child: Column( 
                        children: [ 
                          Text(
                            "Trunk".toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.w500,color: Color(0xff8c1818)),
                          ),
                          Container(
                            width: double.infinity,
                            height: 6,
                            color: Color(0xff8c1818),
                          )
                        ],
                      ),
                    ),
                  ),
                  !showGraph
                            ?
                  Container(
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
              
                  // ////////////////////// CGD ///////////////////////////////
                  // InkWell(
                  //   onTap: () {
                   
                  //       // showGraph = false;
                  //       selectedSectorType.value = "CGD";
                    
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     alignment: Alignment.center,
                  //     padding: EdgeInsets.only(top: 8, ),
                  //     margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  //     color: Color(0xffCCCCCC),
                  //     child: Column( 
                  //       children: [ 
                  //         Text(
                  //           "CGD".toUpperCase(),
                  //           style: TextStyle(fontWeight: FontWeight.w500,color: Color(0xff8c1818)),
                  //         ),
                  //         Container(
                  //           width: double.infinity,
                  //           height: 6,
                  //           color: Color(0xff8c1818),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  //     /////////////////////////////// Fertiliser ////////////////////////////////////
                  //      InkWell(
                  //   onTap: () {
                      
                  //       // showGraph = false;
                  //       selectedSectorType.value = "Fertiliser";
                     
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     alignment: Alignment.center,
                  //     padding: EdgeInsets.only(top: 8, ),
                  //     margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  //     color: Color(0xffCCCCCC),
                  //     child: Column( 
                  //       children: [ 
                  //         Text(
                  //           "Fertiliser",
                  //           style: TextStyle(fontWeight: FontWeight.w500,color: Color(0xff8c1818)),
                  //         ),
                  //         Container(
                  //           width: double.infinity,
                  //           height: 6,
                  //           color: Color(0xff8c1818),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
              
                  // //////////////////////////******************** power ****************///////////////////
                  //  InkWell(
                  //   onTap: () {
                       
                  //       // showGraph = false;
                  //       selectedSectorType.value = "Power";
                    
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     alignment: Alignment.center,
                  //     padding: EdgeInsets.only(top: 8, ),
                  //     margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  //     color: Color(0xffCCCCCC),
                  //     child: Column( 
                  //       children: [ 
                  //         Text(
                  //           "Power",
                  //           style: TextStyle(fontWeight: FontWeight.w500,color: Color(0xff8c1818)),
                  //         ),
                  //         Container(
                  //           width: double.infinity,
                  //           height: 6,
                  //           color: Color(0xff8c1818),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
              
                   
                  //   Expanded(
                  //     child: GasTableData(
                  //       // gasTableData: homeController.getGasStationRespModel?.map((e) => e.toJson()).toList() ?? [],
                  //       gasTableData:
                  //           filteredDataList.map((e) => e.toJson()).toList(),
                  //       type: mapTitleToType(selectedTitle.value),
                  //     ),
                  //   ),
                  // Container(
                  //   height: 300,
                  //    margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  //   child: GasInjectionGraph(
                  //   // title: 'Flow Graph',
                  //   // lineColor: Colors.red,
                  //   // yUnit: 'KSCMH',
                  //   graphRespModel:  homeController.getGraphRespModel ?? [],
                  //   ),
                  // )
                  Expanded(
                    child:
                        showGraph
                            ? ListView.builder(
                              itemCount: dataKeys.length,
                              shrinkWrap: true,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final key = dataKeys[index];
                                // log("key **** $index");
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
                                            : Color(
                                              0xff5A4B73,
                                            ), // Blue for even index
              
                                    // Orange for odd index
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
                                getGasData: homeController.getGasDataRespModel != null || homeController.getGasDataRespModel!.isNotEmpty  ?  homeController.getGasDataRespModel!.map((g) => g.toJson()).toList() : [],
                                gasTableData:
                                    filteredDataList
                                        .map((e) => e.toJson())
                                        .toList(),
                                type: mapTitleToType(selectedTitle.value),
                                onRowSelected: (item) async {
                                 
                                    // log("item**** $item");
                                    homeController.name.value = item['name'];
                                    homeController.region.value = item['Region'];
                                    homeController.type.value = item['Type'];
                                    await homeController.getGraphApi();
                                    // log("gest onRowselectd ${selectedTitle.value}");
                                    setState(() {
                                      homeController.getGraphRespModel;
                                      showGraph = true;
                                    });
                                 
                                },
                              ),
                            ),
                  ),
                ],
              );
            }
          ),
        )
    );
      
    
  }


 
}
