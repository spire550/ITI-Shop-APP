import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:my_shop/models/cartModel.dart';
import 'package:my_shop/models/categoriesModel.dart';
import 'package:my_shop/models/categoryDetailsModel.dart';
import 'package:my_shop/models/getCartModel.dart';
import 'package:my_shop/models/getFavoritesModel.dart';
import 'package:my_shop/models/homeModel.dart';
import 'package:my_shop/models/productDetailsModel.dart';
import 'package:my_shop/models/profileModel.dart';
import 'package:my_shop/models/searchModel.dart';
import 'package:my_shop/models/userModel.dart';
import 'package:my_shop/modules/categories/categories_screen.dart';
import 'package:my_shop/modules/favorite/favorite_screen.dart';
import 'package:my_shop/modules/home/home_screen.dart';
import 'package:my_shop/modules/settings/settings_screen.dart';
import 'package:my_shop/shared/components/constance.dart';
import 'package:my_shop/shared/network/endBoints.dart';
import 'package:my_shop/shared/network/remote/dio_helper.dart';

import 'home_layout_states.dart';
class HomeLayoutCubit extends Cubit<HomeLayoutStates>{
  HomeLayoutCubit() : super(HomeLayoutInitialState());

  static HomeLayoutCubit get(context)=>BlocProvider.of(context);

  HomeModel? homeModel;
  Map<int,bool> isCart = {};
  void getHomeData(){
    emit(LoadingGetHomeData());
    DioHelper.getData(path: HOME, Token: Token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((e) {
        isFavorite.addAll({e.id:e.inFavorites});
      });
      homeModel!.data!.products.forEach((element) {
        isCart.addAll({element.id:element.inCart});
      });
      emit(SuccessGetHomeData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetHomeData());
    });
  }

  List<Widget> Screens = [
    Home(),
    Categories(),
    Favorites(),
    Settings(),
  ];
  int indexBottomNavBar = 0;
  void changeIndexBottom(int x){
    indexBottomNavBar = x;
    emit(BottomNavBarChanged());
  }

  CategoriesModel? categoriesModel;
  void getCategories(){
    emit(LoadingGetCategoriesData());
    DioHelper.getData(path: CATEGORIES, Token: Token).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccessGetCategoriesData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetCategoriesData());
    });
  }

  Map<int,bool> isFavorite ={};

  UserData? favoriteData;
  void changeFavorite({required int id}){
    emit(LoadingChangeFav());
    DioHelper.postData(path: FAVORITE, data: {
      'product_id':id
    },Token: Token).then((value) {
      isFavorite[id] = !(isFavorite[id]??false);
      favoriteData = UserData.fromJson(value.data);
      emit(SuccessChangeFav(favoriteData!));
    }).catchError((error){
      emit(ErrorChangeFav());
    });
  }

  FavoriteGetModel? getFavoritesModel;
  void getFavorite(){
    emit(LoadingGetFavoritesData());
    DioHelper.getData(path: FAVORITE, Token: Token).then((value){
      getFavoritesModel = FavoriteGetModel.fromJson(value.data);
      emit(SuccessGetFavoritesData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetFavoritesData());
    });
  }

  SearchModel? searchModel;
  void getSearchProduct({required String txt}){
    emit(LoadingSearch());
    DioHelper.postData(path: SEARCH, data: {
      'text':txt
    },Token: Token).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SuccessSearch());
    }).catchError((error){
      emit(ErrorSearch());
    });
  }

  ProfileModel? profileModel;
  void getProfile(){
    emit(LoadingGetProfilesData());
    DioHelper.getData(path: PROFILE, Token: Token).then((value){
      profileModel = ProfileModel.fromJson(value.data);
      emit(SuccessGetProfileData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetProfileData());
    });
  }

  void updateData({required String email,required String name,required String phone,}){
    emit(LoadingUpdate());
    DioHelper.putData(path: UPDATE, data: {
      'name':name,
      'email':email,
      'phone':phone,
    },Token: Token).then((value) {
      getProfile();
      emit(SuccessUpdate());
    }).catchError((error){
      emit(ErrorUpdate());
    });
  }

  ProductDetailsModel? productDetailsModel;
  void getProductDetails(String id){
    emit(LoadingGetProductsDetailsData());
    DioHelper.getData(path: "${PRODUCTSDETAILS+id}", Token: Token).then((value){
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(SuccessGetProductsDetailsData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetProductsDetailsData());
    });
  }

  int value = 0;
  void changeVal(val){
    value = val;
    emit(ChangeIndicatorState());
  }



  CategoryDetailsModel? categoyDetails;
  void getCategoryDetail({
    required int? catId
  }){
    emit(LoadingGetCAtegoryDetailsData());
    DioHelper.getData(path: PRODUCTS, Token: Token,data: {
      'category_id':catId,
    }).then((value){
      categoyDetails = CategoryDetailsModel.fromJson(value.data);
      emit(SuccessGetCAtegoryDetailsData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetCAtegoryDetailsData());
    });
  }

  GetCartModel? getCartModel;
  void getAllCarts(){
    emit(LoadinggetAllCarts());
    DioHelper.getData(path: CARTS, Token: Token).then((value){
      getCartModel = GetCartModel.fromJson(value.data);
      emit(SuccessgetAllCarts());
    }).catchError((error){
      print(error.toString());
      emit(ErrorgetAllCarts());
    });
  }


  CartModel? cartModel;
  void changeCart({required int id}){
    emit(LoadingCart());
    DioHelper.postData(path: CARTS, data: {
      'product_id':id
    },Token: Token).then((value) {
      isCart[id] = !(isCart[id]??false);
      getAllCarts();
      cartModel = CartModel.fromJson(value.data);
      emit(SuccessCart(cartModel!));
    }).catchError((error){
      print(error.toString());
      emit(ErrorCart());
    });
  }

  int quantity = 1;
  void plusQuantity(GetCartModel model,index){
    quantity = model.data.cartItems[index].quantity;
    quantity++;
    emit(plusDone());
  }

  void minusQuantity(GetCartModel model,index){
    quantity = model.data.cartItems[index].quantity;
    if(quantity >1)
    quantity--;
    emit(minusDone());
  }
  void updateCartData({required String id,int? quantity}){
    emit(LoadinggetCountCarts());
    DioHelper.putData(path:"${CARTSUPDATE+id}", data: {
      'quantity':quantity
    },Token: Token).then((value) {
      getAllCarts();
      emit(SuccessgetCountCarts());
    }).catchError((error){
      emit(ErrorgetCountCarts());
    });
  }

}