import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:pet_app/data/theme/style.dart';
import 'package:pet_app/domain/providers/auth_provider.dart';
import 'package:pet_app/presentation/widgets/loading_widget.dart';

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
    return Column(
      children: [
        (widget.lineAtTop)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      color: ColorStyle.hintColor,
                      height: 2,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        "o",
                        style: TextStyle(color: ColorStyle.hintDarkColor),
                      )),
                  Expanded(
                    child: Container(
                      color: ColorStyle.hintColor,
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
              onTap: () async {
                /*  print("Facebook login pressed");
                final LoginResult result = await FacebookAuth.instance.login();
                print("result");
                print(result);
                if (result.status == LoginStatus.success) {
                  final AccessToken accessToken = result.accessToken!;
                } else {
                  print(result.status);
                  print(result.message);
                } */
              },
            ),
            const SizedBox(width: 25),
            IconButtonWidget(
              icon: 'google',
              iconColor: Colors.redAccent,
              loading: authState.isLoading,
              onTap: () async {
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
                      color: ColorStyle.hintColor,
                      height: 2,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        "o",
                        style: TextStyle(color: ColorStyle.hintDarkColor),
                      )),
                  Expanded(
                    child: Container(
                      color: ColorStyle.hintColor,
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
  final Function()? onTap;
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
    this.iconColor = ColorStyle.primaryColor,
    required this.icon,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () async {
        if (!isDisabled || onTap != null || !loading) {
          await onTap!();
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
