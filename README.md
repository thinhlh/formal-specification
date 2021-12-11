# Formal Specification Project

A formal specification to transfer human-readable specification to Dart code based on Flutter SDK in MacOS platform.

---
## Prerequisites

1. MacOS platform
2. Xcode installed
3. Flutter SDK installed and run globally via the [documentation](https://docs.flutter.dev/get-started/install/macos)

## Installation
1. Clone the project
    ```
    git clone https://github.com/thinhlh/formal-specification.git 
    ```

2. Change the directory to the current project 

3. Running the below command
    ``` 
    flutter run 
    ```

4. On the devices, choose macOS

## Usage

1. Enter the specification text or open the .txt file to the left text field
2. Code generator
    ### Generating
    Requirement: The text field on the left cannot be empty
    Actions: Filling the **left text field** and click **generate** button

    ### Build Solution
    Requirement: File name must not be empty and contains extension
    Action: Filling the **left text field** and click **Build Solution** button

# Notice and Recent Error
Due to the built-in logical keyboard is in Beta state, sometimes users might counter the error below: 

```
A KeyUpEvent is dispatched, but the state shows that the physical key is not pressed. If this occurs in real application, please report this bug to Flutter. If this occurs in unit tests, please ensure that simulated events follow Flutter's event model as documented in `HardwareKeyboard`. This was the event: KeyUpEvent#8d33e(physicalKey: PhysicalKeyboardKey#700e0(usbHidUsage: "0x000700e0", debugName: "Control Left"), logicalKey: LogicalKeyboardKey#00100(keyId: "0x200000100", keyLabel: "Control Left", debugName: "Control Left"), character: null, timeStamp: 52:40:49.694077, synthesized)
'package:flutter/src/services/hardware_keyboard.dart':
package:flutter/…/services/hardware_keyboard.dart:1
Failed assertion: line 441 pos 16: '_pressedKeys.containsKey(event.physicalKey)'
```

**Step to resolve**
Run following command
1. Turn off the application
2. Clean project 
    ```
    flutter clean
    ```
3. Re-run project
    ```
    flutter run
    ```