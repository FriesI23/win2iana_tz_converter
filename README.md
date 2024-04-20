<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
# Win2IANA TZ Converter

![Package][pubdev-package]
![Likes][pubdev-likes]
![Popularity][pubdev-popularity]
![Points][pubdev-points]

`win2iana_tz_converter` is a lightweight package which used for converting
between Windows time zones and IANA time zone database format.

## Features

Including a built-in set of Windows to IANA conversion data for convenient
direct use. And also provided a simple cache version implementation.

```dart
final TZConverter ct1 = TZConverter();
final TzConverterWithCache ct2 = TZConverter.cache();
final TzConverterWithCache ct3 = TZConverter.cacheWithParent(ct1);
```

You can also customize a set of data for conversion.
Data format can be viewed [here][convert-format].

```dart
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
        // other mapZone
      ]
    }
  }
};
final TZConverter ct1 = TZConverter(db: db);
final TzConverterWithCache ct2 = TZConverter.cache(db: db);
```

## Getting started

### Add dependency with `dart pub add` command

```shell
dart pub add win2iana_tz_converter
```

### **Or** Add below line to `pubspec.yaml`

```yaml
dependencies:
  ...
  win2iana_tz_converter: any  # or special version

```

Then run `dart pub get`, or `flutter pub get` for flutter project.

## Usage

```dart
final TZConverter ct = TZConverter();
final win2ianaResult =
    ct.windowsToIana("China Standard Time").map((e) => e.toJson()).toList();
print("win2iana: $win2ianaResult");
final iana2winResult =
    ct.ianaToWindws("Asia/Hong_Kong").map((e) => e.toJson()).toList();
print('iana2win: $iana2winResult');
```

for more example see: [tz_converter_example.dart][tz_converter_example.dart]

## Donate

[!["Buy Me A Coffee"][buymeacoffee-badge]](https://www.buymeacoffee.com/d49cb87qgww)
[![Alipay][alipay-badge]][alipay-addr]
[![WechatPay][wechat-badge]][wechat-addr]

[![ETH][eth-badge]][eth-addr]
[![BTC][btc-badge]][btc-addr]

## License

```text
Copyright (C) 2024 Fries_I23

win2iana_tz_converter is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

win2iana_tz_converter is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with win2iana_tz_converter. If not, see <https://www.gnu.org/licenses/>.
```

[pubdev-package]: https://img.shields.io/pub/v/win2iana_tz_converter.svg
[pubdev-likes]: https://img.shields.io/pub/likes/win2iana_tz_converter?logo=dart
[pubdev-popularity]: https://img.shields.io/pub/popularity/win2iana_tz_converter?logo=dart
[pubdev-points]: https://img.shields.io/pub/points/win2iana_tz_converter?logo=dart

[buymeacoffee-badge]: https://img.shields.io/badge/Buy_Me_A_Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black
[alipay-badge]: https://img.shields.io/badge/alipay-00A1E9?style=for-the-badge&logo=alipay&logoColor=white
[alipay-addr]: https://raw.githubusercontent.com/FriesI23/mhabit/main/docs/README/images/donate-alipay.jpg
[wechat-badge]: https://img.shields.io/badge/WeChat-07C160?style=for-the-badge&logo=wechat&logoColor=white
[wechat-addr]: https://raw.githubusercontent.com/FriesI23/mhabit/main/docs/README/images/donate-wechatpay.png
[eth-badge]: https://img.shields.io/badge/Ethereum-3C3C3D?style=for-the-badge&logo=Ethereum&logoColor=white
[eth-addr]: https://etherscan.io/address/0x35FC877Ef0234FbeABc51ad7fC64D9c1bE161f8F
[btc-badge]: https://img.shields.io/badge/Bitcoin-000000?style=for-the-badge&logo=bitcoin&logoColor=white
[btc-addr]: https://blockchair.com/bitcoin/address/bc1qz2vjews2fcscmvmcm5ctv47mj6236x9p26zk49

[convert-format]: https://raw.githubusercontent.com/unicode-org/cldr-json/main/cldr-json/cldr-core/supplemental/windowsZones.json
[tz_converter_example.dart]: ./example/tz_converter_example.dart
