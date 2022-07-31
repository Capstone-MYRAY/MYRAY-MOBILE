import 'package:flutter/material.dart';
import 'package:myray_mobile/app/data/models/filter_object.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class InlineFilter extends StatefulWidget {
  final List<FilterObject> items;
  final dynamic selectedItem;
  final void Function(dynamic value) onChanged;

  const InlineFilter({
    Key? key,
    required this.items,
    required this.onChanged,
    this.selectedItem,
  }) : super(key: key);

  @override
  State<InlineFilter> createState() => InlineFilterState();
}

class InlineFilterState extends State<InlineFilter> {
  dynamic _selectedItem;
  late String max;

  clearFilter() {
    setState(() {
      _selectedItem = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: Theme.of(context).primaryColor,
        width: 1.0,
        style: BorderStyle.solid,
        borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
      ),
      children: [
        TableRow(
          children: widget.items
              .map(
                (item) => _buildItem(
                    item.name, item.value, item.value == _selectedItem),
              )
              .toList(),
        )
      ],
    );
  }

  Widget _buildItem(String title, dynamic value, bool isSelected) {
    return TableCell(
      verticalAlignment: max == title
          ? TableCellVerticalAlignment.middle
          : TableCellVerticalAlignment.fill,
      child: Material(
        color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
        child: InkWell(
          onTap: () {
            widget.onChanged(value);
            setState(() {
              _selectedItem = value;
            });
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: isSelected
                  ? Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      )
                  : Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                      ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
    max = widget.items
        .reduce((a, b) => a.name.length > b.name.length ? a : b)
        .name;
  }
}
