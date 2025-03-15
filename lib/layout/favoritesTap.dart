import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/dstate/d_logic.dart';
import '../bloc/dstate/d_state.dart';
import '../color_manager.dart';
import '../components/CustomNews.dart';
import 'HomeTab/NewsDetails.dart';

class FavororitesTab extends StatelessWidget {
  static const String routeName = 'Favororites Screen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DLogic()..createDatabaseAndTable(),
        child: BlocConsumer<DLogic, DState>(
          listener: (context, state) {},
          builder: (context, state) {
            DLogic DObject = BlocProvider.of(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Favororites",
                  style: GoogleFonts.sevillana(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: ColorManager.primaryColor,
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                centerTitle: true,
              ),
              body: Container(
                color: Theme.of(context).colorScheme.primary,
                width: double.infinity,
                height: double.infinity,
                child: DObject.favouriteList.isEmpty
                    ? Center(
                        child: Text(
                          "NO Favourite now",
                          style: GoogleFonts.abhayaLibre(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: DObject.favouriteList.length,
                          itemBuilder: ( context,  index) {
                            return CustomNews(
                              iconSec:Icons.favorite,
                              urlImage:
                              DObject.favouriteList[index]["imageUrl"] ?? '',
                              title:
                              DObject.favouriteList[index]["title"] ?? 'No title',
                              linkN: DObject.favouriteList[index]["url"] != null
                                  ? Uri.parse(DObject.favouriteList[index]["url"])
                                  : Uri(),

                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetails(
                                      url: DObject.favouriteList[index]["url"] ?? '',
                                    ),
                                  ),
                                );
                              }, onPressedSec: () {
                              DObject.deleteFavouriteElement(title: DObject.favouriteList[index]["title"]); },
                            );
                          },

                        ),
                      ),
              ),
            );
          },
        ));
  }
}
