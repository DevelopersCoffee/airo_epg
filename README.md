# airo_epg

[![pub package](https://img.shields.io/pub/v/airo_epg.svg)](https://pub.dev/packages/airo_epg)
[![CI](https://github.com/DevelopersCoffee/airo_epg/actions/workflows/ci.yml/badge.svg)](https://github.com/DevelopersCoffee/airo_epg/actions)
[![Publisher](https://img.shields.io/badge/publisher-developerscoffee.com-blue)](https://pub.dev/publishers/developerscoffee.com/packages)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Compact and full Electronic Program Guide (EPG) platform contracts for Flutter — XMLTV parsing, sports desk models, reminders, and multi-source EPG resolution.

Part of the **DevelopersCoffee** open-source ecosystem.

---

## Features

- **XMLTV Ingest & Parsing**: Parse XMLTV program guides, extracting channels, programs, categories, and ratings.
- **Compact EPG Snapshots**: Efficient memory representation for fast timeline rendering on mobile & TV form factors.
- **Intelligent Reminders**: Local program reminder scheduling and notifications logic.
- **Sports Desk Models**: Structuring live sports fixtures, events, and contextual metadata.
- **Multi-Source EPG Resolution**: Deduplication and fallback across multiple playlist/EPG providers.

---

## Usage

```dart
import 'package:airo_epg/airo_epg.dart';

void main() {
  const xmltv = '''
<tv>
  <channel id="sports1">
    <display-name>Sports 1 HD</display-name>
  </channel>
  <programme channel="sports1" start="20260727180000 +0000" stop="20260727200000 +0000">
    <title>Championship Final</title>
    <desc>Live coverage of the championship match.</desc>
    <category>Sports</category>
  </programme>
</tv>
''';

  final result = parseXmltvProgrammes(xmltv);
  for (final p in result.programmes) {
    print('${p.channelId}: ${p.title} (${p.start} -> ${p.stop})');
  }
}
```

---

## Maintainers

Maintained with ❤️ by **[DevelopersCoffee](https://developerscoffee.com)**.
