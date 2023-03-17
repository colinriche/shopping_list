import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'shop_menu_model.dart';
export 'shop_menu_model.dart';

class ShopMenuWidget extends StatefulWidget {
  const ShopMenuWidget({Key? key}) : super(key: key);

  @override
  _ShopMenuWidgetState createState() => _ShopMenuWidgetState();
}

class _ShopMenuWidgetState extends State<ShopMenuWidget> {
  late ShopMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShopMenuModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
          child: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.ac_unit,
              color: FlutterFlowTheme.of(context).primaryBtnText,
              size: 30.0,
            ),
            onPressed: () async {
              FFAppState().update(() {
                FFAppState().shop = 'iceland';
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
          child: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.account_balance_sharp,
              color: FlutterFlowTheme.of(context).white,
              size: 30.0,
            ),
            onPressed: () async {
              FFAppState().update(() {
                FFAppState().shop = 'reg';
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
          child: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.shopping_cart_sharp,
              color: FlutterFlowTheme.of(context).white,
              size: 30.0,
            ),
            onPressed: () async {
              FFAppState().update(() {
                FFAppState().shop = 'aldi';
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
          child: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.done_outlined,
              color: FlutterFlowTheme.of(context).white,
              size: 30.0,
            ),
            onPressed: () async {
              if (FFAppState().pageToggle) {
                FFAppState().update(() {
                  FFAppState().pageToggle = false;
                });

                context.pushNamed('Select');
              } else {
                FFAppState().update(() {
                  FFAppState().pageToggle = true;
                });

                context.pushNamed('Shops');
              }
            },
          ),
        ),
      ],
    );
  }
}
