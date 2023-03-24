import 'package:flutter/material.dart';

class MainDataSource<T> extends DataTableSource {
  late List<T> list;
  final DataRow Function(T c) buildRow;

  MainDataSource(this.list, {required this.buildRow});

  @override
  DataRow? getRow(int index) {
    T e = list[index];

    return buildRow(e);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => list.length;

  @override
  int get selectedRowCount => 0;
}
