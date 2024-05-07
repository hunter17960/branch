class Branch {
  dynamic docId;
  int branchId;
  final int customNo;
  final String arabicName;
  final String arabicDescription;
  final String englishName;
  final String englishDescription;
  final String note;
  final String address;

  Branch({
    required this.branchId,
    required this.customNo,
    required this.arabicName,
    required this.arabicDescription,
    required this.englishName,
    required this.englishDescription,
    required this.note,
    required this.address,
  });

  Branch.empty({
    this.branchId = 0,
    this.customNo = 0,
    this.arabicName = '',
    this.arabicDescription = '',
    this.englishName = '',
    this.englishDescription = '',
    this.note = '',
    this.address = '',
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        branchId: json['branch id'],
        arabicName: json['arabic name'],
        arabicDescription: json['arabic description'],
        englishName: json['english name'],
        englishDescription: json['english description'],
        customNo: json['custom no'],
        note: json['note'],
        address: json['address'],
      );

  Map<String, dynamic> toJson() => {
        "branch id": branchId,
        "arabic name": arabicName,
        "arabic description": arabicDescription,
        "english name": englishName,
        "english description": englishDescription,
        "custom no": customNo,
        "note": note,
        "address": address,
      };
}
