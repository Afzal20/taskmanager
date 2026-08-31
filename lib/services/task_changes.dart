import 'dart:async';

/// Broadcasts "tasks changed" so every screen showing tasks can reload.
///
/// The app shell keeps all tabs alive in an IndexedStack, so a change made on
/// one tab (create, edit, toggle, delete, undo) must be pushed to the others;
/// otherwise they keep showing stale rows, e.g. tasks that were just deleted.
class TaskChanges {
  TaskChanges._();

  final _controller = StreamController<void>.broadcast();

  static final TaskChanges instance = TaskChanges._();

  /// Notify listeners that the underlying task data changed.
  void notify() => _controller.add(null);

  /// Listen for changes; returns a subscription to cancel in dispose().
  StreamSubscription<void> listen(void Function() onChanged) =>
      _controller.stream.listen((_) => onChanged());}
