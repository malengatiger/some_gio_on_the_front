import 'package:flutter/material.dart';

import '../../../realm_data/data/countries/country_data.dart';

class CountrySearchWidget extends StatefulWidget {
  const CountrySearchWidget({Key? key}) : super(key: key);

  @override
  State<CountrySearchWidget> createState() => _CountrySearchWidgetState();
}

class _CountrySearchWidgetState extends State<CountrySearchWidget> {

  var countries = <Country>[];
  var countriesToDisplay = <Country>[];
  @override
  void initState() {
    super.initState();
  }
  Future _setTexts() async {

  }
  Future _getCountries() async {

  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
