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

import './src/database.dart' show database;

export './src/tz_converter.dart' show TZConverter, TzConverterWithCache;
export './src/tz_info.dart' show WinIanaZone;

const defaultDatabase = database;
