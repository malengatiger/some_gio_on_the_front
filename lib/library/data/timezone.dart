class Timezone {
  String? zoneName;
  int? gmtOffset;
  String? gmtOffsetName;
  String? abbreviation;
  String? tzName;

  Timezone(this.zoneName, this.gmtOffset, this.gmtOffsetName, this.abbreviation,
      this.tzName);
  Timezone.fromJson(Map data) {
    zoneName = data['zoneName'];
    gmtOffset = data['gmtOffset'];
    abbreviation = data['abbreviation'];
    tzName = data['tzName'];
    //
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'zoneName': zoneName,
      'gmtOffset': gmtOffset,
      'abbreviation': abbreviation,
      'tzName': tzName,
    };
    return map;
  }
}