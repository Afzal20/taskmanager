import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../core/date_utils.dart' as du;
import '../models/memory.dart';
import '../services/auth_service.dart';
import '../services/memory_repository.dart';
import '../widgets/common.dart';

/// Diary-style entry for a past day. Memories are the only thing the app lets
/// you add to previous days — tasks must be created for today or later.
class MemoryEditorScreen extends StatefulWidget {
  final DateTime date;

  const MemoryEditorScreen({super.key, required this.date});

  @override
  State<MemoryEditorScreen> createState() => _MemoryEditorScreenState();
}

class _MemoryEditorScreenState extends State<MemoryEditorScreen> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Give the memory a title.'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    await MemoryRepository.add(
      Memory(
        userId: AuthService.instance.userId,
        title: title,
        description: _noteController.text.trim(),
        date: du.dayKey(widget.date),
      ),
    );

    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'New memory',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.memoryAccent.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: AppColors.memoryAccent.withValues(alpha: 0.45)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_stories_outlined,
                        size: 18, color: AppColors.memoryAccent),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Remembering ${du.fullDate(widget.date)}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppTextField(
                controller: _titleController,
                label: 'Title',
                hint: 'What do you want to remember?',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18),
              AppTextField(
                controller: _noteController,
                label: 'Details (optional)',
                hint: 'Add more details…',
                maxLines: 4,
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Save memory',
                icon: Icons.bookmark_rounded,
                onPressed: _save,
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
