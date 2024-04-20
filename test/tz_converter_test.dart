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

import 'package:test/test.dart';
import 'package:win2iana_tz_converter/src/tz_converter.dart';
import 'package:win2iana_tz_converter/src/tz_info.dart';

const testDatabase = {
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
        {
          "mapZone": {
            "_other": "Afghanistan Standard Time",
            "_type": "Asia/Kabul",
            "_territory": "AF"
          }
        },
        {
          "mapZone": {
            "_other": "Central Standard Time",
            "_type": "America/Chicago",
            "_territory": "US"
          }
        }
      ]
    }
  }
};

void main() {
  group('TZConverterImpl', () {
    test('windowsToIana with single mapping', () {
      final tzConverter = TZConverterImpl(db: testDatabase);

      final result = tzConverter.windowsToIana('Afghanistan Standard Time');
      expect(result.length, equals(2));
      expect(
          result[0],
          equals(WinIanaZone(
              iana: 'Asia/Kabul',
              windows: 'Afghanistan Standard Time',
              territory: '001')));
      expect(
          result[1],
          equals(WinIanaZone(
              iana: 'Asia/Kabul',
              windows: 'Afghanistan Standard Time',
              territory: 'AF')));
    });

    test('ianaToWindows with single mapping', () {
      final tzConverter = TZConverterImpl(db: testDatabase);

      final result = tzConverter.ianaToWindws('Asia/Kabul');
      expect(result.length, equals(2));
      expect(
          result[0],
          equals(WinIanaZone(
              iana: 'Asia/Kabul',
              windows: 'Afghanistan Standard Time',
              territory: '001')));
      expect(
          result[1],
          equals(WinIanaZone(
              iana: 'Asia/Kabul',
              windows: 'Afghanistan Standard Time',
              territory: 'AF')));
    });

    test('windowsToIana with multiple mappings', () {
      final tzConverter = TZConverterImpl(db: testDatabase);

      final result = tzConverter.windowsToIana('Central Standard Time');
      expect(result.length, equals(1));
      expect(
          result[0],
          equals(WinIanaZone(
              iana: 'America/Chicago',
              windows: 'Central Standard Time',
              territory: 'US')));
    });

    test('ianaToWindows with multiple mappings', () {
      final tzConverter = TZConverterImpl(db: testDatabase);

      final result = tzConverter.ianaToWindws('America/Chicago');
      expect(result.length, equals(1));
      expect(
          result[0],
          equals(WinIanaZone(
              iana: 'America/Chicago',
              windows: 'Central Standard Time',
              territory: 'US')));
    });

    test('windowsToIana with no mapping', () {
      final tzConverter = TZConverterImpl(db: testDatabase);

      final result = tzConverter.windowsToIana('Nonexistent Time Zone');
      expect(result, isEmpty);
    });

    test('ianaToWindows with no mapping', () {
      final tzConverter = TZConverterImpl(db: testDatabase);

      final result = tzConverter.ianaToWindws('Nonexistent Time Zone');
      expect(result, isEmpty);
    });
  });
}
