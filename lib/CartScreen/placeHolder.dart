import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


Widget myPlaceHoler(BuildContext context){
  return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor:Colors.black26,
      direction: ShimmerDirection.ltr,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.3,
        child:Card()
  ),
  );
}