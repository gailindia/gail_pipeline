class GetGasDataRespModel {
  String? rEGION;
  String? tYPE;
  String? nAME;
  String? pARAMETERCODE;
  String? tAGTYPE;

  GetGasDataRespModel(
      {this.rEGION, this.tYPE, this.nAME, this.pARAMETERCODE, this.tAGTYPE});

  GetGasDataRespModel.fromJson(Map<String, dynamic> json) {
    rEGION = json['REGION'];
    tYPE = json['TYPE'];
    nAME = json['NAME'];
    pARAMETERCODE = json['PARAMETER_CODE'];
    tAGTYPE = json['TAG_TYPE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['REGION'] = rEGION;
    data['TYPE'] = tYPE;
    data['NAME'] = nAME;
    data['PARAMETER_CODE'] = pARAMETERCODE;
    data['TAG_TYPE'] = tAGTYPE;
    return data;
  }
}
