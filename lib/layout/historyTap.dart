import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/color_manager.dart';

import '../bloc/dstate/d_logic.dart';
import '../bloc/dstate/d_state.dart';
import '../components/CustomNews.dart';
import 'HomeTab/NewsDetails.dart';

class HistoryTab extends StatelessWidget {
  static const String routeName = 'History screen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DLogic()..createDatabaseAndTable()..showFavourite(),
        child: BlocConsumer<DLogic, DState>(
          listener: (context, state) {},
          builder: (context, state) {
            DLogic DObject =BlocProvider.of(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "History",
                  style: GoogleFonts.sevillana(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: ColorManager.primaryColor,
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: (){
                        DObject.clearHistory();
                      },
                      icon: Icon(Icons.delete_forever
                      ,color: ColorManager.primaryColor
                        ,size: 40,))
                ],
              ),
              body: Container(
                color: Theme.of(context).colorScheme.primary,
                width: double.infinity,
                height: double.infinity,
                child:
                DObject.favouriteList.isEmpty?
                Center(child: Text(
                  "NO news visit ..",
                  style: GoogleFonts.abhayaLibre(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.secondary,
                  ),),):
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for(int i =DObject.historyList.length-1;i > 0;i--)
                          if (DObject.historyList[i]["imageUrl"] != null)
                            CustomNews(
                              urlImage: DObject.historyList[i]["imageUrl"] ?? '',
                              title: DObject.historyList[i]["title"] ?? 'No title',
                              linkN: DObject.historyList[i]["url"]?? '',
                              onPressedFav: () {
                                DObject.deleteHistoryElement(title: DObject.historyList[i]["title"]);
                              },
                              iconFav: Icons.delete,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetails(
                                      url: DObject.historyList[i]["url"]?? '',
                                    ),
                                  ),
                                );
                              },
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
