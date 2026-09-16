import 'dart:async';

/// Stable identifiers for gated product features.
enum ProFeature {
  importIntelligence('import_intelligence'),
  regionalRanking('regional_ranking'),
  epgReminders('epg_reminders'),
  metadataEnrichment('metadata_enrichment'),
  sportsDesk('sports_desk'),
  multiSourceFailover('multi_source_failover'),
  coinEncryptedBackupRestore('coin_encrypted_backup_restore'),
  sourceConnectionDiagnostics('source_connection_diagnostics'),
  mindIndicIntelligence('mind_indic_intelligence');

  const ProFeature(this.stableId);

  final String stableId;
}

/// Read-side entitlement contract consumed by feature code.
abstract interface class Entitlements {
  bool isEnabled(ProFeature feature);
  Stream<Set<ProFeature>> get changes;
}

/// Launch-phase policy: every pro feature is enabled by default.
class LaunchPromoEntitlements implements Entitlements {
  const LaunchPromoEntitlements();

  @override
  bool isEnabled(ProFeature feature) => true;

  @override
  Stream<Set<ProFeature>> get changes => Stream<Set<ProFeature>>.value(
    Set<ProFeature>.unmodifiable(ProFeature.values.toSet()),
  );
}

/// Deny-all implementation for tests and lite builds.
class NoEntitlements implements Entitlements {
  const NoEntitlements();

  @override
  bool isEnabled(ProFeature feature) => false;

  @override
  Stream<Set<ProFeature>> get changes =>
      Stream<Set<ProFeature>>.value(const <ProFeature>{});
}
