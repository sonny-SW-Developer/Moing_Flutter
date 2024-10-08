import 'package:flutter/material.dart';
import 'package:moing_flutter/const/color/colors.dart';
import 'package:moing_flutter/home/component/home_card_scroll.dart';
import 'package:moing_flutter/home/component/home_my_meeting.dart';
import 'package:moing_flutter/home/component/home_nickname_and_encourage.dart';
import 'package:moing_flutter/home/component/home_no_card.dart';
import 'package:moing_flutter/home/home_screen_state.dart';
import 'package:moing_flutter/utils/alert_dialog/alert_dialog.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  static route(BuildContext context) {
    String newCreated = "";
    if (ModalRoute.of(context)?.settings.arguments != null) {
      newCreated = ModalRoute.of(context)?.settings.arguments as String;
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                HomeScreenState(context: context, newCreated: newCreated)),
      ],
      builder: (context, _) {
        return const HomeScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    const maxTeamBlockLength = 3;
    final teamBlockLength =
        context.watch<HomeScreenState>().futureData?.teamBlocks.length ?? 0;

    return Scaffold(
      backgroundColor: grayBackground,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: screenHeight <= 640
                  ? const ClampingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: screenHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: HomeText(
                          nickName:
                              '${context.watch<HomeScreenState>().futureData?.memberNickName ?? '모닥불'}님,',
                          encourage: '오늘도 모잉이 응원해요!'),
                    ),
                    const SizedBox(height: 40.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: HomeMyMeeting(
                        meetingCount: context
                                .watch<HomeScreenState>()
                                .futureData
                                ?.numOfTeam
                                .toString() ??
                            '0',
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    (context.watch<HomeScreenState>().futureData?.numOfTeam ??
                                0) >
                            0
                        ? const HomeCardScroll()
                        : const HomeNoCard(),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 16.0,
              child: ElevatedButton(
                onPressed: teamBlockLength < maxTeamBlockLength
                    ? context.read<HomeScreenState>().makeGroupPressed
                    : () {
                        ViewUtil().showErrorSnackBar(
                          context: context,
                          message: '모임은 최대 3개까지 들어갈 수 있어요',
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: teamBlockLength < maxTeamBlockLength
                      ? grayScaleWhite
                      : grayScaleGrey500,
                  foregroundColor: teamBlockLength < maxTeamBlockLength
                      ? grayScaleGrey900
                      : grayScaleGrey700,
                  textStyle: const TextStyle(
                    color: grayScaleGrey300,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 20.0,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
                child: const Text(
                  '모임 +',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
