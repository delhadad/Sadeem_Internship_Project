import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import '../../../../core/constant/api_routes.dart';

import '../../../../core/enums/http_request_type.dart';

import '../../../../core/models/user/user.dart';
import '../../../../core/models/vendor/vendor.dart';
import '../../../../core/repositories/magical_repository.dart';
import '../../../../core/services/key_storage/key_storage_service.dart';

import '../../../../locator.dart';

class VendorViewModel extends BaseViewModel {
  BuildContext? context;
  Vendor? vendor;
  Future<void> init(BuildContext context, Vendor vendor) async {
    this.context = context;
    setBusy(true);
    this.vendor = vendor;
    // await getVendor();
    setBusy(false);
  }

  getVendor() async {
    this.vendor = await locator<MagicalRepository>().handelRequest<Vendor>(
        model: Vendor(),
        parameters: {'': ''},
        methodType: HTTPMethodType.GET,
        route: ApiRoutes.vendor(vendor!.id!));
  }
}
