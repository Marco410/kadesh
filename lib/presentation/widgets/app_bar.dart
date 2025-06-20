import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kadesh/data/theme/style.dart';
import 'package:kadesh/presentation/widgets/icon_button.dart';
import 'package:sizer_pro/sizer.dart';

import '../../data/share_prefs/prefs_usuario.dart';

class KAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const KAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(preferenciasUsuarioProvider);
    return AppBar(
      leading: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: UserAvatarWidget(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hola,",
            style: TxtStyle.hintText.copyWith(fontSize: 8.f, height: 1),
          ),
          Text(
            prefs.name,
            style: TxtStyle.labelStyle.copyWith(fontSize: 20.f, height: 0.8),
          ),
        ],
      ),
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButtonWidget(
          onTap: () {},
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedNotification01,
            color: KColors.dark,
            size: 12.f,
          ),
        ),
      ],
      actionsPadding: const EdgeInsets.only(right: 15),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.f,
      height: 25.f,
      decoration: const BoxDecoration(
        color: KColors.secondaryColor,
        shape: BoxShape.circle,
      ),
      child: const HugeIcon(
        icon: HugeIcons.strokeRoundedUser,
        color: KColors.white,
      ),
    );
  }
}
