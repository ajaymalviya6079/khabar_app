import 'package:flutter/material.dart';

import '../../Utils/colors.dart';

class ePaparView extends StatefulWidget {
  const ePaparView({super.key});

  @override
  State<ePaparView> createState() => _ePaparViewState();
}

class _ePaparViewState extends State<ePaparView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.offWhit,
        title: const Text('E-Paper',style: TextStyle(fontWeight: FontWeight.w700),),
      ),
      body:  ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
                height:150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Center(child: Text('Data Not Found',style: TextStyle(fontWeight: FontWeight.w700),))
            ),
          );
        },
      ),
    );
  }
}
