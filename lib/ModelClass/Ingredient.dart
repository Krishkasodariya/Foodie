import 'dart:ui';

class Ingredient{
  String image;
  List<Offset>position=[];
  bool checkIngredient =false;


  Ingredient({required this.image,required this.position,required this.checkIngredient});

  bool compare(Ingredient ingredient){
    return ingredient.image==image;
  }

}