class GetGasStationRespModel {
  String? nameSeqNo;
  String? inlet;
  String? flow;
  String? discharg;
  String? runningFlow;
  String? name;
  String? timeStamp;
  dynamic dates;
  String? region;
  String? type;
  String? machine;
  String? instantaneousSFGC;
  String? yesterdayAverage;
  String? parameterCode;
  String? fedGasPR;
  String? fedGasVolume;
  String? fedGasCFour;
  String? plantLoadPercentage;
  String? tAGTYPE;

  GetGasStationRespModel(
      {this.nameSeqNo,
      this.inlet,
      this.flow,
      this.discharg,
      this.runningFlow,
      this.name,
      this.timeStamp,
      this.dates,
      this.region,
      this.type,
      this.machine,
      this.instantaneousSFGC,
      this.yesterdayAverage,
      this.parameterCode,
      this.fedGasPR,
      this.fedGasVolume,
      this.fedGasCFour,
      this.plantLoadPercentage,
      this.tAGTYPE});

  GetGasStationRespModel.fromJson(Map<String, dynamic> json) {
    nameSeqNo = json['name_seq_no'];
    inlet = json['Inlet'];
    flow = json['Flow'];
    discharg = json['Discharg'];
    runningFlow = json['RunningFlow'];
    name = json['name'];
    timeStamp = json['TimeStamp'];
    dates = json['Dates'];
    region = json['Region'];
    type = json['Type'];
    machine = json['machine'];
    instantaneousSFGC = json['InstantaneousSFGC'];
    yesterdayAverage = json['YesterdayAverage'];
    parameterCode = json['Parameter_Code'];
    fedGasPR = json['FedGas_PR'];
    fedGasVolume = json['FedGas_Volume'];
    fedGasCFour = json['FedGas_C_Four'];
    plantLoadPercentage = json['Plant_Load_Percentage'];
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
    data['Type'] = type;
    data['machine'] = machine;
    data['InstantaneousSFGC'] = instantaneousSFGC;
    data['YesterdayAverage'] = yesterdayAverage;
    data['Parameter_Code'] = parameterCode;
    data['FedGas_PR'] = fedGasPR;
    data['FedGas_Volume'] = fedGasVolume;
    data['FedGas_C_Four'] = fedGasCFour;
    data['Plant_Load_Percentage'] = plantLoadPercentage;
    data['TAG_TYPE'] = tAGTYPE;
    return data;
  }
}
