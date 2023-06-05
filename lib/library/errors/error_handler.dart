
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:geo_monitor/device_location/device_location_bloc.dart';

import 'package:geo_monitor/library/api/prefs_og.dart';

import '../bloc/geo_exception.dart';
import '../functions.dart';

late ErrorHandler errorHandler;

class ErrorHandler {
  static const mm = '👿👿👿👿👿👿👿ErrorHandler: 👿👿';

  final DeviceLocationBloc locationBloc;
  final PrefsOGx prefsOGx;

  ErrorHandler(
    this.locationBloc,
    this.prefsOGx,
  );

  Future handleError({required GeoException exception}) async {
    // pp('$mm handleError, will save the error in cache until it can be downloaded: ... $exception');

    // var deviceData = <String, dynamic>{};
    // final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    // String? deviceType;
    // Position? errorPosition;
    // try {
    //   final loc = await locationBloc.getLocation();
    //   errorPosition = Position(
    //       coordinates: [loc!.longitude!, loc.latitude!], type: 'Point');
    //   if (kIsWeb) {
    //     deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
    //   } else {
    //     if (Platform.isAndroid) {
    //       deviceData =
    //           _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    //       deviceType = 'Android';
    //     } else if (Platform.isIOS) {
    //       deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    //       deviceType = 'iOS';
    //     } else if (Platform.isLinux) {
    //       deviceData = _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);
    //     } else if (Platform.isMacOS) {
    //       deviceData = _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
    //     }
    //   }
    //   pp('$mm setting up AppError; deviceData: $deviceData}');
    //   final user = await prefsOGx.getUser();
    //   if (user != null) {
    //     final ae = AppError(
    //       errorMessage: exception.toString(),
    //       model: deviceData['model'],
    //       created: DateTime.now().toUtc().toIso8601String(),
    //       userId: user!.userId,
    //       userName: user.name,
    //       errorPosition: errorPosition,
    //       versionCodeName: deviceData['versionCodeName'],
    //       manufacturer: deviceData['manufacturer'],
    //       brand: deviceData['brand'],
    //       organizationId: user.organizationId,
    //       uploadedDate: null,
    //       baseOS: deviceData['baseOS'],
    //       deviceType: deviceType,
    //       userUrl: user.thumbnailUrl,
    //       iosSystemName: deviceData['systemName'],
    //       iosName: deviceData['iosName'],
    //     );
    //
    //     await cacheManager.addAppError(appError: ae);
    //   }
    // } on PlatformException {
    //   deviceData = <String, dynamic>{
    //     'Error:': 'Failed to get platform version.'
    //   };
    // }
  }

  // Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  //   return <String, dynamic>{
  //     'version.securityPatch': build.version.securityPatch,
  //     'version.sdkInt': build.version.sdkInt,
  //     'version.release': build.version.release,
  //     'version.previewSdkInt': build.version.previewSdkInt,
  //     'version.incremental': build.version.incremental,
  //     'version.codename': build.version.codename,
  //     'version.baseOS': build.version.baseOS,
  //     'board': build.board,
  //     'bootloader': build.bootloader,
  //     'brand': build.brand,
  //     'device': build.device,
  //     'display': build.display,
  //     'fingerprint': build.fingerprint,
  //     'hardware': build.hardware,
  //     'host': build.host,
  //     'id': build.id,
  //     'manufacturer': build.manufacturer,
  //     'model': build.model,
  //     'product': build.product,
  //     'supported32BitAbis': build.supported32BitAbis,
  //     'supported64BitAbis': build.supported64BitAbis,
  //     'supportedAbis': build.supportedAbis,
  //     'tags': build.tags,
  //     'type': build.type,
  //     'isPhysicalDevice': build.isPhysicalDevice,
  //     'systemFeatures': build.systemFeatures,
  //     'displaySizeInches':
  //         ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
  //     'displayWidthPixels': build.displayMetrics.widthPx,
  //     'displayWidthInches': build.displayMetrics.widthInches,
  //     'displayHeightPixels': build.displayMetrics.heightPx,
  //     'displayHeightInches': build.displayMetrics.heightInches,
  //     'displayXDpi': build.displayMetrics.xDpi,
  //     'displayYDpi': build.displayMetrics.yDpi,
  //     'serialNumber': build.serialNumber,
  //   };
  // }
  //
  // Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
  //   return <String, dynamic>{
  //     'name': data.name,
  //     'systemName': data.systemName,
  //     'systemVersion': data.systemVersion,
  //     'model': data.model,
  //     'localizedModel': data.localizedModel,
  //     'identifierForVendor': data.identifierForVendor,
  //     'isPhysicalDevice': data.isPhysicalDevice,
  //     'utsname.sysname:': data.utsname.sysname,
  //     'utsname.nodename:': data.utsname.nodename,
  //     'utsname.release:': data.utsname.release,
  //     'utsname.version:': data.utsname.version,
  //     'utsname.machine:': data.utsname.machine,
  //   };
  // }
  //
  // Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
  //   return <String, dynamic>{
  //     'name': data.name,
  //     'version': data.version,
  //     'id': data.id,
  //     'idLike': data.idLike,
  //     'versionCodename': data.versionCodename,
  //     'versionId': data.versionId,
  //     'prettyName': data.prettyName,
  //     'buildId': data.buildId,
  //     'variant': data.variant,
  //     'variantId': data.variantId,
  //     'machineId': data.machineId,
  //   };
  // }
  //
  // Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo data) {
  //   return <String, dynamic>{
  //     'browserName': describeEnum(data.browserName),
  //     'appCodeName': data.appCodeName,
  //     'appName': data.appName,
  //     'appVersion': data.appVersion,
  //     'deviceMemory': data.deviceMemory,
  //     'language': data.language,
  //     'languages': data.languages,
  //     'platform': data.platform,
  //     'product': data.product,
  //     'productSub': data.productSub,
  //     'userAgent': data.userAgent,
  //     'vendor': data.vendor,
  //     'vendorSub': data.vendorSub,
  //     'hardwareConcurrency': data.hardwareConcurrency,
  //     'maxTouchPoints': data.maxTouchPoints,
  //   };
  // }
  //
  // Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo data) {
  //   return <String, dynamic>{
  //     'computerName': data.computerName,
  //     'hostName': data.hostName,
  //     'arch': data.arch,
  //     'model': data.model,
  //     'kernelVersion': data.kernelVersion,
  //     'osRelease': data.osRelease,
  //     'activeCPUs': data.activeCPUs,
  //     'memorySize': data.memorySize,
  //     'cpuFrequency': data.cpuFrequency,
  //     'systemGUID': data.systemGUID,
  //   };
  // }
}
