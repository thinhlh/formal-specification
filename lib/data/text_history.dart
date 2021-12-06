import 'package:flutter/material.dart';

/// This class is used to record the changes in text field
/// If text is changed, it will be insert to the first element of _undoStack
/// If user press undo, it will pop the _undoStack(remove first element) then return the top of undo stack, finally insert the current popped value to top of the _redoStack
/// Otherwise, if user presse redo, it will pop the _redoStack, then insert the popped value to top of the undo stack
class TextHistory {
  static const int maxSize = 30;

  final List<String> _undoStack = [''];
  final List<String> _redoStack = [];
  TextSelection _inputSelect = TextSelection.collapsed(offset: 0);

  void onTextChanged(String value, TextSelection textSelection) {
    // This will prevent add duplicate value
    if (value == '' ||
        (textSelection.baseOffset == _inputSelect.baseOffset &&
            textSelection.extentOffset == _inputSelect.extentOffset) ||
        textSelection == _inputSelect ||
        value == _undoStack.first) return;

    _inputSelect = textSelection;
    _undoStack.insert(0, value);

    _removeExtendsUndoAndRedo();
  }

  bool get isUndoAble {
    return _undoStack.length > 1;
  }

  bool get isRedoAble {
    return _redoStack.length > 0;
  }

  String onUndo() {
    if (isUndoAble) {
      print('Undo stack: ' + _undoStack.toString());
      String removedValue = _undoStack.removeAt(0);
      _redoStack.insert(0, removedValue);
      _removeExtendsUndoAndRedo();
      return _undoStack.first;
    } else {
      return '';
    }
  }

  String onRedo() {
    if (isRedoAble) {
      String redoValue = _redoStack.removeAt(0);
      _undoStack.insert(0, redoValue);
      _removeExtendsUndoAndRedo();
      return redoValue;
    }
    return '';
  }

  void clear() {
    _undoStack.clear();
    _undoStack.add('');
    _redoStack.clear();
    _inputSelect = TextSelection.collapsed(offset: -1);
  }

  void _removeExtendsUndoAndRedo() {
    if (_undoStack.length > maxSize) {
      _undoStack.removeLast();
    }
    if (_redoStack.length > maxSize) {
      _redoStack.removeLast();
    }
  }

  TextSelection get inputSelection => _inputSelect;
}
