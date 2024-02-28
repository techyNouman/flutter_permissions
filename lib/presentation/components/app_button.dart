import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key? key, required this.btnText, required this.btnFun})
      : super(key: key);
  final String btnText;
  final Function btnFun;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => btnFun(),
      style: getBtnStyle(context),
      child: Text(btnText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900),),
    );
  }
  getBtnStyle(context) => ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.blue,
      // fixedSize: Size(MediaQuery.of(context).size.width - 40, 47),
      // textStyle: const TextStyle(fontWeight: FontWeight.normal,fontSize: 20, color: Colors.white)
  );
}