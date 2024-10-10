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

class VendorListView extends StatefulWidget {
  Map<String, dynamic> parameters;
  VendorListView({required this.parameters});
  @override
  _VendorListViewState createState() => _VendorListViewState();
}

class _VendorListViewState extends State<VendorListView> {
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

    var vendor_items = (await locator<MagicalRepository>()
            .handelRequest<Vendor>(
                model: Vendor(),
                specific_key: EndPointParameter.DATA,
                parameters: parameters,
                methodType: HTTPMethodType.GET,
                route: ApiRoutes.vendors))
        .cast<Vendor>();

    _pagingController.appendLastPage(vendor_items);
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

import 'dart:ui';
import 'package:intern/core/constant/constants.dart';

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

class VendorListView extends StatefulWidget {
  Map<String, dynamic> parameters;
  VendorListView({required this.parameters});
  @override
  _VendorListViewState createState() => _VendorListViewState();
}

class _VendorListViewState extends State<VendorListView> {
  final _pagingController = PagingController<int, Vendor>(firstPageKey: 1);
  String _searchQuery = ''; // Holds the current search query

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

    // Add search query to parameters if it exists
    if (_searchQuery.isNotEmpty) {
      parameters['search'] = _searchQuery;
    }

    try {
      var vendor_items = (await locator<MagicalRepository>()
              .handelRequest<Vendor>(
                  model: Vendor(),
                  specific_key: EndPointParameter.DATA,
                  parameters: parameters,
                  methodType: HTTPMethodType.GET,
                  route: ApiRoutes.vendors))
          .cast<Vendor>();

      // Check if the result is empty
      if (vendor_items.isEmpty) {
        _pagingController
            .appendLastPage([]); // Notify that no more pages are available
      } else {
        // Check if it's the last page
        if (vendor_items.length < Constants.itemsPerPage) {
          _pagingController.appendLastPage(vendor_items);
        } else {
          _pagingController.appendPage(vendor_items, pageKey + 1);
        }
      }
    } catch (e) {
      print('Error fetching vendors: $e');
      _pagingController.error = e;
    }
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
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                      _pagingController
                          .refresh(); // Refresh the list when search changes
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Search Vendor',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PagedListView<int, Vendor>.separated(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Vendor>(
                    itemBuilder: (context, item, index) => Container(
                      child: VendorCard(
                        vendor: item,
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),
            ],
          );
        },
      );
}
