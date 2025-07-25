import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:kadesh/data/theme/style.dart';
import 'package:kadesh/domain/providers/auth_provider.dart';
import 'package:kadesh/modules/core_module/presentation/widgets/loading_widget.dart';

class SocialMediaAuth extends ConsumerStatefulWidget {
  final bool lineAtTop;
  const SocialMediaAuth({super.key, this.lineAtTop = true});

  @override
  ConsumerState<SocialMediaAuth> createState() => _SocialMediaAuthState();
}

class _SocialMediaAuthState extends ConsumerState<SocialMediaAuth> {
  bool loadingG = false;
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(googleAuthProvider);
    final authStateFb = ref.watch(facebookAuthProvider);
    return Column(
      children: [
        (widget.lineAtTop)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      color: KColors.hintColor,
                      height: 2,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        "o",
                        style: TextStyle(color: KColors.hintDarkColor),
                      )),
                  Expanded(
                    child: Container(
                      color: KColors.hintColor,
                      height: 2,
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        (widget.lineAtTop) ? const SizedBox(height: 25) : const SizedBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButtonWidget(
              icon: 'facebook',
              iconColor: Colors.blue,
              loading: authStateFb.isLoading,
              onTap: () async {
                final success = await ref
                    .read(facebookAuthProvider.notifier)
                    .loginWithFacebook();
                if (success && context.mounted) {
                  context.goNamed('home');
                }
              },
            ),
            const SizedBox(width: 25),
            IconButtonWidget(
              icon: 'google',
              iconColor: Colors.redAccent,
              loading: authState.isLoading,
              onTap: () async {
                print('google');
                final success = await ref
                    .read(googleAuthProvider.notifier)
                    .loginWithGoogle();
                if (success && context.mounted) {
                  context.goNamed('home');
                }
              },
            ),
          ],
        ),
        (!widget.lineAtTop) ? const SizedBox(height: 35) : const SizedBox(),
        (!widget.lineAtTop)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      color: KColors.hintColor,
                      height: 2,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        "o",
                        style: TextStyle(color: KColors.hintDarkColor),
                      )),
                  Expanded(
                      child: Container(
                    color: KColors.hintColor,
                    height: 2,
                  )),
                  Expanded(
                    child: Container(
                      color: KColors.hintColor,
                      height: 2,
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        (!widget.lineAtTop) ? const SizedBox(height: 15) : const SizedBox(),
      ],
    );
  }
}

class IconButtonWidget extends StatelessWidget {
  final Color color;
  final String icon;
  final VoidCallback? onTap;
  final bool isDisabled;
  final Color iconColor;
  final double borderRadius;
  final bool loading;

  const IconButtonWidget({
    super.key,
    this.onTap,
    this.borderRadius = 10,
    this.isDisabled = false,
    this.color = Colors.white,
    this.iconColor = KColors.primaryColor,
    required this.icon,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () async {
        if (!isDisabled || onTap != null || !loading) {
          onTap!();
          Haptics.vibrate(HapticsType.selection);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: ShadowStyle.generalShadow),
        child: (loading)
            ? LoadingStandardWidget.loadingWidget(25)
            : SvgPicture.asset("assets/icons/$icon.svg",
                height: 23, color: iconColor),
      ),
    );
  }
}
