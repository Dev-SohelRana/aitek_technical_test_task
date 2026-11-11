import 'package:aitek_task/features/home/presentation/home_screen.dart';
import 'package:aitek_task/features/profile/presentation/profile_screen.dart';
import 'package:aitek_task/features/signals/presentation/signals_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'constants/text_font_style.dart';
import 'helpers/ui_helpers.dart';

class NavigationScreen extends StatefulWidget {
  final int? pageNum;

  const NavigationScreen({super.key, this.pageNum});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SignalsScreen(),
    const ProfileScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.pageNum ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        height: 72.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: const Color(0xFFE8EDF5), width: 0.7),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 15.r,
              offset: Offset(0, -3.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildNavItem(
                0,
                Icons.home_rounded,
                Icons.home_outlined,
                'Home',
              ),
            ),
            Expanded(
              child: _buildNavItem(
                1,
                Icons.candlestick_chart_rounded,
                Icons.candlestick_chart_outlined,
                'Signals',
              ),
            ),
            Expanded(
              child: _buildNavItem(
                2,
                Icons.campaign_rounded,
                Icons.campaign_outlined,
                'Promo',
              ),
            ),
            Expanded(
              child: _buildNavItem(
                3,
                Icons.person_rounded,
                Icons.person_outline_rounded,
                'Profile',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData selectedIcon,
    IconData unselectedIcon,
    String title,
  ) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF2563EB).withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? selectedIcon : unselectedIcon,
              size: 23.r,
              color: isSelected
                  ? const Color(0xFF2563EB)
                  : const Color(0xFF94A3B8),
            ),

            UIHelper.verticalSpace(4.h),

            Text(
              title.tr,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextFontStyle.headlinePublicSans70014.copyWith(
                fontSize: 11.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF2563EB)
                    : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
