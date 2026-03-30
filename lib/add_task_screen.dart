import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  final VoidCallback? onTaskAdded;
  const AddTaskScreen({super.key, this.onTaskAdded});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  final List<Color> _colorOptions = const [
    Color(0xFF4D96FF),
    Color(0xFFFFD93D),
    Color(0xFF6BCB77),
    Color(0xFFFF6B6B),
    Color(0xFFA855F7),
    Color(0xFFF97316),
  ];
  int _selectedColor = 0;

  // 0=low 1=med 2=high
  int _selectedPriority = 1;

  // Selected date offset from today (0=today, 1=tomorrow, etc.)
  int _selectedDateOffset = 1;

  final int _dateRange = 5;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  List<DateTime> get _dates {
    final today = DateTime.now();
    return List.generate(_dateRange, (i) => today.add(Duration(days: i)));
  }

  String _dayLabel(DateTime d) {
    const days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
    return days[d.weekday % 7];
  }

  void _saveTask() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Task title দাও! 😅'),
          backgroundColor: _colorOptions[_selectedColor],
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }
    widget.onTaskAdded?.call();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E17),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A2E),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: const Color(0xFF2A2840)),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white, size: 16),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'নতুন Task',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    _buildFieldLabel('Task টাইটেল'),
                    const SizedBox(height: 7),
                    _buildTextField(_titleController, 'কী করতে হবে?'),

                    const SizedBox(height: 18),

                    // Description
                    _buildFieldLabel('বিস্তারিত (optional)'),
                    const SizedBox(height: 7),
                    _buildTextField(
                      _descController,
                      'আরও কিছু লিখতে চাইলে...',
                      maxLines: 4,
                    ),

                    const SizedBox(height: 18),

                    // Color picker
                    _buildFieldLabel('Category Color'),
                    const SizedBox(height: 10),
                    Row(
                      children: List.generate(_colorOptions.length, (i) {
                        final selected = _selectedColor == i;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedColor = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            margin: const EdgeInsets.only(right: 10),
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: _colorOptions[i],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selected
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                            child: selected
                                ? const Icon(Icons.check,
                                    color: Colors.white, size: 16)
                                : null,
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 18),

                    // Priority
                    _buildFieldLabel('Priority'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildPriorityBtn(0, '🟢 Low', const Color(0xFF6BCB77)),
                        const SizedBox(width: 8),
                        _buildPriorityBtn(
                            1, '🟡 Medium', const Color(0xFFFFD93D)),
                        const SizedBox(width: 8),
                        _buildPriorityBtn(2, '🔴 High', const Color(0xFFFF6B6B)),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Due date
                    _buildFieldLabel('Due date'),
                    const SizedBox(height: 10),
                    Row(
                      children: List.generate(
                        _dates.length,
                        (i) {
                          final date = _dates[i];
                          final selected = _selectedDateOffset == i;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedDateOffset = i),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                margin: EdgeInsets.only(
                                    right: i < _dates.length - 1 ? 8 : 0),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 4),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? const Color(0xFF4D96FF18)
                                      : const Color(0xFF1A1A2E),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: selected
                                        ? const Color(0xFF4D96FF)
                                        : const Color(0xFF2A2840),
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      _dayLabel(date),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.5,
                                        color: selected
                                            ? const Color(0xFF4D96FF)
                                            : const Color(0xFF666680),
                                      ),
                                    ),
                                    Text(
                                      '${date.day}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: selected
                                            ? const Color(0xFF4D96FF)
                                            : Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Save button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6BCB77), Color(0xFF4D96FF)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  const Color(0xFF6BCB77).withOpacity(0.35),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _saveTask,
                            borderRadius: BorderRadius.circular(18),
                            child: const Center(
                              child: Text(
                                '✦ Task সেভ করো',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1,
        color: Color(0xFF666680),
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String hint,
      {int maxLines = 1}) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF444466)),
        filled: true,
        fillColor: const Color(0xFF1A1A2E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF2A2840)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF2A2840), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF4D96FF), width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      ),
    );
  }

  Widget _buildPriorityBtn(int index, String label, Color activeColor) {
    final selected = _selectedPriority == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPriority = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? activeColor.withOpacity(0.1) : const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? activeColor : const Color(0xFF2A2840),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: selected ? activeColor : const Color(0xFF666680),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
