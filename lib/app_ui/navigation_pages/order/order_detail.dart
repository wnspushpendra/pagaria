import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/modal/login/MarketingExecutiveLoginResponse.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/download_pdf_util.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () async {
              User? user = await getUserPref(userProfileDataPrefecences);
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushReplacementNamed(context, homeRoute,arguments: user);
              });
            },
          ),
          titleSpacing: 0,
          title: const NormalText(text:'Order Detail' ),
          actions: [
            IconButton(onPressed: (){
         // downloadAndOpenFile();
            }, icon: const Icon(Icons.download_for_offline))
        ],
      ),


      body: /*SfPdfViewer.network(
        "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf",
        canShowScrollHead: false,
        canShowPaginationDialog: false,
        enableDoubleTapZooming: true,
        enableTextSelection: true,
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          // Handle load failed event
          print("error :  ${details.error}");
        },
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          print('Document loaded');
        },
      )*/
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin:  EdgeInsets.fromLTRB(12.h,12.h,12.h,6.h),
              padding:  EdgeInsets.all(8.h),
              decoration: defaultDecoration,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      children: [
                        Expanded(
                          flex : 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BodyText(text: 'Customer Name',color: primaryColor,),
                              BodyText(text: 'Yuvraj Singh'),
                            ],
                          ),
                        ),
                        Expanded(
                          flex : 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BodyText(text: mobileNumber,color: primaryColor,),
                              BodyText(text: '0123456779'),
                            ],
                          ),
                        )
                      ]),
                  Space(height: 6,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyText(text: email,color: primaryColor,),
                      BodyText(text: 'yuvi@gmail.com'),
                    ],
                  ),
                  Space(height: 6,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyText(text: "address",color: primaryColor,),
                      BodyText(text: '54 vijay nagar indore'),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin:  EdgeInsets.fromLTRB(12.h,6.h,12.h,6.h),
              padding:  EdgeInsets.fromLTRB(8.h,12.h,8.h,8.h),
              decoration: defaultDecoration,
              child: Column(
                children: [
                 // const BodyText(text: 'Category',color: primaryColor,fontWeight: FontWeight.bold,),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget> [
                      Expanded(flex: 3, child: BodyText(text: 'Product Name',align: TextAlign.start,color: primaryColor,)),
                     // Expanded(flex: 2, child: BodyText(text: 'Category',align: TextAlign.start,color: primaryColor,)),
                      Expanded(flex: 3, child: BodyText(text: 'Price',align: TextAlign.start,color: primaryColor,)),
                      Expanded(flex: 1, child: BodyText(text: 'Qty',align: TextAlign.start,color: primaryColor,)),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    color: bodyLightBlack,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 20,
                      itemBuilder: (context,state){
                        return const SizedBox(
                          height: 30,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:<Widget> [
                              Expanded(flex: 3, child: BodyText(text: 'Car',align: TextAlign.start,)),
                             // Expanded(flex: 2, child: BodyText(text: 'Category',align: TextAlign.start,)),
                              Expanded(flex: 3, child: BodyText(text: '500000',align: TextAlign.start,)),
                              Expanded(flex: 1, child: BodyText(text: '1',align: TextAlign.center,)),
                            ],
                          ),
                        );
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}