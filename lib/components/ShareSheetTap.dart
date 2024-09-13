import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/bloc/shareState/ShareSetup.dart';

import '../bloc/shareState/ShareLogic.dart';
import '../color_manager.dart';
import '../model/ShareModel.dart';

class ShareSheetTap extends StatelessWidget {
  final Uri linkN;

  ShareSheetTap({required this.linkN});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShareLogic(),
      child: BlocConsumer<ShareLogic, ShareState>(
        listener: (context, state) {},
        builder: (context, state) {
          ShareLogic obj = BlocProvider.of(context);
          List<ShareModel> apps = [
            ShareModel(
              GoLinke: () {
                obj.twitterShare(
                    link: linkN); // Corrected from Widget.link to link
              },
              imgPath: "assets/images/twitter.png",
              label: 'Twitter',
            ), //twitter
            ShareModel(
              GoLinke: () {
                obj.smsShare(link: linkN); // Corrected from Widget.link to link
              },
              imgPath: "assets/images/sms.png",
              label: 'sms',
            ), //sms
            ShareModel(
              GoLinke: () {
                obj.telegramShare(link: linkN); // Corrected from Widget.link to link
              },
              imgPath: "assets/images/telegram.webp",
              label: 'telegram',
            ), //telegram
            ShareModel(
              GoLinke: () {
                obj.whatsAppShare(link: linkN); // Corrected from Widget.link to link
              },
              imgPath: "assets/images/WhatsApp.png",
              label: 'WhatsApp',
            ), //WhatsApp
          ];
          return IconButton(
            icon:
                Icon(Icons.share, color: ColorManager.colorOffwhite, size: 40),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    height: 180,
                    child: Column(
                      children: [
                        Expanded(
                          child: Text(
                            "share to",
                            style: GoogleFonts.sevillana(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: ColorManager.primaryColor,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            for (int i = 0; i < apps.length; i++)
                              Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: InkWell(
                                  onTap: () {
                                    apps[i].GoLinke();
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(apps[i].imgPath,
                                          width: 70,
                                          height: 50,
                                          fit: BoxFit.fill),
                                      SizedBox(height: 8),
                                      Text(apps[i].label),
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
