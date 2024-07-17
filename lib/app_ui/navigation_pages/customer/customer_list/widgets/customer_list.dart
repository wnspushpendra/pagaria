import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_list/widgets/customer_list_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_state.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class CustomerList extends StatefulWidget {
  final  bool? fromHome;
  const CustomerList({this.fromHome = false,super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  TextEditingController searchController = TextEditingController();
  List<User> customerList = [];
  List<User> filteredList = [];
/*  List<Customer> customerList = [];
  List<Customer> filteredList = [];*/
  bool loading = true;
  String? errorMessage;

  @override
  void initState() {
    context.read<HomeBloc>().add(HomeCustomerFetchEvent());
    super.initState();
  }

  void filterList(String query) {
    setState(() {
      filteredList = customerList.where((contact) {
        return contact.fullName!.toLowerCase().contains(query.toLowerCase()) ||
            contact.contactNo!.contains(query) ||
            contact.email!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, homeState) {
        if(homeState is HomeLoading){
          setState(() => loading = true);
        }
        if(homeState is HomeSuccess){
          loading = false;
          if(homeState.distributorList != null){
            setState(() {
              customerList = homeState.distributorList!;
              filteredList = customerList;
            });
          }
        }
        if(homeState is HomeError){
          if(homeState.error == 'unauthorization'){
            backToLogin(context);
          }
          errorMessage = homeState.error;
          setState(() => loading = false);
      //    snackBar(context,homeState.error );
        }
      },

    builder: (context, homeState) {
        return errorMessage != null ? Container(
          alignment:  widget.fromHome == true ? Alignment.center : Alignment.center,
          child: BodyText(text: errorMessage.toString(),color: primaryColor,),
        ) : loading ?
        const Center(
          child: CustomProgressBar(),
        ) :
        ListView(
          shrinkWrap: true,
          physics: widget.fromHome== true ? const NeverScrollableScrollPhysics() : null,
          children: [
            widget.fromHome== true ? Container() :
            CustomTextField(hint: 'Search Customer', label: 'Search customer', controller: searchController, onTextChange: (value) => filterList(searchController.text)),
            ListView.builder(
                physics: /*widget.fromHome== true ?*/ const NeverScrollableScrollPhysics() /*: null*/,
                shrinkWrap: true,
                itemCount: widget.fromHome== true && filteredList.length>5 ? 5  :  filteredList.length,
                itemBuilder: (context, index) {User customer = filteredList[index];

                  return CustomerListItem(
                    customerDetails : filteredList[index],
                    name: customer.fullName.toString(),
                    contactNumber: customer.contactNo.toString(),
                    emailAddress: customer.email.toString(),
                    add: "${customer.address},${customer.city},${customer
                        .state},${customer.zipCode}",);
                }),
          ],
        );
      },
    );
  }
}
