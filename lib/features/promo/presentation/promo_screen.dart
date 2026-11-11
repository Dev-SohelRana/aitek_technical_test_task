import 'package:aitek_task/common_widget/custom_app_bar_widget.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoScreen extends StatefulWidget {
  const PromoScreen({super.key});

  @override
  State<PromoScreen> createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
  bool isLoading = false;

  final List<Map<String, dynamic>> promoMaterials = [
    {
      '  image': 'https://via.placeholder.com/400x200',
      'title': 'Promo 1',
      'description': 'Description for Promo 1',
    },
    {
      'image': 'https://via.placeholder.com/400x200',
      'title': 'Promo 2',
      'description': 'Description for Promo 2',
    },
    {
      'image': 'https://via.placeholder.com/400x200',
      'title': 'Promo 3',
      'description': 'Description for Promo 3',
    },
  ];

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
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF64748B),
                ),
              ),

              UIHelper.verticalSpace(20.h),

              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF2563EB),
                        ),
                      )
                    : promoMaterials.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 76.r,
                              width: 76.r,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(22.r),
                              ),
                              child: Icon(
                                Icons.campaign_rounded,
                                size: 36.r,
                                color: const Color(0xFF2563EB),
                              ),
                            ),

                            UIHelper.verticalSpace(16.h),

                            Text(
                              'No Promo Materials Available',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF0B1F45),
                              ),
                            ),

                            UIHelper.verticalSpace(7.h),

                            Text(
                              'Promotional materials will appear here.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: promoMaterials.length,
                        itemBuilder: (context, index) {
                          final promo = promoMaterials[index];

                          return Container(
                            margin: EdgeInsets.only(bottom: 16.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: const Color(0xFFE8EDF5),
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Image.network(
                                    promo['image'] ?? '',
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: const Color(0xFFEFF6FF),
                                        child: Icon(
                                          Icons.image_rounded,
                                          size: 40.r,
                                          color: const Color(0xFF2563EB),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.all(16.r),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        promo['title'] ?? '',
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF0B1F45),
                                        ),
                                      ),

                                      UIHelper.verticalSpace(8.h),

                                      Text(
                                        promo['description'] ?? '',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          height: 1.5,
                                          color: const Color(0xFF64748B),
                                        ),
                                      ),

                                      UIHelper.verticalSpace(16.h),

                                      SizedBox(
                                        width: double.infinity,
                                        height: 44.h,
                                        child: ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.open_in_new_rounded,
                                            size: 17.r,
                                          ),
                                          label: Text(
                                            'View Promo',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF2563EB,
                                            ),
                                            foregroundColor: Colors.white,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(11.r),
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
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
