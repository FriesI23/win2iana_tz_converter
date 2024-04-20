// Copyright (C) 2024 Fries_I23
//
// tz_converter is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// tz_converter is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with tz_converter. If not, see <https://www.gnu.org/licenses/>.

/// Represents a mapping between an IANA time zone identifier and
/// a corresponding Windows time zone identifier.
class WinIanaZone {
  /// The IANA time zone identifier. e.g. Asia/Kabul
  final String iana;

  /// The Windows time zone identifier. e.g. Afghanistan Standard Time
  final String windows;

  /// The territory associated with the time zone.
  final String territory;

  const WinIanaZone({
    required this.iana,
    required this.windows,
    required this.territory,
  });

  factory WinIanaZone.fromJson(Map<String, Object?> json) => WinIanaZone(
      iana: json["_type"] as String,
      windows: json["_other"] as String,
      territory: json["_territory"] as String);

  Map<String, Object> toJson() => {
        "_type": iana,
        "_other": windows,
        "_territory": territory,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WinIanaZone) return false;
    return iana == other.iana &&
        windows == other.windows &&
        territory == other.territory;
  }

  @override
  int get hashCode => iana.hashCode ^ windows.hashCode ^ territory.hashCode;
}
