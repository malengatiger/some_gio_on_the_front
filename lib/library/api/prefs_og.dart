import 'dart:convert';

import 'package:geo_monitor/library/data/questionnaire.dart';
import 'package:geo_monitor/library/data/subscription.dart';
import 'package:get_storage/get_storage.dart';
import 'package:realm/realm.dart';

import '../data/country.dart';
import '../data/project.dart';
import '../data/settings_model.dart';
import '../data/user.dart' as old;
import '../functions.dart';
import '../../../realm_data/data/schemas.dart' as mrm;

late PrefsOGx prefsOGx;
const String cacheName = 'GeoPreferences3';

class PrefsOGx {
  static const mm = '🔶🔶🔶🔶🔶🔶 PrefsOGx 🔶🔶 : ',
      bb = '🦠🦠🦠🦠🦠🦠🦠 PrefsOGx  🦠: ';

  final GetStorage box = GetStorage(cacheName);

  Future setDateRefreshed(String date) async {
    await box.write('dateRefreshed', date);
    pp("$mm setDateRefreshed SET to $date");
    return null;
  }

  Future<bool> shouldRefreshBePerformed() async {
    var refreshDate = await _getDateRefreshed();
    final rDate = DateTime.parse(refreshDate);
    final now = DateTime.now();
    final delta = now.difference(rDate).inHours;
    if (delta >= 12) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> _getDateRefreshed() async {
    pp('$mm ......... getting getDateRefreshed from cache! ...');
    String? date = box.read('dateRefreshed');
    if (date == null) {
      pp('$mm Date Refreshed does not exist in Prefs, '
          'create date from a year ago, just for kicks! 🍎🍎🍎!');
      date =
          DateTime.now().subtract(const Duration(days: 365)).toIso8601String();
      return date;
    } else {
      pp("$mm _getDateRefreshed: 🧩 🧩 🧩 🧩 🧩 date .. $date 🔴🔴");
      return date;
    }
  }

  Future setFCMSubscriptionFlag() async {
    await box.write('fcm', true);
    pp("\n\n$mm setFCMSubscription SET as true\n");
    return null;
  }

  Future resetFCMSubscriptionFlag() async {
    await box.write('fcm', false);
    pp("\n\n$mm setFCMSubscription RESET to false\n");
    return null;
  }

  Future<bool> getFCMSubscriptionFlag() async {
    pp('\n$mm ......... getting getFCMSubscription from cache! ...');
    bool? isSubscribed = box.read('fcm');
    if (isSubscribed == null || isSubscribed == false) {
      pp('$mm FCMSubscription flag does not exist in Prefs, '
          'one time isSubscribed, 🍎🍎🍎 next time not so much!');
      return false;
    } else {
      pp("$mm FCMSubscription flag: 🧩 🧩 🧩 🧩 🧩 retrieved .. $isSubscribed 🔴🔴");
      return isSubscribed;
    }
  }

  Future saveUser(old.User user) async {
    final s = jsonEncode(user.toJson());
    await box.write('user', s);
    pp("\n\n$mm saveUser SAVED: 🌽 ${user.name}\n");
    return null;
  }

  Future<old.User?> getUser() async {
    old.User? user;
    var mJson = box.read('user');
    if (mJson == null) {
      pp('$mm User does not exist in Prefs, '
          ' 🍎🍎🍎');
      return null;
    } else {
      user = old.User.fromJson(jsonDecode(mJson));
      // pp("$mm getUser 🧩🧩🧩🧩🧩 retrieved .. ${user.name}  🔴🔴");
      return user;
    }
  }

  Future saveSettings(SettingsModel settings) async {
    final s = jsonEncode(settings.toJson());
    await box.write('settings', s);
    pp("\n\n$mm saveSettings SAVED: 🌽 ${settings.toJson()}\n");
    return null;
  }

  Future<SettingsModel> getSettings() async {
    SettingsModel? settings;
    var mJson = box.read('settings');
    if (mJson == null) {
      pp('$mm Settings does not exist in Prefs, '
          ' 🍎🍎🍎 return default');
      var s = getBaseSettings();
      return s;
    } else {
      settings = SettingsModel.fromJson(jsonDecode(mJson));
      // pp("$mm getSettings 🧩🧩🧩🧩🧩 retrieved .. ${settings.created}  🔴🔴");
      return settings;
    }
  }

  Future deleteUser() async {
    await box.remove('user');
  }

  Future saveCountry(mrm.Country c) async {
    var b = {
      'name': c.name,
      'countryId': c.countryId,
      'emoji': c.emoji,
      'currencySymbol': c.currencySymbol,
      'currency': c.currency,
      'currencyName': c.currencyName,
      'region': c.region,
      'subregion': c.subregion,
      'latitude': c.latitude,
      'longitude': c.longitude,
      'iso2': c.iso2,
      'iso3': c.iso3,
      'capital': c.capital,
      'population': c.population,
    };
    final s = jsonEncode(b);
    pp("$mm saveCountry to save: 🌽 $s\n");

    await box.write('country', s);
    pp("\n\n$mm saveCountry SAVED: 🌽 ${c.name}\n");
    return null;
  }

  Future<mrm.Country?> getCountry() async {
    mrm.Country? country;
    var mJson = box.read('country');
    if (mJson == null) {
      pp('$mm User does not exist in Prefs, '
          ' 🍎🍎🍎');
      return null;
    } else {
      var c = mrm.Country(
        ObjectId(),
        name: mJson['name'],
        countryId: mJson['countryId'],
        emoji: mJson['emoji'],
        currencySymbol: mJson['currencySymbol'],
        currency: mJson['currency'],
        currencyName: mJson['currencyName'],
        region: mJson['region'],
        subregion: mJson['subregion'],
        latitude: mJson['latitude'],
        longitude: mJson['longitude'],
        iso2: mJson['iso2'],
        iso3: mJson['iso3'],
        capital: mJson['capital'],
        population: mJson['population'],
      );
      pp("$mm getCountry 🧩🧩🧩🧩🧩 retrieved .. ${c.name}  🔴🔴");
      return c;
    }
  }

  Future saveProject(mrm.Project project) async {
    final s = {
      "name": project.name,
      'projectId': project.projectId,
      'organizationId': project.organizationId,
      'created': project.created,
      '': project.description,
    };
    pp("$mm saveProject to save: 🌽 $s\n");

    await box.write('project', s);
    pp("\n\n$mm saveProject SAVED: 🌽 ${project.name}\n");
    return null;
  }

  Future<mrm.Project?> getProject() async {
    mrm.Project? project;
    var mJson = box.read('project');
    if (mJson == null) {
      pp('$mm project does not exist in Prefs, '
          ' 🍎🍎🍎');
      return null;
    } else {
      project = mrm.Project(ObjectId(),
          name: mJson['name'],
          projectId: mJson['projectId'],
          organizationId: mJson['organizationId'],
          created: mJson['created']);

      pp("$mm getProject 🧩🧩🧩🧩🧩 retrieved .. ${project.name}  🔴🔴");
      return project;
    }
  }

  Future saveGioSubscription(GioSubscription subscription) async {
    final s = jsonEncode(subscription.toJson());
    await box.write('GioSubscription', s);
    pp("\n\n$mm saveGioSubscription SAVED: 🌽 ${subscription.organizationName}\n");
    return null;
  }

  Future<GioSubscription?> getGioSubscription() async {
    GioSubscription? sub;
    var mJson = box.read('GioSubscription');
    if (mJson == null) {
      pp('$mm GioSubscription does not exist in Prefs, '
          ' 🍎🍎🍎');
      return null;
    } else {
      sub = GioSubscription.fromJson(jsonDecode(mJson));
      pp("$mm getGioSubscription 🧩🧩🧩🧩🧩 retrieved .. ${sub.organizationName}  🔴🔴");
      return sub;
    }
  }

  Future saveLastRefresh() async {
    LastRefresh lastRefresh = LastRefresh(
        DateTime.now().toUtc().microsecondsSinceEpoch,
        DateTime.now().toUtc().toIso8601String());

    final s = jsonEncode(lastRefresh.toJson());
    await box.write('LastRefresh', s);
    pp("\n\n$mm saveLastRefresh SAVED: 🌽 ${lastRefresh.stringDate}\n");
    return null;
  }

  Future<LastRefresh> getLastRefresh() async {
    LastRefresh? sub;
    var mJson = box.read('LastRefresh');
    if (mJson == null) {
      pp('$mm LastRefresh does not exist in Prefs, '
          ' 🍎🍎🍎');
      final sett = await getSettings();
      var dur = Duration(days: sett.numberOfDays! + 1);
      final lastRefresh = LastRefresh(
          DateTime.now().subtract(dur).toUtc().millisecondsSinceEpoch,
          DateTime.now().subtract(dur).toUtc().toIso8601String());
      return lastRefresh;
    } else {
      sub = LastRefresh.fromJson(jsonDecode(mJson));
      pp("$mm getLastRefresh 🧩🧩🧩🧩🧩 retrieved .. ${sub.toJson()}  🔴🔴");
      return sub;
    }
  }
}

class LastRefresh {
  late int intDate;
  late String stringDate;

  LastRefresh(this.intDate, this.stringDate);
  LastRefresh.fromJson(Map data) {
    intDate = data['intDate'];
    stringDate = data['stringDate'];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'intDate': intDate,
      'stringDate': stringDate,
    };
    return map;
  }
}
