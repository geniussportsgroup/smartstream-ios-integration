# GeniusSportWidgetLoader

[![CI Status](http://img.shields.io/travis/GeniusSport/GeniusSportWidgetLoader.svg?style=flat)](https://travis-ci.org/GeniusSport/GeniusSportWidgetLoader)
[![Version](https://img.shields.io/cocoapods/v/GeniusSportWidgetLoader.svg?style=flat)](http://cocoapods.org/pods/GeniusSportWidgetLoader)
[![License](https://img.shields.io/cocoapods/l/GeniusSportWidgetLoader.svg?style=flat)](http://cocoapods.org/pods/GeniusSportWidgetLoader)
[![Platform](https://img.shields.io/cocoapods/p/GeniusSportWidgetLoader.svg?style=flat)](http://cocoapods.org/pods/GeniusSportWidgetLoader)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

GeniusSportWidgetLoader is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GeniusSportWidgetLoader'
```

## Usage

To present a widget full screen in a viewController's viewDidLoad() method, create an instance of GSWidget, passing in the url of the widget and a delegate object. Then set the main view of the viewController to the GSWidget object. The delegate can be any object that conforms to the GSWidgetListener protocol.

E.g.
```ruby
  override func viewDidLoad() {
        super.viewDidLoad()
        let wigetView = GSWidget(url: url, delegate: self)
        view = wigetView
    }

```

The GSWidgetListener protocol implements 2 methods:

```ruby
func onMessage(type: String, message: [String: Any])

func onError(type: String, rawMessage: String)
```

## Author

Genius Sport, trevor.doodes@betgenius.com

## License

GeniusSportWidgetLoader is available under the MIT license. See the LICENSE file for more info.
