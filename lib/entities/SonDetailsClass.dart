class SonDetails {
  int id;
  String name;
  String bornYear;
  String currentAge;
  String nextAge;
  SonDetails(
      {this.name, this.bornYear, this.currentAge, this.nextAge});

  SonDetails.parameters(
      String name, String bornYear, String currentAge, String nextAge) {
    this.name = name;
    this.bornYear = bornYear;
    this.currentAge = currentAge;
    this.nextAge = nextAge;
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name': name,
      'bornYear': bornYear,
      'currentAge': currentAge,
      'nextAge': nextAge,
    };
  }

  SonDetails.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.bornYear = map['bornYear'];
    this.currentAge = map['currentAge'];
    this.nextAge = map['nextAge'];
  }

}
