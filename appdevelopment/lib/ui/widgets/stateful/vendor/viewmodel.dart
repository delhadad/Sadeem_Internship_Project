import 'package:flutter/material.dart';
import 'package:intern/core/models/vendor/vendor.dart';
import 'package:stacked/stacked.dart';

class VendorCardViewModel extends BaseViewModel {
  BuildContext? context;
  Vendor? vendor;
  Future<void> init(BuildContext context, vendor) async {
    this.context = context;
    this.vendor = vendor;
    setBusy(true);

    setBusy(false);
  }
}
