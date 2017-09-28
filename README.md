<p align="center">
    <a href="https://cocoapods.org/pods/Files">
        <img src="https://img.shields.io/cocoapods/v/CustomXibView.svg" alt="CocoaPods" />
    </a>
    <a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/carthage-compatible-4BC51D.svg?style=flat" alt="Carthage" />
    </a>
</p>

## Example

There are several ways to use CustomXibView

### Setting Xib Name in Interface Builder

If you view is not complicated, you can just:
- Place UIView in you Interface Builder
- Set its class to CustomXibView in Identity Inspector
- Set the name of your custom xib view in Attributes Inspector

![Alt Text](https://github.com/Peterek/custom-xib-view/raw/master/example1.gif)

### Deriving from CustomXibView

To implement more complex behaviour:
Set its class to your class derived from CustomXibView in Identity Inspector
If class name is the same as xib name, there is no need to provide the xib name.
Otherwise you can set the xib name in Attributes Inspector or in your class by overriding xibName property.

``` swift
import UIKit

class PartyParrot: CustomXibView {
}

class BTCView: CustomXibView {

    override var xibName: String {
        return "BTC"
    }
    
}
```

![Alt Text](https://github.com/Peterek/custom-xib-view/raw/master/example2.gif)

### Creating CustomXibView programmatically

You can create CustomXibView by calling its init(frame:).
Then it can be added as subview in code.


## Usage

### Manual

- Drag the file `CustomXibView.swift` into your application's Xcode project.

### CocoaPods

- pod 'CustomXibView'