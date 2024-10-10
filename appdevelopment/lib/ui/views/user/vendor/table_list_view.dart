/* import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intern/core/constant/constants.dart';
import 'package:intern/core/constant/end_point_parameters.dart';
import 'package:intern/core/models/vendor/vendor.dart';
import 'package:intern/ui/views/user/main/main_view_model.dart';
import 'package:intern/ui/widgets/stateful/vendor/view.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/constant/api_routes.dart';
import '../../../../core/enums/http_request_type.dart';
import '../../../../core/repositories/magical_repository.dart';
import '../../../../locator.dart';

class TableListView extends StatefulWidget {
  Map<String, dynamic> parameters;
  TableListView({required this.parameters});
  @override
  _TableListViewState createState() => _TableListViewState();
}

class _TableListViewState extends State<TableListView> {
  final _pagingController = PagingController<int, Vendor>(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    var parameters = widget.parameters;
    parameters[EndPointParameter.page] = pageKey.toString();
    parameters[EndPointParameter.sorts] = Constants.DEFAULT_SORTS;

    /*    var vendor_items = (await locator<MagicalRepository>()
            .handelRequest<Vendor>(
                model: Vendor(),
                specific_key: EndPointParameter.DATA,
                parameters: parameters,
                methodType: HTTPMethodType.GET,
                route: ApiRoutes.vendors))
        .cast<Vendor>(); */
    var tableItems = (await locator<MagicalRepository>()
            .handelRequest<MyTable.Table>(
                model: MyTable.Table(),
                specific_key: EndPointParameter.DATA,
                parameters: parameters,
                methodType: HTTPMethodType.GET,
                route: ApiRoutes.tables)) // Updated to tables route
        .cast<MyTable.Table>();

    _pagingController.appendLastPage(tableItems);
  }

  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<MainViewModel>.reactive(
        viewModelBuilder: () => MainViewModel(),
        onViewModelReady: (viewModel) async {
          await viewModel.init(context);
        },
        builder:
            (BuildContext context, MainViewModel viewModel, Widget? child) {
          return PagedListView<int, Vendor>.separated(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Vendor>(
              itemBuilder: (context, item, index) => Container(
                child: VendorCard(
                  vendor: item,
                ),
              ),
            ),
            separatorBuilder: (context, index) => const Divider(),
          );
        },
      );
}
 */

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intern/core/constant/constants.dart';
import 'package:intern/core/constant/end_point_parameters.dart';
import 'package:intern/core/models/table/table.dart'
    as CustomTable; // Add alias for custom Table model
import 'package:intern/ui/views/user/main/main_view_model.dart';
import 'package:stacked/stacked.dart';
import '../../../../core/constant/api_routes.dart';
import '../../../../core/enums/http_request_type.dart';
import '../../../../core/repositories/magical_repository.dart';
import '../../../../locator.dart';

class TableListView extends StatefulWidget {
  final Map<String, dynamic> parameters; // Mark parameters as final
  TableListView({required this.parameters, Key? key})
      : super(key: key); // Add key to the constructor

  @override
  _TableListViewState createState() => _TableListViewState();
}

class _TableListViewState extends State<TableListView> {
  final _pagingController = PagingController<int, CustomTable.Table>(
      firstPageKey: 1); // Use CustomTable.Table

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    var parameters = widget.parameters;
    /* parameters[EndPointParameter.page] = pageKey.toString(); */
    parameters[EndPointParameter.page] = pageKey; // Keep it as int

    parameters[EndPointParameter.sorts] = Constants.DEFAULT_SORTS;
    print('Vendor ID: ${parameters['vendor_id']}');
    var tableItems =
        (await locator<MagicalRepository>().handelRequest<CustomTable.Table>(
      model: CustomTable.Table(), // Pass the CustomTable.Table model
      specific_key: EndPointParameter.DATA,
      parameters: parameters,
      methodType: HTTPMethodType.GET,
      route: ApiRoutes.vendorTables(parameters['vendor_id']),
    ))
            .cast<CustomTable.Table>();

    _pagingController.appendLastPage(tableItems);
  }

  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<MainViewModel>.reactive(
        viewModelBuilder: () => MainViewModel(),
        onViewModelReady: (viewModel) async {
          await viewModel.init(context);
        },
        builder:
            (BuildContext context, MainViewModel viewModel, Widget? child) {
          return PagedListView<int, CustomTable.Table>.separated(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<CustomTable.Table>(
              itemBuilder: (context, item, index) => ListTile(
                // Removed unnecessary Container
                title: Text(item.name ?? 'No Name'), // Add null-aware operator
                subtitle: Text(
                    'Available: ${item.is_available == true ? "Yes" : "No"}'), // Add null check
              ),
            ),
            separatorBuilder: (context, index) => const Divider(),
          );
        },
      );
}
