import 'package:dagather_frontend/components/app_bar.dart';
import 'package:flutter/material.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar("프로필 수정"),
      body: const Placeholder(),
    );
  }
}
