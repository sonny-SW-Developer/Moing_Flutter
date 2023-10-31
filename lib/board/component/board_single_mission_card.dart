import 'package:flutter/material.dart';

import '../../const/color/colors.dart';

class BoardSingleMissionCard extends StatelessWidget {
  final String title;
  final String status;
  final String dueTo;
  final String missionType;
  final int missionId;
  final VoidCallback onTap;

  const BoardSingleMissionCard({
    super.key,
    required this.title,
    required this.status,
    required this.dueTo,
    required this.missionType,
    required this.missionId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 95,
          decoration: BoxDecoration(
            color: grayScaleGrey700,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20, bottom: 20),
            child: Row(
              children: [
                Image.asset(
                  status == 'SKIP'
                      ? 'asset/image/board_icon_nopass.png'
                      : 'asset/image/board_icon_pass.png',
                  width: 36.0,
                  height: 36.0,
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'asset/image/clock.png',
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          dueTo,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: grayScaleGrey550,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: grayScaleGrey100,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                status == 'SKIP' ? SkipButton() : CompleteButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class CompleteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 87,
      height: 43,
      margin: const EdgeInsets.only(right: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: grayScaleWhite,
          padding: const EdgeInsets.all(12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
        child: const Text(
          '완료하기',
          style: TextStyle(
            color: grayScaleGrey700,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class SkipButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 87,
      height: 43,
      margin: const EdgeInsets.only(right: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: grayScaleGrey500,
          padding: const EdgeInsets.all(12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
        child: const Text(
          '현황보기',
          style: TextStyle(
            color: grayScaleGrey300,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
