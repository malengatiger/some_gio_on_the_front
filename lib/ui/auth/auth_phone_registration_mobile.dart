import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geo_monitor/library/api/prefs_og.dart';
import 'package:geo_monitor/library/cache_manager.dart';
import 'package:geo_monitor/library/data/settings_model.dart';
import 'package:geo_monitor/realm_data/data/realm_sync_api.dart';
import 'package:geo_monitor/ui/auth/auth_phone_signin.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:realm/realm.dart';

import '../../device_location/device_location_bloc.dart';
import '../../l10n/translation_handler.dart';
import '../../library/api/data_api_og.dart';
import '../../library/bloc/theme_bloc.dart';
import '../../library/data/user.dart' as ur;
import '../../library/functions.dart';
import '../../library/generic_functions.dart';
import '../../library/users/edit/country_chooser.dart';
import '../../../realm_data/data/schemas.dart' as mrm;

class AuthPhoneRegistrationMobile extends StatefulWidget {
  const AuthPhoneRegistrationMobile(
      {Key? key,
      required this.prefsOGx,
      required this.dataApiDog,
      required this.cacheManager,
      required this.firebaseAuth})
      : super(key: key);

  final PrefsOGx prefsOGx;
  final DataApiDog dataApiDog;
  final CacheManager cacheManager;
  final FirebaseAuth firebaseAuth;

  @override
  AuthPhoneRegistrationMobileState createState() =>
      AuthPhoneRegistrationMobileState();
}

