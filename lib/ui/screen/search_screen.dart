import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/cubit/search_cubit.dart';
import 'package:shop_app/ui/styles/colors.dart';
import 'package:shop_app/ui/widgets/build_list_product.dart';
import 'package:shop_app/ui/widgets/form_field.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var textController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    defaultFormField(
                        controller: textController,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Enter text to search';
                          }

                          return null;
                        },
                        label: 'Search',
                        prefix: Icons.search,
                        onSubmit: (text) {
                          SearchCubit.get(context).search(text);
                        }),
                    SizedBox(height: 10.0),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => searchItemBuilder(
                            SearchCubit.get(context)
                                .searchModel!
                                .data
                                .data[index],
                            context,
                            isOldPrice:  false

                          ),
                          separatorBuilder: (context, index) => Container(height: 1, color: defaultColor,),
                          itemCount: SearchCubit.get(context)
                              .searchModel!
                              .data
                              .data
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
