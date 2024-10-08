import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          childAspectRatio: 172 / 155,
        ),
      ),
    );
  }

  Widget renderContainer({
    required int index,
    required BuildContext context,
  }) {
    if (context.watch<MissionProveState>().myMissionList![index].status == 'SKIP') {
      return GestureDetector(
        onTap: () {
          context.read<MissionProveState>().getMissionDetailContent(index);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: grayScaleGrey700,
          ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  context.watch<MissionProveState>().myMissionList![index].archive,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: bodyTextStyle.copyWith(color: grayScaleGrey200, fontWeight: FontWeight.w500),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 12, bottom: 12),
                child: Text(
                  '미션을 건너뛰었어요',
                  style: bodyTextStyle.copyWith(color: grayScaleGrey400),
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (context.watch<MissionProveState>().myMissionList![index].way == 'PHOTO' &&
        context.watch<MissionProveState>().myMissionList![index].status == 'COMPLETE') {
      return Stack(
        children: [
          GestureDetector(
            onTap: () {
              context.read<MissionProveState>().getMissionDetailContent(index);
            },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 172,
                  height: 155,
                  child: Image.network(
                    context.watch<MissionProveState>().myMissionList![index].archive,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Positioned(
            left: 12,
            top: 12,
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
        ],
      );
    }
    // 텍스트인 경우
    else if (context
                .watch<MissionProveState>()
                .myMissionList![index]
                .way ==
            'TEXT' &&
        context
                .watch<MissionProveState>()
                .myMissionList![index]
                .status ==
            'COMPLETE') {
      return GestureDetector(
        onTap: () {
          context.read<MissionProveState>().getMissionDetailContent(index);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: grayScaleGrey700,
          ),
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
                  final String text = context
                      .watch<MissionProveState>()
                      .myMissionList![index]
                      .archive;
                  final TextStyle textStyle = bodyTextStyle.copyWith(
                      fontWeight: FontWeight.w500, color: grayScaleGrey200);
                  final TextSpan textSpan =
                      TextSpan(text: text, style: textStyle);
                  final TextPainter textPainter = TextPainter(
                    text: textSpan,
                    maxLines: 3,
                    textDirection: TextDirection.ltr,
                  );

                  textPainter.layout(maxWidth: constraints.maxWidth);

                  // overflow 발생 시
                  if (textPainter.didExceedMaxLines) {
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
        ),
      );
    }
    // 링크인 경우
    else {
      return GestureDetector(
        onTap: () {
          context.read<MissionProveState>().getMissionDetailContent(index);
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: grayScaleGrey700,
            ),
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
                Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 20),
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        final String text = context
                            .watch<MissionProveState>()
                            .myMissionList![index]
                            .archive;
                        final TextStyle textStyle = bodyTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            color: grayScaleGrey400);
                        final TextSpan textSpan =
                            TextSpan(text: text, style: textStyle);
                        final TextPainter textPainter = TextPainter(
                          text: textSpan,
                          maxLines: 1,
                          textDirection: TextDirection.ltr,
                        );

                        textPainter.layout(maxWidth: constraints.maxWidth);
                        // 텍스트 길이가 8자 이상이면서 실제 레이아웃 상에서 넘칠 경우
                        if (text.length > 7 || textPainter.didExceedMaxLines) {
                          return Text(
                            text,
                            style: textStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        } else {
                          return Text(
                            text,
                            style: textStyle,
                            maxLines: 1,
                          );
                        }
                      },
                    )),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'asset/icons/icon_link_white.svg',
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '바로보기',
                        style: bodyTextStyle.copyWith(color: grayScaleGrey100),
                      ),
                    ],
                  ),
                )
              ],
            )),
      );
    }
  }
}
