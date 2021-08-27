import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/cubit/shop_cubit.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/ui/screen/search_screen.dart';
import 'package:shop_app/ui/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("My Shop" , style: TextStyle(color: defaultColor),),
            actions: [
              IconButton(
                color: defaultColor,
                  onPressed: () {
                    navigatTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottom(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.apps,
                  ),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'Settings',
                )
              ]),
        );
      },
    );
  }
}
