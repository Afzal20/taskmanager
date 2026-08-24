import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../core/date_utils.dart' as du;
import '../models/user.dart';
import '../services/auth_service.dart';
import '../screens/auth/login_screen.dart';
import '../widgets/common.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  User? _user;
  bool _loading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    reload();
  }

  Future<void> reload() async {
    final user = await AuthService.instance.currentUser();
    if (!mounted) return;
    setState(() {
      _user = user;
      _loading = false;
    });
  }

  Future<void> _editProfile() async {
    final nameController = TextEditingController(text: _user?.name ?? '');
    var avatar = _user?.avatar ?? '🙂';

    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: EdgeInsets.fromLTRB(
              20, 20, 20, MediaQuery.of(ctx).viewInsets.bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Edit profile',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 18),
              AppTextField(
                controller: nameController,
                label: 'Name',
                hint: 'Your name',
                prefixIcon: Icons.person_outline_rounded,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: AuthService.instance.avatarChoices.map((a) {
                  final selected = a == avatar;
                  return GestureDetector(
                    onTap: () => setSheetState(() => avatar = a),
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary.withValues(alpha: 0.15)
                            : AppColors.surfaceHigh,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(
                          color:
                              selected ? AppColors.primary : AppColors.border,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                          child: Text(a, style: const TextStyle(fontSize: 22))),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                label: 'Save',
                onPressed: () async {
                  final user = _user;
                  if (user == null) return;
                  final updated = User(
                    id: user.id,
                    name: nameController.text.trim().isEmpty
                        ? user.name
                        : nameController.text.trim(),
                    email: user.email,
                    password: user.password,
                    avatar: avatar,
                    createdAt: user.createdAt,
                  );
                  // Persist via auth service helper.
                  await AuthService.instance.updateProfile(updated);
                  if (ctx.mounted) Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        ),
      ),
    );

    if (saved == true) reload();
  }

  Future<void> _changePassword() async {
    final currentCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
            20, 20, 20, MediaQuery.of(ctx).viewInsets.bottom + 24),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Change password',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 18),
              AppTextField(
                controller: currentCtrl,
                label: 'Current password',
                hint: 'Enter current password',
                prefixIcon: Icons.lock_outline,
                obscure: true,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Enter your current password.' : null,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: newCtrl,
                label: 'New password',
                hint: 'At least 4 characters',
                prefixIcon: Icons.key_outlined,
                obscure: true,
                validator: (v) =>
                    (v == null || v.length < 4) ? 'Use at least 4 characters.' : null,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: confirmCtrl,
                label: 'Confirm new password',
                hint: 'Repeat new password',
                prefixIcon: Icons.lock_reset_outlined,
                obscure: true,
                validator: (v) =>
                    (v != newCtrl.text) ? 'Passwords do not match.' : null,
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                label: 'Update password',
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;
                  final result = await AuthService.instance.changePassword(
                    currentPassword: currentCtrl.text,
                    newPassword: newCtrl.text,
                  );
                  if (!ctx.mounted) return;
                  if (!result.success) {
                    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                        content: Text(result.error!),
                        backgroundColor: AppColors.red));
                    return;
                  }
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        ),
      ),
    );

    if (saved == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Password updated.'),
          backgroundColor: AppColors.green));
    }
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign out?'),
        content:
            const Text('You will need to sign in again to see your tasks.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.red),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    await AuthService.instance.logout();
    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      FadeRoute(page: const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final user = _user;

    return ListView(
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 12, 20, 96),
      children: [
        const Text('Profile',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
        const SizedBox(height: 20),

        // Identity card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Center(
                  child: Text(
                    _loading ? '…' : (user?.avatar ?? '🙂'),
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      user?.email ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.textTertiary),
                    ),
                    if (user != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        'Member since ${du.fullDate(DateTime.tryParse(user.createdAt) ?? DateTime.now())}',
                        style: const TextStyle(
                            fontSize: 11.5, color: AppColors.textTertiary),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Account actions
        _ActionTile(
          icon: Icons.edit_outlined,
          label: 'Edit profile',
          subtitle: 'Name and avatar',
          onTap: _editProfile,
        ),
        const SizedBox(height: 10),
        _ActionTile(
          icon: Icons.password_outlined,
          label: 'Change password',
          subtitle: 'Update your sign-in password',
          onTap: _changePassword,
        ),
        const SizedBox(height: 10),
        const _ActionTile(
          icon: Icons.shield_outlined,
          label: 'Privacy & data',
          subtitle: 'Your tasks are stored locally on this device only',
        ),
        const SizedBox(height: 28),
        GhostButton(label: 'Sign out', onPressed: _logout),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback? onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: AppColors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: const TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary)),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textTertiary)),
                  ],
                ),
              ),
              if (onTap != null)
                const Icon(Icons.chevron_right_rounded,
                    size: 20, color: AppColors.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}
