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

import 'database.dart';
import 'tz_info.dart';

/// An abstract interface for converting between Windows and IANA time zone
/// identifiers, and providing access to a collection of time zone mappings.
abstract class TZConverter {
  /// Converts a Windows time zone identifier to a list of corresponding
  /// IANA time zones.
  /// e.g. `China Standard Time -> Asia/Shanghai, Asia/Hong_Kong, ...`
  List<WinIanaZone> windowsToIana(String tziName);

  /// Converts an IANA time zone identifier to a list of corresponding
  /// Windows time zones.
  /// e.g. `Asia/Shanghai -> China Standard Time`
  List<WinIanaZone> ianaToWindws(String tzName);

  /// Provides an iterable view of the time zone mappings.
  Iterable<WinIanaZone> get iter;

  /// Constructs a [TZConverter] instance.
  factory TZConverter({DataBase? db}) =>
      db != null ? TZConverterImpl(db: db) : const TZConverterImpl();

  /// Constructs a cached [TZConverter] instance.
  ///
  /// If [db] is provided and different from the current [database],
  /// a new [TZConverter] with the provided [database] will be used.
  static TzConverterWithCache cache({DataBase? db}) =>
      db != null && !identical(db, database)
          ? TzConverterWithCache(TZConverter(db: db))
          : TzConverterWithCache(TZConverter());

  /// Constructs a cached [TZConverter] instance with specified converter.
  static TzConverterWithCache cacheWithParent(TZConverter parent) =>
      TzConverterWithCache(parent);
}

final class TZConverterImpl implements TZConverter {
  final DataBase _database;

  const TZConverterImpl({DataBase db = database}) : _database = db;

  @override
  List<WinIanaZone> windowsToIana(String tziName) =>
      iter.where((e) => e.windows == tziName).toList();

  @override
  List<WinIanaZone> ianaToWindws(String tzName) =>
      iter.where((e) => e.iana == tzName).toList();

  @override
  Iterable<WinIanaZone> get iter => (_database["supplemental"]["windowsZones"]
          ["mapTimezones"] as List<Map<String, Map<String, String>>>)
      .map((d) => d["mapZone"]!["_type"]!.split(' ').map((t) =>
          WinIanaZone.fromJson(
              Map.of(d["mapZone"]!)..update("_type", (value) => t))))
      .expand((e) => e);
}

final class TzConverterWithCache implements TZConverter {
  final TZConverter parent;
  final Map<String, List<WinIanaZone>> _winToIanaCache = {};
  final Map<String, List<WinIanaZone>> _ianaToWinCache = {};
  final Map<int, WinIanaZone> _objCache = {};

  TzConverterWithCache(this.parent);

  void initCache() {
    _winToIanaCache.clear();
    _ianaToWinCache.clear();
    _objCache
      ..clear()
      ..addEntries(iter.map((e) => MapEntry(e.hashCode, e)));
    for (var e in _objCache.values) {
      _winToIanaCache[e.windows] =
          (_winToIanaCache[e.windows] ?? <WinIanaZone>[])..add(e);
      _ianaToWinCache[e.iana] = (_ianaToWinCache[e.iana] ?? <WinIanaZone>[])
        ..add(e);
    }
  }

  void clearCache() {
    _winToIanaCache.clear();
    _ianaToWinCache.clear();
    _objCache.clear();
  }

  void _addCache(
    String key,
    List<WinIanaZone> dataList,
    Map<String, List<WinIanaZone>> cache,
  ) {
    cache[key] = dataList.map((e) => _objCache[e.hashCode] ?? e).toList();
    cache[key]?.forEach((e) {
      if (!_objCache.containsKey(e.hashCode)) _objCache[e.hashCode] = e;
    });
  }

  @override
  List<WinIanaZone> windowsToIana(String tziName) {
    if (_winToIanaCache.containsKey(tziName)) {
      return _winToIanaCache[tziName]!;
    }
    final result = parent.windowsToIana(tziName);
    _addCache(tziName, result, _winToIanaCache);
    return result;
  }

  @override
  List<WinIanaZone> ianaToWindws(String tzName) {
    if (_ianaToWinCache.containsKey(tzName)) {
      return _ianaToWinCache[tzName]!;
    }
    final result = parent.ianaToWindws(tzName);
    _addCache(tzName, result, _ianaToWinCache);
    return result;
  }

  @override
  Iterable<WinIanaZone> get iter => parent.iter;
}
