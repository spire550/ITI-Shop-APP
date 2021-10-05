import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/layout/cubit/home_layout_cubit.dart';
import 'package:my_shop/layout/cubit/home_layout_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop/models/getFavoritesModel.dart';
import 'package:my_shop/modules/productDetails/product_details.dart';

class Favorites extends StatelessWidget {
  Widget favoriteLoad = Icon(
    Icons.favorite_border,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: BlocProvider.of<HomeLayoutCubit>(context)..getFavorite(),
    child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        builder: (context, state) =>
        HomeLayoutCubit.get(context).getFavoritesModel == null
            ?
        Center(child: CircularProgressIndicator(color: Colors.teal,),)
 :
        HomeLayoutCubit.get(context).getFavoritesModel!.data.data.isEmpty?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "There is no product in your favourite try add some",textAlign: TextAlign.center,style: TextStyle(color: Colors.greenAccent.shade200,fontSize: 27),
            ),
          ],
        ):
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Container(
            color: Colors.grey[200],
            child: GridView.count(
              crossAxisCount: 1,
              children: List.generate(
                  HomeLayoutCubit.get(context)
                      .getFavoritesModel!
                      .data
                      .data
                      .length,
                      (index) => productsFavView(
                      HomeLayoutCubit.get(context).getFavoritesModel,
                      index,
                      HomeLayoutCubit.get(context).isFavorite,
                      context)),
            ),
          ),
        ),

        listener: (context, state) {
          if (state is SuccessChangeFav) {
            HomeLayoutCubit.get(context).getFavorite();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.user.message),
              backgroundColor: Colors.green,
              duration: Duration(milliseconds: 450),
            ));
          }
        }),);
  }
}

Widget productsFavView(FavoriteGetModel? model, index, Map<int, bool> fav, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0.5),
    child: GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(
            model!
            .data
            .data[index].product.id)));
      },
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Expanded(
                  child: Image.network(model!.data.data[index].product.image)),
              Text(model.data.data[index].product.name),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "${model.data.data[index].product.price.toString()} EGP",
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),

                  Spacer(),
                  CircleAvatar(
                    backgroundColor:
                        fav[model.data.data[index].product.id] ?? false
                            ? Colors.teal
                            : Colors.grey[300],
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        HomeLayoutCubit.get(context).changeFavorite(
                            id: model.data.data[index].product.id);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
