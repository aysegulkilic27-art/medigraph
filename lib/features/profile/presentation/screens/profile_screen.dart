// Kullanıcının yaş, boy, kilo ve cinsiyet bilgilerini
// girdiği profil düzenleme ekranı.

import 'package:diyabetansiyon/core/constants/app_texts.dart';
import 'package:diyabetansiyon/core/constants/app_dimensions.dart';
import 'package:diyabetansiyon/core/widgets/gradient_app_bar.dart';
import 'package:diyabetansiyon/core/widgets/health_background.dart';
import 'package:diyabetansiyon/features/profile/domain/entities/user_profile.dart';
import 'package:diyabetansiyon/features/profile/presentation/widgets/profile_form.dart';
import 'package:diyabetansiyon/features/profile/presentation/widgets/profile_save_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key, this.initialProfile, this.onSaved});

  final UserProfile? initialProfile;
  final VoidCallback? onSaved;

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String? _gender;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final p = widget.initialProfile;
    if (p != null) {
      _nameController.text = p.name ?? '';
      _ageController.text = p.age.toString();
      _heightController.text = p.height.toString();
      _weightController.text = p.weight.toString();
      _gender = p.gender;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.initialProfile != null;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: GradientAppBar(
        title: isUpdate ? AppTexts.updateProfileTitle : AppTexts.profileTitle,
        showBack: isUpdate,
      ),
      body: HealthBackground(
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingMD(context) + AppDimensions.spacingXS(context),
            ),
            child: Form(
              key: _formKey,
              child: ProfileForm(
                nameController: _nameController,
                ageController: _ageController,
                heightController: _heightController,
                weightController: _weightController,
                gender: _gender,
                onGenderChanged: (v) => setState(() => _gender = v),
                ageValidator: (v) => (int.tryParse(v ?? '') == null)
                    ? AppTexts.invalidAge
                    : null,
                heightValidator: (v) => (double.tryParse(v ?? '') == null)
                    ? AppTexts.invalidHeight
                    : null,
                weightValidator: (v) => (double.tryParse(v ?? '') == null)
                    ? AppTexts.invalidWeight
                    : null,
                genderValidator: (v) => v == null ? AppTexts.genderRequired : null,
                isSaving: _saving,
                onSave: () => saveProfileForm(
                  context: context,
                  ref: ref,
                  formKey: _formKey,
                  nameController: _nameController,
                  ageController: _ageController,
                  heightController: _heightController,
                  weightController: _weightController,
                  gender: _gender,
                  initialProfile: widget.initialProfile,
                  onSaved: widget.onSaved,
                  setSaving: (value) {
                    if (mounted) setState(() => _saving = value);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
