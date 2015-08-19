# Popover

[![CI Status](http://img.shields.io/travis/corin8823/Popover.svg?style=flat)](https://travis-ci.org/corin8823/Popover)
[![Version](https://img.shields.io/cocoapods/v/Popover.svg?style=flat)](http://cocoapods.org/pods/Popover)
[![License](https://img.shields.io/cocoapods/l/Popover.svg?style=flat)](http://cocoapods.org/pods/Popover)
[![Platform](https://img.shields.io/cocoapods/p/Popover.svg?style=flat)](http://cocoapods.org/pods/Popover)

## Description

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Simple

```swift
let startPoint = CGPoint(x: self.view.frame.width - 60, y: 55)
let aView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 180))
var popover = Popover()
popover.show(aView, point: startPoint)
```

## Requirements
- iOS 7.0+

## Installation

### CocoaPods
Popover is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
pod "Popover"
```

### Carthage (iOS 8+)
You can use [Carthage](https://github.com/Carthage/Carthage) to install `Popover` by adding it to your `Cartfile`:
```
github "corin8823/Popover"
```

### Manual Installation
The class file required for Popover is located in the Classes folder in the root of this repository as listed below:
```
Popover.swift
```

## Customization

- ``case ArrowSize(CGSize)``
- ``case AnimationIn(NSTimeInterval)``
- ``case AnimationOut(NSTimeInterval)``
- ``case CornerRadius(CGFloat)``
- ``case SideEdge(CGFloat)``
- ``case BlackOverlayColor(UIColor)``
- ``case Type(Popover.PopoverType)``

## Author

corin8823, yusuke.t88@gmail.com

## License

Popover is available under the MIT license. See the LICENSE file for more info.
