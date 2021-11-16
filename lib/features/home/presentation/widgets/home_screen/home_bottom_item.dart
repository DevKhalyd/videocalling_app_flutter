import 'package:flutter/material.dart';

import '../../../../../core/widgets/mini_widgets.dart';

/// Item to use with `HomeBottomNavigation`
class HomeBottomItem extends StatelessWidget {
  const HomeBottomItem({
    Key? key,
    required this.iconSelected,
    required this.iconNotSelected,
    required this.label,
    this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  final IconData iconSelected, iconNotSelected;
  final String label;
  final bool isSelected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? iconSelected : iconNotSelected,
              color: Colors.white,
            ),
            Space(0.005),
            TextCustom(
              label,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
