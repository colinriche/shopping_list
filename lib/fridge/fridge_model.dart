import '/backend/supabase/supabase.dart';
import '/components/food_category_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FridgeModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Model for FoodCategory component.
  late FoodCategoryModel foodCategoryModel;
  // Stores action output result for [Backend Call - Update Supabase Row] action in Container widget.
  List<ShoppingRow>? shoplist;
  // Stores action output result for [Backend Call - Update Supabase Row] action in Row widget.
  List<ShoppingRow>? cshoplist;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    foodCategoryModel = createModel(context, () => FoodCategoryModel());
  }

  void dispose() {
    foodCategoryModel.dispose();
  }

  /// Additional helper methods are added here.

}
