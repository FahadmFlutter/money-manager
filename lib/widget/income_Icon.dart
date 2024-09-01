import 'package:flutter/material.dart';


class IncomeIcon extends StatelessWidget {
  final bool isIncome;
  const IncomeIcon({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    if(isIncome == true){
      return const Icon(Icons.south_west_rounded, color: Colors.green,);
    }else{
      return const Icon(Icons.north_east_rounded, color: Colors.red,);
    }
  }
}
