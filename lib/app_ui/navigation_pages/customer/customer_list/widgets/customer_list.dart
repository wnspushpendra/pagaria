import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_list/widgets/customer_list_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_state.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';

class CustomerList extends StatefulWidget {
  final  bool? fromHome;
  const CustomerList({this.fromHome = false,super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  List<Customer> customerList = [];
  bool loading = true;

  @override
  void initState() {
    context.read<HomeBloc>().add(HomeCustomerFetchEvent());
    super.initState();
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
            setState(() => customerList = homeState.distributorList!);
          }
        }
      },

    builder: (context, homeState) {
        return loading ?
        const Center(
          child: CustomProgressBar(),
        ) :
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 500,
                mainAxisExtent: 210//MediaQuery.of(context).size.height/3.2
            ),
            physics: widget.fromHome== true ? const NeverScrollableScrollPhysics() : null,
            shrinkWrap: true,
            itemCount: widget.fromHome== true && customerList.length>5 ? 5  :  customerList.length,
            itemBuilder: (context, index) {Customer customer = customerList[index];

              return CustomerListItem(
                customerDetails : customerList[index],
                name: customer.fullName.toString(),
                contactNumber: customer.contactNo.toString(),
                emailAddress: customer.email.toString(),
                add: "${customer.address},${customer.city},${customer
                    .state},${customer.zipCode}",);
            });
      },
    );
  }
}
