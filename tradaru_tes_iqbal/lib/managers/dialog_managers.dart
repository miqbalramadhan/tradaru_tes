import 'package:flutter/material.dart';
import 'package:tradaru_tes_iqbal/models/dialog_models.dart';
import 'package:tradaru_tes_iqbal/services/dialog_service.dart';

import '../locator.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest request) {
    var isConfirmationDialog = request.cancelTitle != null;
    Widget btnOK = null;
    if (isConfirmationDialog) {
      Widget btnOK = FlatButton(
        child: Text(request.cancelTitle),
        onPressed: () {
          _dialogService
              .dialogComplete(DialogResponse(confirmed: false));
        },
      );
    }
    Widget btnNO = FlatButton(
      child: Text(request.buttonTitle),
      onPressed: () {
        _dialogService
            .dialogComplete(DialogResponse(confirmed: true));
      },
    );
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text(request.title),
              content: Text(request.description),
              actions: <Widget>[
                btnOK,
                btnNO,
              ],
            ));
  }
}