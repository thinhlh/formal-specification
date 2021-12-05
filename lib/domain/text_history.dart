/// This class is used to record the changes in text field
/// If text is changed, it will be insert to the first element of _undoStack
/// If user press undo, it will pop the _undoStack(remove first element) then return the top of undo stack, finally insert the current popped value to top of the _redoStack
/// Otherwise, if user presse redo, it will pop the _redoStack, then insert the popped value to top of the undo stack
class TextHistory {
  final List<String> _undoStack = [''];
  final List<String> _redoStack = [];

  void onTextChanged(String value) {
    if (value == '') return;
    _undoStack.insert(0, value);

    print('Undo Stack $_undoStack');
  }

  bool get isUndoAble {
    return _undoStack.length > 1;
  }

  bool get isRedoAble {
    print('Redo $_redoStack');
    return _redoStack.length > 0;
  }

  String onUndo() {
    if (isUndoAble) {
      String removedValue = _undoStack.removeAt(0);
      _redoStack.insert(0, removedValue);
      return _undoStack.first;
    } else {
      return '';
    }
  }

  String onRedo() {
    if (isRedoAble) {
      String redoValue = _redoStack.removeAt(0);
      _undoStack.insert(0, redoValue);
      return _redoStack.first;
    }
    return '';
  }
}
