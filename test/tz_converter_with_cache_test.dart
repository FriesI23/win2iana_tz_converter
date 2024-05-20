// Copyright (C) 2024 Fries_I23
//
// win2iana_tz_converter is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// win2iana_tz_converter is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with win2iana_tz_converter. If not, see <https://www.gnu.org/licenses/>.

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:win2iana_tz_converter/src/tz_converter.dart';
import 'package:win2iana_tz_converter/src/tz_info.dart';

@GenerateNiceMocks([MockSpec<TZConverter>()])
import 'tz_converter_with_cache_test.mocks.dart';

void main() {
  group('TzConverterWithCache', () {
    test('windowsToIana with cache hit', () {
      final parentMock = MockTZConverter();
      final tzConverter = TzConverterWithCache(parentMock);

      final winIanaZones = [
        WinIanaZone(
            iana: 'America/New_York',
            windows: 'Eastern Standard Time',
            territory: 'US'),
        WinIanaZone(
            iana: 'Europe/London',
            windows: 'GMT Standard Time',
            territory: 'GB'),
      ];

      when(parentMock.windowsToIana('Eastern Standard Time'))
          .thenReturn([winIanaZones[0]]);

      tzConverter.windowsToIana('Eastern Standard Time');
      final result = tzConverter.windowsToIana('Eastern Standard Time');

      verify(parentMock.windowsToIana('Eastern Standard Time')).called(1);
      expect(result, equals([winIanaZones[0]]));
    });

    test('windowsToIana with cache hit with init', () {
      final parentMock = MockTZConverter();
      final tzConverter = TzConverterWithCache(parentMock);

      final winIanaZones = [
        WinIanaZone(
            iana: 'America/New_York',
            windows: 'Eastern Standard Time',
            territory: 'US'),
        WinIanaZone(
            iana: 'Europe/London',
            windows: 'GMT Standard Time',
            territory: 'GB'),
      ];

      when(parentMock.windowsToIana('Eastern Standard Time'))
          .thenReturn([winIanaZones[0]]);
      when(parentMock.iter).thenReturn(winIanaZones);

      tzConverter.initCache();

      final result = tzConverter.windowsToIana('Eastern Standard Time');

      verifyNever(parentMock.windowsToIana('Eastern Standard Time'));
      expect(result, equals([winIanaZones[0]]));
    });

    test('ianaToWindws with cache hit', () {
      final parentMock = MockTZConverter();
      final tzConverter = TzConverterWithCache(parentMock);

      final winIanaZones = [
        WinIanaZone(
            iana: 'America/New_York',
            windows: 'Eastern Standard Time',
            territory: 'US'),
        WinIanaZone(
            iana: 'Europe/London',
            windows: 'GMT Standard Time',
            territory: 'GB'),
      ];

      when(parentMock.ianaToWindws('America/New_York'))
          .thenReturn([winIanaZones[0]]);

      tzConverter.ianaToWindws('America/New_York');
      final result = tzConverter.ianaToWindws('America/New_York');

      verify(parentMock.ianaToWindws('America/New_York')).called(1);
      expect(result, equals([winIanaZones[0]]));
    });

    test('ianaToWindows with cache hit with init', () {
      final parentMock = MockTZConverter();
      final tzConverter = TzConverterWithCache(parentMock);

      final winIanaZones = [
        WinIanaZone(
            iana: 'America/New_York',
            windows: 'Eastern Standard Time',
            territory: 'US'),
        WinIanaZone(
            iana: 'Europe/London',
            windows: 'GMT Standard Time',
            territory: 'GB'),
      ];

      when(parentMock.ianaToWindws('Europe/London'))
          .thenReturn([winIanaZones[1]]);
      when(parentMock.iter).thenReturn(winIanaZones);

      tzConverter.initCache();

      final result = tzConverter.ianaToWindws('Europe/London');

      verifyNever(parentMock.ianaToWindws('Europe/London'));
      expect(result, equals([winIanaZones[1]]));
    });

    test('multi _types, bug #1', () {
      final parentMock = MockTZConverter();
      final tzConverter = TzConverterWithCache(parentMock);
      final realParentConverter = TZConverterImpl(db: {
        "supplemental": {
          "version": {"_unicodeVersion": "15.1.0", "_cldrVersion": "45"},
          "windowsZones": {
            "mapTimezones": [
              {
                "mapZone": {
                  "_other": "Eastern Standard Time",
                  "_type": "America/Toronto America/Iqaluit",
                  "_territory": "CA"
                }
              },
              {
                "mapZone": {
                  "_other": "Eastern Standard Time",
                  "_type":
                      "America/New_York America/Detroit America/Indiana/Petersburg America/Indiana/Vincennes America/Indiana/Winamac America/Kentucky/Monticello America/Louisville",
                  "_territory": "US"
                }
              },
              {
                "mapZone": {
                  "_other": "Eastern Standard Time",
                  "_type": "EST5EDT",
                  "_territory": "ZZ"
                }
              },
            ]
          }
        }
      });

      // case 1
      when(parentMock.windowsToIana("Eastern Standard Time")).thenReturn(
          realParentConverter.windowsToIana("Eastern Standard Time"));
      tzConverter.windowsToIana("Eastern Standard Time");
      final result1 = tzConverter.windowsToIana("Eastern Standard Time");
      verify(parentMock.windowsToIana("Eastern Standard Time")).called(1);
      expect(result1,
          equals(realParentConverter.windowsToIana("Eastern Standard Time")));

      // case 2
      when(parentMock.ianaToWindws("America/Toronto"))
          .thenReturn(realParentConverter.ianaToWindws("America/Toronto"));
      tzConverter.ianaToWindws("America/Toronto");
      final result2 = tzConverter.ianaToWindws("America/Toronto");
      verify(parentMock.ianaToWindws("America/Toronto")).called(1);
      expect(
          result2, equals(realParentConverter.ianaToWindws("America/Toronto")));
    });
  });
}
