import 'package:flutter/material.dart';
/// A custom widget to display a dropdown menu of options.
///
/// This widget provides a dropdown menu that shows a list of elements of
/// type `T`. The elements can be selected by the user, and the selected
/// value can be picked up using the `onChanged` callback.
///
/// **Warning:** Avoid passing a large number of items in the `items` list,
/// as it may lead to performance issues due to frequent widget rebuilding.
class DropdownInputWidget<T> extends StatefulWidget {
  /// The list of elements to be displayed in the dropdown menu.
  final List<T> items;

  /// The value of the selected item in the dropdown menu.
  final T? value;

  /// A function that takes an element of type `T` and returns a text that
  /// will be displayed in the dropdown menu.
  final String Function(T)? displayText;

  /// The text displayed as a hint when no item is selected in the dropdown menu.
  final String hintText;

  /// The text type of the text displayed in the dropdown menu.
  final TextStyle textType;

  /// A callback called when an item is selected in the dropdown menu. The
  /// selected item is passed as an argument to the callback.
  final void Function(T?)? onChanged;
 
  const DropdownInputWidget({
    super.key,
    this.value,
    this.hintText = 'Selecciona una opción',
    this.textType = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    this.onChanged,
    required this.items,
    this.displayText,
  });

  @override
  State<DropdownInputWidget<T>> createState() => _DropdownInputWidgetState<T>();
}

class _DropdownInputWidgetState<T> extends State<DropdownInputWidget<T>> {
  T? selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: widget.value ?? selectedItem,
      hint: Text(
        widget.hintText,
        style: widget.textType,
      ),
      icon: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 20,
      ),
      onChanged: (value) {
        setState(() => selectedItem = value);
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      isExpanded: true,
      menuMaxHeight: 400,
      items: widget.items.map((value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(
            widget.displayText != null
                ? widget.displayText!(value)
                : value.toString(),
            style: widget.textType,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        );
      }).toList(),
    );
  }
}
