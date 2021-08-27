import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/conditional_builder.dart';
import 'package:shop_app/business_logic/cubit/shop_cubit.dart';
import 'package:shop_app/data/models/home_model.dart';
import 'package:shop_app/ui/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null,
          builder: (context) => _buildHome(ShopCubit.get(context).homeModel!),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildHome(HomeModel model) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            items: model.data!.banners
                .map((e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ))
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: GridView.count(
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.5,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(model.data!.products.length,
                  (index) => _buildGridProducts(model.data!.products[index])),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridProducts(HomeProductModel model) {
    return Card(
      shadowColor: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                if (model.discount != 0)
                  Container(
                    
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ]),
            ),
            Text(
              '${model.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(height: 1.2),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    Text(
                      '${model.price.round()} EGP',
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()} EGP',
                        style: TextStyle(
                            height: 1.2,
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                  ],
                ),
                Spacer(),
                Expanded(
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.favorite_border)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
