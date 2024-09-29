import '../consts/imports.dart';

void snackBarMessage(String msg, BuildContext context) {
  final snackBar = SnackBar(
    content: Text('This is a Snackbar message'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Undo action')),
        );
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}