import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/layout/cubit/home_layout_cubit.dart';
import 'package:my_shop/layout/cubit/home_layout_states.dart';
import 'package:my_shop/modules/getCarts/GetCarts.dart';
import 'package:my_shop/modules/search/search_screen.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context){
    return  BlocProvider.value(
      value: BlocProvider.of<HomeLayoutCubit>(context),

      child: BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
        builder: (context,state)=>Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Icon(
              Icons.air,color: Colors.teal,
            ),
            title: Text("AhmedFarid-Shop",style: TextStyle(color: Colors.teal,fontSize: 18),),
            actions: [
              IconButton(icon: Icon(Icons.search,color: Colors.teal,),onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Search()));
              },),
            ],
          ),
          body: HomeLayoutCubit.get(context).Screens[HomeLayoutCubit.get(context).indexBottomNavBar],
          floatingActionButton: FloatingActionButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>GetCarts()));
          },child: Icon(Icons.shopping_cart),backgroundColor: Colors.teal,),
          floatingActionButtonLocation :FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            backgroundColor: Colors.teal,
            icons: [
              Icons.home,
              Icons.category_outlined,
              Icons.favorite_outline_rounded,
              Icons.person,

            ],
            activeIndex: HomeLayoutCubit.get(context).indexBottomNavBar,
            onTap: (x){
              HomeLayoutCubit.get(context).changeIndexBottom(x);
            },
            activeColor: Colors.white,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.defaultEdge,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
          ),
        ),
        listener: (context,state){
        },
      ),
    );
  }
}
