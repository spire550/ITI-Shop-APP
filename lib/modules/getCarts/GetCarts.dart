import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/layout/cubit/home_layout_cubit.dart';
import 'package:my_shop/layout/cubit/home_layout_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop/models/getCartModel.dart';
class GetCarts extends StatelessWidget {
  const GetCarts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: BlocProvider.of<HomeLayoutCubit>(context)..getAllCarts(),
    child: BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
            builder:(context,state)=>Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.teal
          ),
        ),
    body: HomeLayoutCubit.get(context).getCartModel == null? Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50.0),
    child: Center(child: LinearProgressIndicator(color: Colors.teal,)),
    ) :HomeLayoutCubit.get(context).getCartModel!.data.cartItems.isEmpty? Center(child: Text("There is  no items here :(",style: TextStyle(color: Colors.teal.shade200,fontSize: 25,),)) :
    ListView(
      children: [
        Container(
        color: Colors.grey[200],
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
        crossAxisCount: 1,
        children: List.generate(HomeLayoutCubit.get(context).getCartModel!.data.cartItems.length, (index) => productsView(HomeLayoutCubit.get(context).getCartModel,index,context)),),
        ),
        SizedBox(height: 15,),
        Container(
          child: Text("Total Price : ${HomeLayoutCubit.get(context).getCartModel!.data.total} EGP",style: TextStyle(color: Colors.white,fontSize: 25),textAlign: TextAlign.center,),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.teal),),
      ],
    ),),
    listener: (context,state){
              if(state is SuccessCart){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deleted Succefully"),backgroundColor: Colors.green,duration: Duration(milliseconds: 350),));
              }
    },
    ));
  }
}
Widget productsView(GetCartModel? model,index,context){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0.5,vertical: 0.5),
    child: Container(
      decoration: BoxDecoration(
        color:Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(child: Image.network(model!.data.cartItems[index].product.image)),
            Text(model.data.cartItems[index].product.name),
            SizedBox(height: 5,),
            Row(
              children: [
                IconButton(onPressed: (){
                  HomeLayoutCubit.get(context).minusQuantity(model,index);
                  HomeLayoutCubit.get(context).updateCartData(id: model.data.cartItems[index].id.toString(),quantity: HomeLayoutCubit.get(context).quantity);
                },icon: Icon(Icons.remove),color: Colors.teal,),


                SizedBox(width: 2,),
              Text(model.data.cartItems[index].quantity.toString(),style: TextStyle(color: Colors.teal,fontSize: 25),),
                SizedBox(width: 2,),


                IconButton(onPressed: (){
                HomeLayoutCubit.get(context).plusQuantity(model,index);
                HomeLayoutCubit.get(context).updateCartData(id: model.data.cartItems[index].id.toString(),quantity: HomeLayoutCubit.get(context).quantity);
                },icon: Icon(Icons.add),color: Colors.teal,),
            ],),
            SizedBox(height: 5,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text("${model.data.cartItems[index].product.price.toString()} EGP",style: TextStyle(color: Colors.teal),),
                ),
                Spacer(),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Row(
                      children: [
                      Icon(Icons.restore_from_trash_outlined,color: Colors.redAccent,),
                      Text("Remove Product",style: TextStyle(color: Colors.redAccent),)
                    ],),
                  ),
                  onTap: (){
                    HomeLayoutCubit.get(context).changeCart(id: model.data.cartItems[index].product.id);
                  },
                ),
              ],
            ),
            SizedBox(height: 8,),
          ],
        ),
      ),
    ),
  );
}