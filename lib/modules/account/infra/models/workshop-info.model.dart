class WorkshopInfoModel {
  int hexToolkitsTotal;
  int commonToolkitsTotal;
  int genesisToolkitsTotal;
  num eKeysToClaim;
  num epwToClaim;
  num eKeys;
  num evs;
  num epw;

  WorkshopInfoModel({
    required this.hexToolkitsTotal,
    required this.commonToolkitsTotal,
    required this.genesisToolkitsTotal,
    required this.eKeysToClaim,
    required this.epwToClaim,
    required this.eKeys,
    required this.evs,
    required this.epw,
  });

  factory WorkshopInfoModel.fromJson(Map json) => WorkshopInfoModel(
    hexToolkitsTotal: json["BlendToolkits"],
    commonToolkitsTotal: json["Toolkits"],
    genesisToolkitsTotal: json["GenesisToolkits"],
    eKeysToClaim: json["EKEYToClaim"],
    epwToClaim: json["EPWToClaim"],
    eKeys: json["EKEYs"],
    evs: json["EVS"],
    epw: json["EPW"],
  );

}