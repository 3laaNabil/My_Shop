import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import 'package:shop_app/business_logic/cubit/shop_cubit.dart';
import 'package:shop_app/data/models/favorites_model.dart';

import 'package:shop_app/ui/widgets/build_list_product.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          child: Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  state is! ShopLoadingGetFavoritesState,
              widgetBuilder: (context) => ListView.builder(
                  itemBuilder: (context, index) => buildListProduct(
                      ShopCubit.get(context)
                          .favoritesModel!
                          .data
                          .data[index]
                          .product,
                      context
                      ),
                  itemCount:
                      ShopCubit.get(context).favoritesModel!.data.data.length),
              fallbackBuilder: (context) =>
                  Center(child: CircularProgressIndicator())),
        );

      },
    );
  }
}


