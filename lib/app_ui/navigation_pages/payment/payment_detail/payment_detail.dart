import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_detail/row_detail_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/bloc/profile_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/bloc/profile_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile_image_widget.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/modal/payment/payment_list_modal.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';


class PaymentDetailScreen extends StatefulWidget {
  final PaymentDetailData paymentDetail;
  const PaymentDetailScreen( {required this.paymentDetail,super.key});

  @override
  State<PaymentDetailScreen> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetailScreen> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appBarWidget(context, 'Payment Detail', ()  =>  backUserHome(context) ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding:  EdgeInsets.all(16.h),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
           /*       Container(
                    width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: ProfileImageWidget(
                        showIcon: false, networkUrl: widget.paymentDetail.profileImageUrl.toString(), onFileChange: (file){})),
                */  const Space(height: 10,),
                  // RowDetailWidget(titleLeft: firmName, valueLeft: widget.customer.firmName.toString(), titleRight: customerName, valueRight: widget.customer.fullName.toString(),),
                   RowDetailWidget(titleLeft: customerName, valueLeft: widget.paymentDetail.userData!.fullName??'' , titleRight: 'Reference Number', valueRight: widget.paymentDetail.paymentReferenceId??'NA',),
                  RowDetailWidget(titleLeft: email, valueLeft:  widget.paymentDetail.userData!.email??''.toString(), titleRight: address, valueRight: '',showSingleDetail: true,),
                  RowDetailWidget(titleLeft: 'Payment Date', valueLeft: widget.paymentDetail.date ??'',  titleRight: 'Paid Amount', valueRight: widget.paymentDetail.amount.toString()??'',),
                  RowDetailWidget(titleLeft: 'Payment Type', valueLeft: widget.paymentDetail.paymentType??'',  titleRight: panCardNumber, valueRight: widget.paymentDetail.amount.toString()??'',),
                 if(widget.paymentDetail.imageUrl != null && widget.paymentDetail.imageUrl!.isNotEmpty)
                  CachedNetworkImage(imageUrl: widget.paymentDetail.imageUrl!)
                 // const BodyText(text:'$address :',fontSize: 16),
            /*      BodyText(
                    text: "${widget.customer.address},${widget.customer.city},${widget.customer.state},${widget.customer.zipCode}",
                    align: TextAlign.start,
                    color: primaryColor,
                  ),*/

                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
              right: 0,
              left: 0,
              child: CustomButton(buttonText: 'Ledger Book',
                margin: 0,radius: 0,
                image: downloadLedger,
                onClick: (){},))
        ],
      ),
    );
  }
}
