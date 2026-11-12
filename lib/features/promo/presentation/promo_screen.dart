import 'dart:developer';

import 'package:aitek_task/common_widget/custom_app_bar_widget.dart';
import 'package:aitek_task/constants/text_font_style.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:aitek_task/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PromoScreen extends StatefulWidget {
  const PromoScreen({super.key});

  @override
  State<PromoScreen> createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
  @override
  void initState() {
    super.initState();
    promoRXObj.getPromoMaterials();
  }

  Future<void> _openPromo(String link) async {
    final uri = Uri.tryParse(link);
    if (uri == null ||
        (uri.scheme != 'https' && uri.scheme != 'http') ||
        uri.host.isEmpty) {
      _showLinkError();
      return;
    }

    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        _showLinkError();
      }
    } catch (error) {
      log('Promo link launch error: $error');
      _showLinkError();
    }
  }

  void _showLinkError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unable to open this promo link.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: CustomAppBar(title: 'Promo Materials', showLeadingIcon: false),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore our promotional materials',
                style: TextFontStyle.headlineRoboto40013Secondary,
              ),
              UIHelper.verticalSpace(20.h),
              Expanded(
                child: Obx(() {
                  if (promoRXObj.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF2563EB),
                      ),
                    );
                  }

                  final errorMessage = promoRXObj.errorMessage.value;
                  if (errorMessage != null) {
                    return _PromoMessage(
                      icon: Icons.cloud_off_outlined,
                      message: errorMessage,
                      actionLabel: 'Retry',
                      onAction: promoRXObj.getPromoMaterials,
                    );
                  }

                  final promoMaterials = promoRXObj.promoMaterials;
                  if (promoMaterials.isEmpty) {
                    return const _PromoMessage(
                      icon: Icons.campaign_rounded,
                      message: 'No promotional materials are available.',
                    );
                  }

                  return ListView.builder(
                    itemCount: promoMaterials.length,
                    itemBuilder: (context, index) {
                      final promo = promoMaterials[index];
                      final promoUri = Uri.tryParse(promo.link);
                      final canOpenPromo =
                          promoUri != null &&
                          (promoUri.scheme == 'https' ||
                              promoUri.scheme == 'http') &&
                          promoUri.host.isNotEmpty;

                      return Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: const Color(0xFFE8EDF5)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: promo.imageUrl.isEmpty
                                  ? _imagePlaceholder()
                                  : Image.network(
                                      promo.imageUrl,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) => _imagePlaceholder(),
                                    ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    promo.title,
                                    style:
                                        TextFontStyle.headlineRoboto80015Dark,
                                  ),
                                  if (promo.description.isNotEmpty) ...[
                                    UIHelper.verticalSpace(8.h),
                                    Text(
                                      promo.description,
                                      style: TextFontStyle
                                          .headlineRoboto40012SecondaryHeight15,
                                    ),
                                  ],
                                  UIHelper.verticalSpace(16.h),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 44.h,
                                    child: ElevatedButton.icon(
                                      onPressed: canOpenPromo
                                          ? () => _openPromo(promo.link)
                                          : null,
                                      icon: Icon(
                                        Icons.open_in_new_rounded,
                                        size: 17.r,
                                      ),
                                      label: Text(
                                        promo.buttonText,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextFontStyle
                                            .headlineRoboto70012Button,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _buttonColor(
                                          promo.buttonColor,
                                        ),
                                        foregroundColor: Colors.white,
                                        disabledBackgroundColor: const Color(
                                          0xFFCBD5E1,
                                        ),
                                        disabledForegroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            11.r,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: const Color(0xFFEFF6FF),
      child: Icon(
        Icons.image_rounded,
        size: 40.r,
        color: const Color(0xFF2563EB),
      ),
    );
  }

  Color _buttonColor(String value) {
    final hex = value.replaceFirst('#', '');
    if (!RegExp(r'^[0-9a-fA-F]{6}([0-9a-fA-F]{2})?$').hasMatch(hex)) {
      return const Color(0xFF2563EB);
    }
    final colorValue = int.parse(hex.length == 6 ? 'FF$hex' : hex, radix: 16);
    return Color(colorValue);
  }
}

class _PromoMessage extends StatelessWidget {
  const _PromoMessage({
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 76.r,
              width: 76.r,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(icon, size: 36.r, color: const Color(0xFF2563EB)),
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextFontStyle.headlineRoboto40013SecondaryHeight15,
            ),
            if (actionLabel != null && onAction != null)
              TextButton(onPressed: onAction, child: Text(actionLabel!)),
          ],
        ),
      ),
    );
  }
}
