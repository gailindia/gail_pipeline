class GraphRespModel {
  String? nameSeqNo;
  String? inlet;
  String? flow;
  String? discharg;
  String? runningFlow;
  String? name;
  String ? timeStamp;
  String ?dates;
  String ?region;
  String? fedGasPR;
  String? fedGasVolume;
  String? fedGasCFour;
  String? plantLoadPercentage;
  String ?tAGTYPE;

  GraphRespModel({
    this.nameSeqNo,
    this.inlet,
    this.flow,
    this.discharg,
    this.runningFlow,
    this.name,
    this.timeStamp,
    this.dates,
    this.region,
    this.fedGasPR,
      this.fedGasVolume,
      this.fedGasCFour,
      this.plantLoadPercentage,
    this.tAGTYPE,
  });

  GraphRespModel.fromJson(Map<String, dynamic> json) {
    nameSeqNo = json['name_seq_no'];
    inlet = json['Inlet'] ?? '0';
    flow = json['Flow'] ?? '0';
    discharg = json['Discharg'] ?? '0';
    runningFlow = json['RunningFlow'] ?? '0';
    name = json['name'];
    timeStamp = json['TimeStamp'];
    dates = json['Dates'];
    region = json['Region'];
    fedGasPR = json['FedGas_PR'] ?? "0";
    fedGasVolume = json['FedGas_Volume'] ?? "0";
    fedGasCFour = json['FedGas_C_Four'] ?? "0";
    plantLoadPercentage = json['Plant_Load_Percentage'] ?? "0";
    tAGTYPE = json['TAG_TYPE'];
  }    
       
         

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_seq_no'] = nameSeqNo;
    data['Inlet'] = inlet;
    data['Flow'] = flow;
    data['Discharg'] = discharg;
    data['RunningFlow'] = runningFlow;
    data['name'] = name;
    data['TimeStamp'] = timeStamp;
    data['Dates'] = dates;
    data['Region'] = region;
    data['FedGas_PR'] = fedGasPR;
    data['FedGas_Volume'] = fedGasVolume;
    data['FedGas_C_Four'] = fedGasCFour;
    data['Plant_Load_Percentage'] = plantLoadPercentage;
    data['TAG_TYPE'] = tAGTYPE;
    return data;
  }
}
