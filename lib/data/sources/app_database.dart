import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

import 'dev_seed.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// Drift database for hi-planner. Owns the SQLite schema (Todos,
/// FocusSessions), migrations, and the dev-only seed hook.
///
/// A single instance is shared app-wide (wired as a Riverpod singleton in the
/// application layer); Drift serializes writes and exposes `.watch()` streams
/// for the reactive 오늘/이번달 views.
@DriftDatabase(tables: [Todos, FocusSessions])
class AppDatabase extends _$AppDatabase {
  /// Default (app) constructor: opens the native/web database via
  /// `drift_flutter`.
  AppDatabase([QueryExecutor? executor])
      : _enableDevSeed = true,
        super(executor ?? driftDatabase(name: 'hi_planner'));

  /// Test constructor: uses the given [executor] (e.g.
  /// `NativeDatabase.memory()`) and disables dev seeding so tests start empty.
  AppDatabase.forTesting(super.executor) : _enableDevSeed = false;

  /// Whether the dev seed may run (off for tests). Still additionally gated by
  /// `kDebugMode` and a fresh database.
  final bool _enableDevSeed;

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        beforeOpen: (details) async {
          // Drift does not enable foreign keys by default.
          await customStatement('PRAGMA foreign_keys = ON');
          // Dev-only seed: runs once on a fresh debug database. `kReleaseMode`
          // is const, so this branch is tree-shaken out of release builds.
          if (_enableDevSeed && kDebugMode && details.wasCreated) {
            await DevSeed(this).run();
          }
        },
      );
}
