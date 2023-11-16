import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:traka/core/utils/colors.dart';
import 'package:traka/core/utils/order_status.dart';
import 'package:traka/features/details/models/order_status.dart';

class TimelineWidget extends StatelessWidget {
  final List<OrderStatusModel> statuses;
  const TimelineWidget({Key? key, required this.statuses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double indicatorWidth = 30.w;
    return ListView.separated(
      separatorBuilder: (_, __) => SizedBox(height: 20.h),
      itemCount: statuses.length,
      itemBuilder: (context, index) {
        final child = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    statuses[index].status.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColor.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  DateFormat("HH:mm a").format(statuses[index].date),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColor.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            Text(
              statuses[index].status.description,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.lightGrey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        );

        final isFirst = index == 0;
        final isLast = index == statuses.length - 1;

        final timelineTile = <Widget>[
          CustomPaint(
            foregroundPainter: _TimelinePainter(
              indicatorWidth: indicatorWidth,
              hideDefaultIndicator: true,
              indicatorColor: Colors.yellow,
              isFirst: isFirst,
              isLast: isLast,
              itemGap: 20.h,
            ),
            child: SizedBox(
              width: indicatorWidth,
              height: double.infinity,
              child: CircleAvatar(
                radius: indicatorWidth,
                backgroundColor: AppColor.primary.withOpacity(.3),
                child: CircleAvatar(
                  radius: indicatorWidth - 20.w,
                  backgroundColor: AppColor.primary.withOpacity(.3),
                  child: CircleAvatar(
                      radius: indicatorWidth - 25.w,
                      backgroundColor: AppColor.primary),
                ),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(child: child),
        ];

        return IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: timelineTile,
          ),
        );
      },
    );
  }
}

class _TimelinePainter extends CustomPainter {
  _TimelinePainter({
    required this.hideDefaultIndicator,
    required this.indicatorColor,
    required this.isFirst,
    required this.isLast,
    required this.itemGap,
    required this.indicatorWidth,
  })  : linePaint = Paint()
          ..color = AppColor.primary
          ..strokeCap = StrokeCap.butt
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke,
        circlePaint = Paint()
          ..color = indicatorColor
          ..style = PaintingStyle.fill;

  final bool hideDefaultIndicator;
  final Color indicatorColor;
  final Paint linePaint;
  final Paint circlePaint;
  final bool isFirst;
  final bool isLast;
  final double itemGap;
  final double indicatorWidth;

  @override
  void paint(Canvas canvas, Size size) {
    double indicatorRadius = indicatorWidth / 2;
    double indicatorMargin = indicatorRadius + 4;

    final bottom = size.bottomLeft(
        Offset(indicatorRadius, 0.0 + (itemGap + indicatorMargin - 3)));
    final centerBottom =
        size.centerLeft(Offset(indicatorRadius, indicatorMargin));

    if (!isLast) canvas.drawLine(centerBottom, bottom, linePaint);

    if (!hideDefaultIndicator) {
      final Offset offsetCenter = size.centerLeft(Offset(indicatorRadius, 0));

      canvas.drawCircle(offsetCenter, indicatorRadius, circlePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
