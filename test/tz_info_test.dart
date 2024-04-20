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
import 'package:win2iana_tz_converter/src/tz_info.dart';

void main() {
  group('WinIanaZone', () {
    test('Construction with valid parameters', () {
      final winIanaZone = WinIanaZone(
        iana: 'America/New_York',
        windows: 'Eastern Standard Time',
        territory: 'US',
      );
      expect(winIanaZone.iana, 'America/New_York');
      expect(winIanaZone.windows, 'Eastern Standard Time');
      expect(winIanaZone.territory, 'US');
    });

    test('Construction with empty strings', () {
      final winIanaZone = WinIanaZone(iana: '', windows: '', territory: '');
      expect(winIanaZone.iana, '');
      expect(winIanaZone.windows, '');
      expect(winIanaZone.territory, '');
    });

    test('JSON serialization', () {
      final winIanaZone = WinIanaZone(
        iana: 'America/New_York',
        windows: 'Eastern Standard Time',
        territory: 'US',
      );
      final json = winIanaZone.toJson();
      expect(json['_type'], 'America/New_York');
      expect(json['_other'], 'Eastern Standard Time');
      expect(json['_territory'], 'US');
    });

    test('JSON deserialization', () {
      final json = {
        '_type': 'America/New_York',
        '_other': 'Eastern Standard Time',
        '_territory': 'US',
      };
      final winIanaZone = WinIanaZone.fromJson(json);
      expect(winIanaZone.iana, 'America/New_York');
      expect(winIanaZone.windows, 'Eastern Standard Time');
      expect(winIanaZone.territory, 'US');
    });
  });
}
