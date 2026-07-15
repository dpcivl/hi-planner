import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/focus_repository_impl.dart';
import '../data/repositories/todo_repository_impl.dart';
import '../data/sources/app_database.dart';
import '../domain/repositories/focus_repository.dart';
import '../domain/repositories/todo_repository.dart';

/// App-lifetime SQLite database.
///
/// Constructed once and closed when the root [ProviderScope] is torn down
/// (app exit). Deliberately NOT `autoDispose`: the database is a process-wide
/// singleton connection and must outlive individual screens — auto-disposing it
/// when transiently unobserved would close SQLite mid-use.
///
/// Tests override this with an in-memory database, e.g.
/// `ProviderScope(overrides: [appDatabaseProvider.overrideWithValue(
///   AppDatabase.forTesting(NativeDatabase.memory()))])`.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// Todo repository, exposed as the DOMAIN interface (not the `*Impl`), so the
/// presentation and controller layers depend only on `lib/domain` abstractions.
final todoRepositoryProvider = Provider<TodoRepository>(
  (ref) => TodoRepositoryImpl(ref.watch(appDatabaseProvider)),
);

/// Focus repository, exposed as the DOMAIN interface (see [todoRepositoryProvider]).
final focusRepositoryProvider = Provider<FocusRepository>(
  (ref) => FocusRepositoryImpl(ref.watch(appDatabaseProvider)),
);
