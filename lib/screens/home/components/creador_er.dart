import 'package:flutter/material.dart';
import 'package:escape_life/db/models/escaperoom.dart';

class EscapeRoomDialog extends StatefulWidget {
  final EscapeRoom escaperoom;
  final Function(String nombre, String ciudad) onClickedDone;

  const EscapeRoomDialog({
    Key key,
    this.escaperoom,
    @required this.onClickedDone,
  }) : super(key: key);

  @override
  _EscapeRoomDialogState createState() => _EscapeRoomDialogState();
}

class _EscapeRoomDialogState extends State<EscapeRoomDialog> {
  final formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final ciudadController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.escaperoom != null) {
      final escaperoom = widget.escaperoom;

      nombreController.text = escaperoom.nombre;
      ciudadController.text = escaperoom.ciudad;
    }
  }

  @override
  void dispose() {
    nombreController.dispose();
    ciudadController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.escaperoom != null;
    final title = isEditing ? 'Edit EscapeRoom' : 'Add EscapeRoom';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 8),
              buildAmount(),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildName() => TextFormField(
        controller: nombreController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Name',
        ),
        validator: (nombre) =>
            nombre != null && nombre.isEmpty ? 'Enter a nombre' : null,
      );

  Widget buildAmount() => TextFormField(
        controller: ciudadController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter ciudad',
        ),
        validator: (ciudad) =>
            ciudad != null && ciudad.isEmpty ? 'Enter a ciudad' : null,
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState.validate();

        if (isValid) {
          final nombre = nombreController.text;
          final ciudad = ciudadController.text;

          widget.onClickedDone(nombre, ciudad);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
