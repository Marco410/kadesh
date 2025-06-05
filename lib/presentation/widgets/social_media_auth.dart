import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:pet_app/data/theme/style.dart';

class SocialMediaAuth extends StatefulWidget {
  final bool lineAtTop;
  const SocialMediaAuth({super.key, this.lineAtTop = true});

  @override
  State<SocialMediaAuth> createState() => _SocialMediaAuthState();
}

class _SocialMediaAuthState extends State<SocialMediaAuth> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (widget.lineAtTop)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      color: ColorsStyle.hintColor,
                      height: 2,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        "o",
                        style: TextStyle(color: ColorsStyle.hintDarkColor),
                      )),
                  Expanded(
                    child: Container(
                      color: ColorsStyle.hintColor,
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
                print("Facebook login pressed");
                final LoginResult result = await FacebookAuth.instance.login();
                print("result");
                print(result);
                if (result.status == LoginStatus.success) {
                  final AccessToken accessToken = result.accessToken!;
                } else {
                  print(result.status);
                  print(result.message);
                }
              },
            ),
            const SizedBox(width: 25),
            const IconButtonWidget(
              icon: 'google',
              iconColor: Colors.redAccent,
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
                      color: ColorsStyle.hintColor,
                      height: 2,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        "o",
                        style: TextStyle(color: ColorsStyle.hintDarkColor),
                      )),
                  Expanded(
                    child: Container(
                      color: ColorsStyle.hintColor,
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

  const IconButtonWidget({
    super.key,
    this.onTap,
    this.borderRadius = 10,
    this.isDisabled = false,
    this.color = Colors.white,
    this.iconColor = ColorsStyle.primaryColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        isDisabled ? null : onTap!() as void Function()?;
        Haptics.vibrate(HapticsType.selection);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: ShadowStyle.generalShadow),
        child: SvgPicture.asset("assets/icons/$icon.svg",
            height: 23, color: iconColor),
      ),
    );
  }
}
