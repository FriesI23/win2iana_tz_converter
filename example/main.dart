import 'package:win2iana_tz_converter/win2iana_tz_converter.dart';

void defaultConverter() {
  print('[normal]------------------------');
  final TZConverter ct = TZConverter();
  final win2ianaResult =
      ct.windowsToIana("China Standard Time").map((e) => e.toJson()).toList();
  print("win2iana: $win2ianaResult");
  final iana2winResult =
      ct.ianaToWindws("Asia/Hong_Kong").map((e) => e.toJson()).toList();
  print('iana2win: $iana2winResult');
}

void converterWithCache() {
  print('[cache]------------------------');
  final TzConverterWithCache ct = TZConverter.cache();
  final win2ianaResult =
      ct.windowsToIana("China Standard Time").map((e) => e.toJson()).toList();
  print("win2iana: $win2ianaResult");
  final iana2winResult =
      ct.ianaToWindws("Asia/Hong_Kong").map((e) => e.toJson()).toList();
  print('iana2win: $iana2winResult');
}

void convertCustomDB() {
  final db = {
    "supplemental": {
      "version": {"_unicodeVersion": "15.1.0", "_cldrVersion": "45"},
      "windowsZones": {
        "mapTimezones": [
          {
            "mapZone": {
              "_other": "Afghanistan Standard Time",
              "_type": "Asia/Kabul",
              "_territory": "001"
            }
          },
        ]
      }
    }
  };
  print('[custom_db]------------------------');
  print('db: $db');
  final TZConverter ct = TZConverter(db: db);
  final win2ianaResult =
      ct.windowsToIana("China Standard Time").map((e) => e.toJson()).toList();
  print("win2iana: $win2ianaResult");
  final iana2winResult =
      ct.ianaToWindws("Asia/Kabul").map((e) => e.toJson()).toList();
  print('iana2win: $iana2winResult');
}

void bugNo1() {
  void d() {
    print('[bug#1][normal]------------------------');
    final TzConverterWithCache ct = TZConverter.cache();
    final win2ianaResult = ct
        .windowsToIana("Eastern Standard Time")
        .map((e) => e.toJson())
        .toList();
    print("win2iana[Eastern Standard Time]: $win2ianaResult");
    final iana2winResult = ct
        .ianaToWindws("America/Indiana/Petersburg")
        .map((e) => e.toJson())
        .toList();
    print('iana2win[America/Indiana/Petersburg]: $iana2winResult');
  }

  void c() {
    print('[bug#1][cache]------------------------');
    final TZConverter ct = TZConverter();
    final win2ianaResult = ct
        .windowsToIana("Eastern Standard Time")
        .map((e) => e.toJson())
        .toList();
    print("win2iana[Eastern Standard Time]: $win2ianaResult");
    final iana2winResult = ct
        .ianaToWindws("America/Indiana/Petersburg")
        .map((e) => e.toJson())
        .toList();
    print('iana2win[America/Indiana/Petersburg]: $iana2winResult');
  }

  d();
  c();
}

void main() {
  defaultConverter();
  converterWithCache();
  convertCustomDB();
  bugNo1();
}