class AuthPhoneRegistrationMobileState
    extends State<AuthPhoneRegistrationMobile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _codeHasBeenSent = false;
  final mm = '🥬🥬🥬🥬🥬🥬 AuthPhoneRegistrationMobile: 🥬🥬';
  String? phoneVerificationId;
  String? code;
  final phoneController = TextEditingController(text: "+19095550000");
  final codeController = TextEditingController(text: "123456");
  final orgNameController = TextEditingController();
  final adminController = TextEditingController();
  final emailController = TextEditingController();

  bool verificationFailed = false, verificationCompleted = false;
  bool busy = false;
  final _formKey = GlobalKey<FormState>();
  mrm.User? user;
  mrm.Country? country;

  final errorController = StreamController<ErrorAnimationType>();
  String? currentText, translatedCountryName;

  SignInStrings? signInStrings;
  SettingsModel? settingsModel;

  @override
  void initState() {
    _animationController = AnimationController(
        value: 0.0,
        duration: const Duration(milliseconds: 2000),
        reverseDuration: const Duration(milliseconds: 2000),
        vsync: this);
    super.initState();
    _setTexts();
  }

  Future _setTexts() async {
    settingsModel = await prefsOGx.getSettings();
    signInStrings = await SignInStrings.getTranslated(settingsModel!);
    settingsModel = await prefsOGx.getSettings();

    if (country != null) {
      translatedCountryName = await translator.translate(
          '${country!.name}', settingsModel!.locale!);
    }

    setState(() {});
  }

  void _startVerification() async {
    pp('$mm _startVerification: ....... Verifying phone number ...');
    setState(() {
      busy = true;
    });

    await widget.firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneController.value.text,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
          pp('$mm verificationCompleted: $phoneAuthCredential');
          var message = phoneAuthCredential.smsCode ?? "";
          if (message.isNotEmpty) {
            codeController.text = message;
          }
          if (mounted) {
            setState(() {
              verificationCompleted = true;
              busy = false;
            });
            showToast(
                backgroundColor: Theme.of(context).colorScheme.background,
                textStyle: myTextStyleMedium(context),
                message: signInStrings == null
                    ? 'Verification completed. Thank you!'
                    : signInStrings!.verifyComplete,
                duration: const Duration(seconds: 5),
                context: context);
          }
        },
        verificationFailed: (FirebaseAuthException error) {
          pp('\n$mm verificationFailed : $error \n');
          if (mounted) {
            setState(() {
              verificationFailed = true;
              busy = false;
            });
            showToast(
                backgroundColor: Theme.of(context).colorScheme.background,
                textStyle: const TextStyle(color: Colors.white),
                message: signInStrings == null
                    ? 'Verification failed. Please try later'
                    : signInStrings!.verifyFailed,
                duration: const Duration(seconds: 5),
                context: context);
          }
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          pp('$mm onCodeSent: 🔵 verificationId: $verificationId 🔵 will set state ...');
          phoneVerificationId = verificationId;
          if (mounted) {
            pp('$mm setting state  _codeHasBeenSent to true');
            setState(() {
              _codeHasBeenSent = true;
              busy = false;
            });
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          pp('$mm codeAutoRetrievalTimeout verificationId: $verificationId');
        });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _processRegistration() async {
    pp('$mm process code sent and register organization, code: ${codeController.value.text}');
    setState(() {
      busy = true;
    });
    code = codeController.value.text;
    if (country == null) {
      showToast(
          duration: const Duration(seconds: 2),
          backgroundColor: Theme.of(context).colorScheme.background,
          message: 'Please select country',
          context: context);
      setState(() {
        busy = false;
      });
      return;
    }
    if (code == null || code!.isEmpty) {
      showToast(
          duration: const Duration(seconds: 2),
          backgroundColor: Theme.of(context).colorScheme.error,
          textStyle: const TextStyle(color: Colors.white),
          toastGravity: ToastGravity.CENTER,
          message: signInStrings == null
              ? 'Please put in the code that was sent to you'
              : signInStrings!.putInCode,
          context: context);
      setState(() {
        busy = false;
      });
      return;
    }

    try {
      pp('$mm .... start building registration artifacts ... code: $code');
      if (code == null) {
        showToast(
            message: 'SMS Code invalid',
            context: context,
            padding: 8.0,
            backgroundColor: Theme.of(context).primaryColor);
        return;
      }
      if (phoneVerificationId == null) {
        showToast(
            message: 'Phone verification failed',
            context: context,
            padding: 8.0,
            backgroundColor: Theme.of(context).primaryColor);
        return;
      }
      PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: phoneVerificationId!, smsCode: code!);
      var userCred =
          await widget.firebaseAuth.signInWithCredential(authCredential);
      pp('$mm ... start _doTheRegistration ...');
      await _doTheRegistration(userCred);
    } catch (e) {
      pp('$mm ... what de fuck? $e');
      String msg = e.toString();
      if (msg.contains('dup key')) {
        msg = signInStrings == null
            ? 'Duplicate organization name, please modify'
            : signInStrings!.duplicateOrg;
      }
      if (mounted) {
        showToast(
            message: msg,
            context: context,
            backgroundColor: Theme.of(context).primaryColor,
            padding: 16.0);
        setState(() {
          busy = false;
        });
      }
      return;
    }
    setState(() {
      busy = false;
    });
    _popOut();
  }

  Future<void> _doTheRegistration(UserCredential userCred) async {
    pp('$mm _doTheRegistration; userCred: $userCred');
    final organizationId = Uuid.v4().toString();
    if (country == null) {
      showToast(
          backgroundColor: Theme.of(context).primaryColor,
          padding: 16,
          message: 'Please select country',
          context: context);
      return;
    }
    var org = mrm.Organization(ObjectId(),
        name: orgNameController.value.text,
        countryId: country!.countryId,
        email: emailController.value.text,
        created: DateTime.now().toUtc().toIso8601String(),
        countryName: country!.name,
        organizationId: organizationId);

    var loc = await locationBloc.getLocation();

    pp('$mm firebase user credential obtained:  🍎 $userCred');
    var gender = 'Unknown';
    pp('$mm set up settings ...');
    settingsModel ??= getBaseSettings();
    settingsModel!.organizationId = organizationId;
    pp('$mm create user object');
    final sett = await cacheManager.getSettings();
    final memberAddedChanged =
        await translator.translate('memberAddedChanged', sett!.locale!);
    final messageFromGeo = await getFCMMessageTitle();
    var user =
        _buildUser(userCred, gender, org, messageFromGeo, memberAddedChanged);
    pp('$mm register Organization ................');

    var res = realmSyncApi.registerOrganization(organization: org, user: user);

    pp('\n$mm Organization OG Administrator registered OK: adding org settings default. '
        '😡😡😡😡  registration result $res');
    await widget.prefsOGx.saveSettings(settingsModel!);
    await themeBloc.changeToTheme(settingsModel!.themeIndex!);
    var oldUser = ur.User(
        name: user.name,
        email: user.email,
        userId: user.userId,
        cellphone: user.cellphone,
        created: user.created,
        userType: user.userType,
        gender: gender,
        organizationName: user.organizationName,
        organizationId: organizationId,
        countryId: country!.countryId,
        active: 0,
        translatedMessage: 'User Added',
        translatedTitle: 'Member has been added to Organization',
        password: null);

    await widget.prefsOGx.saveUser(oldUser);
    var cs = await widget.prefsOGx.getSettings();
    cs.organizationId = org.organizationId;
    await widget.prefsOGx.saveSettings(cs);

    pp('\n$mm Organization OG Administrator registered OK:🌍🌍🌍🌍  🍎 '
        '${user.name!} 🌍🌍🌍🌍');
    pp('\n\n$mm Organization registered: 🌍🌍🌍🌍 🍎 ${org.name!} 🌍🌍🌍🌍\n\n');
  }

  mrm.User _buildUser(UserCredential userCred, String gender,
      mrm.Organization org, String messageFromGeo, String memberAddedChanged) {
    user = mrm.User(ObjectId(),
        name: adminController.value.text,
        email: emailController.value.text,
        userId: userCred.user!.uid,
        cellphone: phoneController.value.text,
        created: DateTime.now().toUtc().toIso8601String(),
        userType: ur.UserType.orgAdministrator,
        gender: gender,
        active: 0,
        organizationName: orgNameController.value.text,
        organizationId: org.organizationId,
        countryId: country!.countryId,
        translatedTitle: messageFromGeo,
        translatedMessage: memberAddedChanged,
        password: null);

    return user!;
  }

  void _popOut() {
    if (user == null) return;
    if (mounted) {
      Navigator.of(context).pop(user);
    }
  }

  _onCountrySelected(mrm.Country p1) async {
    country = p1;
    await widget.prefsOGx.saveCountry(p1);

    if (settingsModel != null) {
      var t = await translator.translate(
          '${country!.name}', settingsModel!.locale!);
      translatedCountryName = t.replaceAll('UNAVAILABLE KEY:', '');
    } else {
      translatedCountryName =
          await translator.translate('${country!.name}', 'en');
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _navigateToCountrySearch() async {
    if (mounted) {
      var c = await Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.scale,
              alignment: Alignment.topLeft,
              duration: const Duration(milliseconds: 1000),
              child: CountrySearch(onCountrySelected: (c) {
                setState(() {
                  country = c;
                });
              })));

      if (c is mrm.Country) {
        pp('$mm country selected: ${c.name}');
        _onCountrySelected(c);
      }
    }
  }

  bool refreshCountries = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          signInStrings == null
              ? 'Organization Registration'
              : signInStrings!.registerOrganization,
          style: myTextStyleMediumBoldWithColor(
              context, Theme.of(context).primaryColor),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              shape: getRoundedBorder(radius: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    busy
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 4,
                                    backgroundColor: Colors.pink,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(
                            height: 12,
                          ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          signInStrings == null
                              ? 'Phone Authentication'
                              : signInStrings!.phoneAuth,
                          style: myTextStyleMediumBold(context),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        verificationCompleted
                            ? IconButton(
                                onPressed: () {
                                  _processRegistration();
                                },
                                icon: Icon(
                                  Icons.check,
                                  color: Theme.of(context).primaryColor,
                                  size: 32,
                                ))
                            : const SizedBox(),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  controller: orgNameController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      hintText: signInStrings == null
                                          ? 'Enter Organization Name'
                                          : signInStrings!.enterOrg,
                                      hintStyle: myTextStyleSmall(context),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.6,
                                            color: Theme.of(context)
                                                .primaryColor), //<-- SEE HERE
                                      ),
                                      label: Text(
                                        signInStrings == null
                                            ? 'Organization Name'
                                            : signInStrings!.orgName,
                                        style: myTextStyleSmall(context),
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return signInStrings == null
                                          ? 'Please enter Organization Name'
                                          : signInStrings!.enterOrg;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: adminController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      hintText: signInStrings == null
                                          ? 'Enter Administrator Name'
                                          : signInStrings!.enterAdmin,
                                      hintStyle: myTextStyleSmall(context),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.6,
                                            color: Theme.of(context)
                                                .primaryColor), //<-- SEE HERE
                                      ),
                                      label: Text(
                                        signInStrings == null
                                            ? 'Administrator Name'
                                            : signInStrings!.adminName,
                                        style: myTextStyleSmall(context),
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return signInStrings == null
                                          ? 'Please enter Administrator Name'
                                          : signInStrings!.enterAdmin;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      hintText: signInStrings == null
                                          ? 'Enter Phone Number'
                                          : signInStrings!.enterPhone,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.6,
                                            color: Theme.of(context)
                                                .primaryColor), //<-- SEE HERE
                                      ),
                                      label: Text(signInStrings == null
                                          ? 'Phone Number'
                                          : signInStrings!.phoneNumber)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return signInStrings == null
                                          ? 'Please enter Phone Number'
                                          : signInStrings!.enterPhone;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      hintText: signInStrings == null
                                          ? 'Enter Email Address'
                                          : signInStrings!.enterEmail,
                                      hintStyle: myTextStyleSmall(context),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.6,
                                            color: Theme.of(context)
                                                .primaryColor), //<-- SEE HERE
                                      ),
                                      label: Text(
                                        signInStrings == null
                                            ? 'Email Address'
                                            : signInStrings!.emailAddress,
                                        style: myTextStyleSmall(context),
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return signInStrings == null
                                          ? 'Please enter Email address'
                                          : signInStrings!.enterEmail;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 1),
                                  child: Row(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            _navigateToCountrySearch();
                                          },
                                          child: const Text('Search Countries'))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      translatedCountryName == null
                                          ? const SizedBox()
                                          : Text(
                                              translatedCountryName!,
                                              style: myTextStyleMediumBold(
                                                  context),
                                            ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                _codeHasBeenSent
                                    ? const SizedBox()
                                    : ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _startVerification();
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                    signInStrings == null
                                                        ? 'Verify Phone Number'
                                                        : signInStrings!
                                                            .verifyPhone),
                                              ),
                                            ],
                                          ),
                                        )),
                                const SizedBox(
                                  height: 20,
                                ),
                                _codeHasBeenSent
                                    ? SizedBox(
                                        height: 200,
                                        child: Column(
                                          children: [
                                            Text(
                                              signInStrings == null
                                                  ? 'Enter SMS pin code sent'
                                                  : signInStrings!.enterSMS,
                                              style: myTextStyleSmall(context),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            PinCodeTextField(
                                              length: 6,
                                              obscureText: false,
                                              textStyle:
                                                  myNumberStyleLarge(context),
                                              animationType: AnimationType.fade,
                                              pinTheme: PinTheme(
                                                shape: PinCodeFieldShape.box,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                fieldHeight: 50,
                                                fieldWidth: 40,
                                                activeFillColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .background,
                                              ),
                                              animationDuration: const Duration(
                                                  milliseconds: 300),
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                              enableActiveFill: true,
                                              errorAnimationController:
                                                  errorController,
                                              controller: codeController,
                                              onCompleted: (v) {
                                                pp("Completed");
                                              },
                                              onChanged: (value) {
                                                pp(value);
                                                setState(() {
                                                  currentText = value;
                                                });
                                              },
                                              beforeTextPaste: (text) {
                                                pp("Allowing to paste $text");
                                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                                return true;
                                              },
                                              appContext: context,
                                            ),
                                            const SizedBox(
                                              height: 28,
                                            ),
                                            busy
                                                ? const SizedBox(
                                                    height: 16,
                                                    width: 16,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 4,
                                                      backgroundColor:
                                                          Colors.pink,
                                                    ),
                                                  )
                                                : ElevatedButton(
                                                    onPressed:
                                                        _processRegistration,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Text(
                                                          signInStrings == null
                                                              ? 'Send Code'
                                                              : signInStrings!
                                                                  .sendCode),
                                                    )),
                                          ],
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
