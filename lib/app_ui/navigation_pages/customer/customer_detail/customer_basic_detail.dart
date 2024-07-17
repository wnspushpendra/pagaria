import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_detail/row_detail_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/ledger/bloc/ledger_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/ledger/bloc/ledger_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/ledger/bloc/ledger_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/bloc/profile_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/bloc/profile_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile_image_widget.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';


class CustomerBasicDetails extends StatefulWidget {
 // final Customer customer;
  final User customer;

  const CustomerBasicDetails({required this.customer, super.key});

  @override
  State<CustomerBasicDetails> createState() => _CustomerBasicDetailsState();
}

class _CustomerBasicDetailsState extends State<CustomerBasicDetails> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              padding: EdgeInsets.all(16.h),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      alignment: Alignment.center,
                      child: ProfileImageWidget(
                          showIcon: false,
                          networkUrl: widget.customer.profileImageUrl
                              .toString(), onFileChange: (file) {})),
                  const Space(height: 10,),
                  RowDetailWidget(titleLeft: firmName,
                    valueLeft: widget.customer.firmName??'NA',
                    titleRight: customerName,
                    valueRight: widget.customer.fullName??'NA',),
                  RowDetailWidget(titleLeft: mobileNumber,
                    valueLeft: widget.customer.contactNo??'NA',
                    titleRight: panCardNumber,
                    valueRight: widget.customer.panCardNo??'NA',),
                  RowDetailWidget(titleLeft: gstNumber,
                    valueLeft: widget.customer.gstNo ??'NA',
                    titleRight: aadharNumber,
                    valueRight: widget.customer.aadharNo??'NA',),
                  RowDetailWidget(titleLeft: email,
                    valueLeft: widget.customer.email.toString(),
                    titleRight: address,
                    valueRight: '',
                    showSingleDetail: true,),
             const BodyText(text: '$address :', fontSize: 16),
                  widget.customer.address != null ?
                  BodyText(
                    text: "${widget.customer.address},${widget.customer
                        .city},${widget.customer.state},${widget.customer
                        .zipCode}",
                    align: TextAlign.start,
                    color: primaryColor,
                  ) : const BodyText(
                    text: "NA",
                    align: TextAlign.start,
                    color: primaryColor,
                  )

                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: BlocListener<LedgerBloc, LedgerState>(
                listener: (context, state) {
                  if (state is LedgerDownloadSuccess) {
                    downLoadInvoice(context,state.url!,"my-ledger-${widget.customer.id}.pdf");
                 //   snackBarButton(context, message, state.file.path);
                  }
                  if (state is LedgerError) {
                    snackBar(context, state.error.toString());
                    setState(() {});

                  }
                },
                child: CustomButton(buttonText: 'Ledger Book',
                  margin: 0,
                  radius: 0,
                  image: downloadLedger,
                  onClick: () => context.read<LedgerBloc>().add(LedgerDownloadEvent(distributorId: widget.customer.id.toString()))
                  ,),
              ))
        ],
      ),
    );
  }
}
