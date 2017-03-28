# Popover

[![CI Status](http://img.shields.io/travis/corin8823/Popover.svg?style=flat)](https://travis-ci.org/corin8823/Popover)
[![Version](https://img.shields.io/cocoapods/v/Popover.svg?style=flat)](http://cocoapods.org/pods/Popover)
[![License](https://img.shields.io/cocoapods/l/Popover.svg?style=flat)](http://cocoapods.org/pods/Popover)
[![Platform](https://img.shields.io/cocoapods/p/Popover.svg?style=flat)](http://cocoapods.org/pods/Popover)

## Description and [appetize.io`s DEMO](https://appetize.io/app/q4n81yf0aakkx20x2cejh107b4)

![](https://github.com/corin8823/Popover/blob/master/ScreenShots/Screenshot.gif)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Simple

```swift
let startPoint = CGPoint(x: self.view.frame.width - 60, y: 55)
let aView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 180))
let popover = Popover()
popover.show(aView, point: startPoint)
```

### Custom

```swift
@IBOutlet weak var leftBottomButton: UIButton!

let width = self.view.frame.width / 4
let aView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))
let options = [
  .type(.up),
  .cornerRadius(width / 2),
  .animationIn(0.3),
  .blackOverlayColor(UIColor.red),
  .arrowSize(CGSize.zero)
  ] as [PopoverOption]
let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
popover.show(aView, fromView: self.leftBottomButton)
```

## Requirements
- iOS 8.0+
- Swift 3.1

If you use Swift 2.2 or 2.3, try Popover 0.9.1.

## Installation

### CocoaPods (iOS 8+)
Popover is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
use_frameworks!
pod "Popover"
```

### Carthage (iOS 8+)
You can use [Carthage](https://github.com/Carthage/Carthage) to install `Popover` by adding it to your `Cartfile`:
```ruby
github "corin8823/Popover"
```

### Manual Installation
The class file required for Popover is located in the Classes folder in the root of this repository as listed below:
```
Popover.swift
```

## Customization

### Enum
- ``case arrowSize(CGSize)``
- ``case animationIn(NSTimeInterval)``
- ``case animationOut(NSTimeInterval)``
- ``case cornerRadius(CGFloat)``
- ``case sideEdge(CGFloat)``
- ``case blackOverlayColor(UIColor)``
- ``case overlayBlur(UIBlurEffectStyle)``
- ``case type(Popover.PopoverType)``
- ``case color(UIColor)``
- ``case dismissOnBlackOverlayTap(Bool)``
- ``case showBlackOverlay(Bool)``

### Property
- ``arrowSize: CGSize = CGSize(width: 16.0, height: 10.0)``
- ``animationIn: NSTimeInterval = 0.6``
- ``animationOut: NSTimeInterval = 0.3``
- ``cornerRadius: CGFloat = 6.0``
- ``sideEdge: CGFloat = 20.0``
- ``popoverType: PopoverType = .down``
- ``blackOverlayColor: UIColor = UIColor(white: 0.0, alpha: 0.2)``
- ``overlayBlur: UIBlurEffect?``
- ``popoverColor: UIColor = UIColor.white``

## Acknowledgments
Inspired by [DXPopover](https://github.com/xiekw2010/DXPopover) in [xiekw2010](https://github.com/xiekw2010)

## License

Popover is available under the MIT license. See the LICENSE file for more info.
