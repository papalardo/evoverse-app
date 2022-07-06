class AccountModel {
  String walletAddress;
  num epw;
  num epwToClaim;
  num ekeyToClaim;
  num evs;
  num evsToClaim;
  num epwLastClaimDate;
  num evsLasClaimDate;
  num nonce;
  num lastEnergizeAll;
  bool busdApprove;
  num epwStaked;

  AccountModel({
    required this.walletAddress,
    required this.epw,
    required this.epwToClaim,
    required this.ekeyToClaim,
    required this.evs,
    required this.evsToClaim,
    required this.epwLastClaimDate,
    required this.evsLasClaimDate,
    required this.nonce,
    required this.lastEnergizeAll,
    required this.busdApprove,
    required this.epwStaked,
  });

  static fromJson(Map json) => AccountModel(
    walletAddress: json['WalletAddress'],
    epw: json['EPW'],
    epwToClaim: json['EPWToClaim'],
    ekeyToClaim: json['EKEYToClaim'],
    evs: json['EVS'],
    evsToClaim: json['EVSToClaim'],
    epwLastClaimDate: json['EPWLastClaimDate'],
    evsLasClaimDate: json['EVSLastClaimDate'],
    nonce: json['Nonce'],
    lastEnergizeAll: json['LastEnergizeAll'],
    busdApprove: json['BUSDApprove'],
    epwStaked: json['StakeEPW'],
  );
}