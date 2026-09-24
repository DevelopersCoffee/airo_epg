## 1.1.0

- `parseXmltvTimestamp` and `fromXmltv*` / `fromXmltvFileNative` / `fromXmltvCurrentNextFileNative` take optional `naiveOffset`.
- Naked XMLTV stamps (no `+ZZZZ`) use that duration as a device zone; tagged stamps still win.
- Omitting `naiveOffset` keeps today's behavior (naked stamp = UTC).

## 1.0.0

- Initial release of `airo_epg`.
- Standalone EPG contracts, XMLTV parser, sports desk models, reminders, and multi-source EPG resolution.
