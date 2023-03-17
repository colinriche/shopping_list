import '/backend/supabase/supabase.dart';
import '/components/shop_menu_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'shops_model.dart';
export 'shops_model.dart';

class ShopsWidget extends StatefulWidget {
  const ShopsWidget({Key? key}) : super(key: key);

  @override
  _ShopsWidgetState createState() => _ShopsWidgetState();
}

class _ShopsWidgetState extends State<ShopsWidget> {
  late ShopsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShopsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<List<ShoppingRow>>(
      future: ShoppingTable().queryRows(
        queryFn: (q) => q
            .eq(
              'food_select',
              true,
            )
            .eq(
              'shop',
              FFAppState().shop,
            )
            .order('id', ascending: true),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(
                color: FlutterFlowTheme.of(context).primaryColor,
              ),
            ),
          );
        }
        List<ShoppingRow> shopsShoppingRowList = snapshot.data!;
        return Title(
            title: 'Shops',
            color: FlutterFlowTheme.of(context).primaryColor,
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              appBar: AppBar(
                backgroundColor: FlutterFlowTheme.of(context).primaryColor,
                automaticallyImplyLeading: false,
                title: wrapWithModel(
                  model: _model.shopMenuModel,
                  updateCallback: () => setState(() {}),
                  child: ShopMenuWidget(),
                ),
                actions: [],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(25.0),
                  child: Text(
                    FFAppState().shop,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.of(context).white,
                          fontSize: 22.0,
                        ),
                  ),
                ),
                centerTitle: false,
                elevation: 20.0,
              ),
              body: SafeArea(
                child: GestureDetector(
                  onTap: () =>
                      FocusScope.of(context).requestFocus(_unfocusNode),
                  child: Builder(
                    builder: (context) {
                      final klinekline = shopsShoppingRowList.toList();
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate(klinekline.length,
                              (klineklineIndex) {
                            final klineklineItem = klinekline[klineklineIndex];
                            return InkWell(
                              onTap: () async {
                                _model.shoplist = await ShoppingTable().update(
                                  data: {
                                    'food_select': false,
                                  },
                                  matchingRows: (rows) => rows.eq(
                                    'id',
                                    klineklineItem.id,
                                  ),
                                  returnRows: true,
                                );

                                setState(() {});
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 5.0, 0.0, 0.0),
                                    child: Image.network(
                                      klineklineItem.photoUrl!,
                                      width: 100.0,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 5.0, 5.0, 5.0),
                                    child: Text(
                                      klineklineItem.id.toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        klineklineItem.shoppingName,
                                        'Name Missing',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ));
      },
    );
  }
}
