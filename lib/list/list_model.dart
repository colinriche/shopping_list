import '/backend/supabase/supabase.dart';
import '/components/shop_menu_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ListModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Update Supabase Row] action in Row widget.
  List<ShoppingRow>? shoplist;
  // Model for ShopMenu component.
  late ShopMenuModel shopMenuModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    shopMenuModel = createModel(context, () => ShopMenuModel());
  }

  void dispose() {
    shopMenuModel.dispose();
  }

  /// Additional helper methods are added here.

}
