/* import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:intern/ui/views/user/main/vendor_list_view.dart';
import 'package:intern/ui/widgets/stateless/app_bar.dart';
import 'package:stacked/stacked.dart';
import '../../../../core/models/vendor/vendor.dart';
import '../../../widgets/stateful/drawer/customer_drawer_menu.dart';
import 'viewmodel.dart';

@RoutePage()
class VendorView extends StatefulWidget {
  final Vendor vendor;
  VendorView({required this.vendor});
  @override
  _VendorViewState createState() => _VendorViewState();
}

class _VendorViewState extends State<VendorView> {
  // LocationData? currentLocation;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VendorViewModel>.reactive(
      onViewModelReady: (model) async {
        await model.init(context, widget.vendor);
      },
      viewModelBuilder: () => VendorViewModel(),
      builder: (context, model, child) => model.isBusy
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              drawer: CustomerDrawerMenu(),
              appBar: MyAppBar(
                toolbarExtraHeight: 0,
              ),
              body: model.isBusy
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Card(
                              child: Center(
                                  child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(model.vendor?.name ?? 'null'),
                          ))),
                        ],
                      ),
                    )),
            ),
    );
  }
}
 */

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:intern/ui/views/user/vendor/table_list_view.dart';
import 'package:intern/ui/widgets/stateless/app_bar.dart';
// Import the TableListView
import 'package:stacked/stacked.dart';
import '../../../../core/models/vendor/vendor.dart';
import '../../../widgets/stateful/drawer/customer_drawer_menu.dart';
import 'viewmodel.dart';

@RoutePage()
class VendorView extends StatefulWidget {
  final Vendor vendor;
  VendorView({required this.vendor});
  @override
  _VendorViewState createState() => _VendorViewState();
}

class _VendorViewState extends State<VendorView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VendorViewModel>.reactive(
      onViewModelReady: (model) async {
        await model.init(context, widget.vendor);
      },
      viewModelBuilder: () => VendorViewModel(),
      builder: (context, model, child) => model.isBusy
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              drawer: CustomerDrawerMenu(),
              appBar: MyAppBar(
                toolbarExtraHeight: 0,
              ),
              body: model.isBusy
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Card(
                              child: Center(
                                  child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(model.vendor?.name ?? 'null'),
                          ))),
                          // Here we include the TableListView and pass the necessary parameters
                          Expanded(
                            child: TableListView(
                              parameters: {
                                'vendor_id': model.vendor?.id ??
                                    '', // Pass the vendor's ID to fetch tables
                              },
                            ),
                          ),
                        ],
                      ),
                    )),
            ),
    );
  }
}
