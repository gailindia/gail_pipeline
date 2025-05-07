 // // Beautify function
// String beautifyHeader(String text) {
//   return text.replaceAll('_', ' ').split(' ').map((word) =>
//       word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : ''
//   ).join(' ');
// }


 ////////**************** Suspicious data flag  ********//////////////////////
 final Map<String, List<String>> parameterCodeMap = {
  "COMP": ["INLTP", "OUTLP", "FLOW"],
  "INJT": ["INLTP", "FLOW"],
  "GPU": ["FDGPR", "FDGVL", "FDGCF", "PLTPN"],
  "EPP": ["EPPR", "EPFW"],
  "CSCP": ["PRSS", "CFLW"],
  "GASQ": ["GAC2", "GAC3", "GAC4"],
  "LPK": ["LNPK"],
  "RMXN": ["RLMIX"],
};

//////**** parameter to key map ********////////////
final Map<String, String> parameterCodeToFieldMap = {
  "FLOW": "Flow",
  "INLTP": "Inlet",
  "OUTLP": "Discharg",
  "FDGVL": "FedGas_Volume",
  "FDGCF": "FedGas_C_Four",
  "FDGPR": "FedGas_PR",
  "PLTPN": "Plant_Load_Percentage",
  "EPPR": "FedGas_PR",
  "EPFW": "FedGas_Volume",
  "PRSS": "FedGas_PR",
  "CFLW": "Flow",
  "GAC2": "FedGas_PR",
  "GAC3": "FedGas_Volume",
  "GAC4": "FedGas_C_Four",
  "LNPK": "FedGas_PR",
  "RLMIX": "FedGas_PR",

};


//////////////////////////// header data //////////////////////////////////////
final headersMap = {
  "COMP": ['Name', 'SP\n(Kg/cm2)', 'DP\n(Kg/cm2)', 'FR\n(KSCMH)'],
  "INJT": ['Name', 'Pressure\n(Kg/cm2)', 'Flow\n(KSCMH)'],
  "GPU": [
    'GAS\nPLANT',
    'PR\n(Kg/cm2)',
    'VOL\n(KSCMH)',
    'C2/C4\n(%)',
    'LOAD\n(%)',
  ],
  "EPP": ['Name', 'Region', 'Pressure\n(Kg/cm2)', 'Flow\n(KSCMH)'],
  "CSCP": ['Name', 'Pressure\n(Kg/cm2)', 'Flow\n(KSCMH)'],
  "GASQ": ['Plant', 'C2\n(%)', 'C3\n(%)', 'C4\n(%)'],
  "LPK": ['Name', 'Region', 'Vol\n(MMSCM)'],
  "RMXN": ['Name', 'Region', 'FLow\n(KSCMH)'],
};
 

/////////////////////////// row data /////////////////////////////////////
final rowMap = {
  "COMP": ['name', 'Inlet', 'Discharg', 'Flow'],
  "INJT": ['name', 'Inlet', 'Flow'],
  "GPU": [
    'name',
    'FedGas_PR',
    'FedGas_Volume',
    'FedGas_C_Four',
    'Plant_Load_Percentage',
  ],
  "EPP": ['name', 'Parameter_Code', 'FedGas_Volume', 'FedGas_PR'],
  "CSCP": ['name', 'FedGas_PR', 'FedGas_Volume'],
  "GASQ": ['name', 'FedGas_PR', 'FedGas_Volume', 'FedGas_C_Four'],
  "LPK": ['name', 'Parameter_Code', 'FedGas_PR'],
  "RMXN": ['name', 'Parameter_Code', 'FedGas_PR'],
};

//////////************* home type *************************////////////////////////
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
 String normalizeKey(dynamic value) {
  return (value ?? '').toString().toLowerCase().trim();
}
 