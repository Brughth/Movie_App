import 'package:flutter/material.dart';

class AppFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(T? data) onSuccess;
  final Widget Function(dynamic e)? onError;
  final WidgetBuilder? onLoading;
  const AppFutureBuilder({
    Key? key,
    required this.future,
    required this.onSuccess,
    this.onError,
    this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
            if (onLoading != null) {
              return onLoading!.call(context);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

          case ConnectionState.done:
            if (snapshot.hasError) {
              if (onError != null) {
                return onError!.call(context);
              } else {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
            }

            if (snapshot.hasData) {
              return onSuccess(snapshot.data);
            }
            break;

          case ConnectionState.none:
            return const Center(
              child: Text("Assurez-vous que votre future n'est pas nul"),
            );
          default:
            return Container();
        }
        return Container();
      },
    );
  }
}
