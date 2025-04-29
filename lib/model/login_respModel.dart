class LoginResModel {
  String? userAcess;
  String? apkVersion;
  String? iPAVERSION;
  String? iSADMIN;
  bool? response;
  String? cpfNumber;
  String? token;
  int? updateRecord;
  dynamic sectionName;
  String? message;

  LoginResModel(
      {this.userAcess,
      this.apkVersion,
      this.iPAVERSION,
      this.iSADMIN,
      this.response,
      this.cpfNumber,
      this.token,
      this.updateRecord,
      this.sectionName,
      this.message});

  LoginResModel.fromJson(Map<String, dynamic> json) {
    userAcess = json['UserAcess'];
    apkVersion = json['Apk_version'];
    iPAVERSION = json['IPA_VERSION'];
    iSADMIN = json['ISADMIN'];
    response = json['Response'];
    cpfNumber = json['Cpf_Number'];
    token = json['token'];
    updateRecord = json['UpdateRecord'];
    sectionName = json['Section_Name'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserAcess'] = userAcess;
    data['Apk_version'] = apkVersion;
    data['IPA_VERSION'] = iPAVERSION;
    data['ISADMIN'] = iSADMIN;
    data['Response'] = response;
    data['Cpf_Number'] = cpfNumber;
    data['token'] = token;
    data['UpdateRecord'] = updateRecord;
    data['Section_Name'] = sectionName;
    data['Message'] = message;
    return data;
  }
}
