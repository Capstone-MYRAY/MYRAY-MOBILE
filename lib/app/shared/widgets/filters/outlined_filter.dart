import 'package:flutter/material.dart';
import 'package:myray_mobile/app/data/models/filter_object.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class OutlinedFilter extends StatefulWidget {
  final List<FilterObject> items;
  final dynamic selectedItem;
  final void Function(dynamic value) onChanged;

  const OutlinedFilter({
    Key? key,
    required this.items,
    required this.onChanged,
    this.selectedItem,
  }) : super(key: key);

  @override
  State<OutlinedFilter> createState() => OutlinedFilterState();
}

class OutlinedFilterState extends State<OutlinedFilter> {
  late List<FilterObject> _items;
  dynamic _selectedItem;

  clearFilter() {
    setState(() {
      _selectedItem = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.8 / 2,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 24.0,
        childAspectRatio: 11 / 4,
      ),
      itemCount: _items.length,
      itemBuilder: (ctx, index) => _buildItem(
        _items[index].name,
        _items[index].value,
        _items[index].value == _selectedItem,
      ),
    );
  }

  Widget _buildItem(String title, dynamic value, bool isSelected) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
        side: BorderSide(
          color: isSelected ? Theme.of(context).primaryColor : AppColors.black,
          width: isSelected ? 2.0 : 1.0,
          style: BorderStyle.solid,
        ),
      ),
      child: InkWell(
        onTap: () {
          widget.onChanged(value);
          setState(() {
            _selectedItem = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 8.0,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            softWrap: true,
            style: isSelected
                ? Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    )
                : Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                    ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _items = widget.items;
    _selectedItem = widget.selectedItem;
  }
}
