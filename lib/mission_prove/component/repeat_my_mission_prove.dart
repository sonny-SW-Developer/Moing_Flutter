import 'package:flutter/material.dart';
import 'package:moing_flutter/const/color/colors.dart';
import 'package:moing_flutter/const/style/text.dart';
import 'package:moing_flutter/mission_prove/mission_prove_state.dart';
import 'package:provider/provider.dart';

class RepeatMyMissionProved extends StatelessWidget {
  const RepeatMyMissionProved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
            (context, index) {
              return renderContainer(index: index, context: context);
            },
          childCount: context.watch<MissionProveState>().myMissionList!.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 172/155,
        ),
      ),
    );
  }

  Widget renderContainer({
    required int index,
    required BuildContext context,
  }) {
    int initialIndex = 0;
    TextStyle ts = bodyTextStyle.copyWith(fontWeight: FontWeight.w500, color: grayScaleGrey200);

    if(context.watch<MissionProveState>().myMissionList![initialIndex].way == 'PHOTO') {
      return Container(
        color: Colors.transparent,
        child: Center(
          child: Text(
            '${index.toString()}번째 사진입니다.',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 30.0,
            ),
          ),
        ),
      );
    }
    // 텍스트인 경우
    else if(context.watch<MissionProveState>().myMissionList![initialIndex].way == 'TEXT') {
      return Container(
        color: grayScaleGrey700,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 12),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: grayScaleGrey500,
                ),
                child: Center(
                  child: Text(
                    '${context.watch<MissionProveState>().myMissionList!.length - index}',
                    style: bodyTextStyle.copyWith(color: grayScaleGrey400),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final String text = context.watch<MissionProveState>().myMissionList![index].archive;
                final TextStyle textStyle = bodyTextStyle.copyWith(fontWeight: FontWeight.w500, color: grayScaleGrey200);
                final TextSpan textSpan = TextSpan(text: text, style: textStyle);
                final TextPainter textPainter = TextPainter(
                  text: textSpan,
                  maxLines: 3,
                  textDirection: TextDirection.ltr,
                );

                textPainter.layout(maxWidth: constraints.maxWidth);

                // overflow 발생 시
                if (textPainter.didExceedMaxLines) {
                  print('${context.watch<MissionProveState>().myMissionList!.length - index}번째에서 오버플로우 발생했습니다.');
                  return Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: textStyle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '...',
                          style: textStyle,
                        ),
                      ],
                    ),
                  );
                }
                // 오버플로우 발생 X
                else {
                  return Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      text,
                      style: textStyle,
                      maxLines: 3,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      );
    }
    // 링크인 경우
    else {
      return Container(
        color: grayScaleGrey700,
        child: Center(
          child: Text(
            '${index.toString()}번째 링크입니다.',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 30.0,
            ),
          ),
        ),
      );
    }
  }
}
