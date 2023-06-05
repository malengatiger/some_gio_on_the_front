class Pricing {
  String? countryId, date;
  String? countryName, id;
  double? monthlyPrice, annualPrice;

  Pricing({
    required this.countryId,
    required this.date,
    required this.countryName,
    required this.monthlyPrice,
    this.id,
    this.annualPrice,
  });

  Pricing.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'] as String?;
    date = json['date'] as String?;
    id = json['id'];
    countryName = json['countryName'] as String?;
    monthlyPrice = json['monthlyPrice'] as double?;
    annualPrice = json['annualPrice'] as double?;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'countryId': countryId,
        'date': date,
        'id': id,
        'countryName': countryName,
        'monthlyPrice': monthlyPrice,
        'annualPrice': annualPrice,
      };
}
