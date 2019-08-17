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

### Project setup

To use the pod in your own project create your XCODE project, open a terminal and CD to the project root folder. To initialise the project to use cocoa pods run the command:

``````ruby
pod init
``````

This will create a 'Podfile' file, edit this to include the GeniusSportWidgetLoader pod. Update the name of the targets to to be the same as your project:

```ruby
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GeniusSportWidgetLoaderDemo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GeniusSportWidgetLoaderDemo
  pod 'GeniusSportWidgetLoader'

  target 'GeniusSportWidgetLoaderDemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
```

then run the following command to install the dependencies:

```ruby
pod install
```

Once this is complete always open the <project name>.xcworkspace to continue development.

### Pod usage

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

The onMessage type is a string which represents the message type, e.g. "addToBetslip".

The message parameter contains a dictionary of key-value pairs. The selection details are accessed the using the 'selection' key.

## Pod Maintenance

To maintain the pod open the Example/GeniusSportWidgetLoader.xcworkspace. Opening the project this way enables you to edit both the pod and the example app in the same project.

The code for the pod can be found in the Development Pods folder of the Pods project in XCODE.

When making changes to the pod, you will have to update the .podspec file to update the version number of the pod.

```ruby
s.version          = '0.2.0'
```

### Deploying the pod

Pods are deployed to the public repo using the 'pod trunk' command. In order to deploy a pod you need to set up an account with your email address. This begins a session on your current device. To create an account, type the following command, using your own email address:

```code
$ pod trunk register orta@cocoapods.org 'Orta Therox' --description='macbook air'
```

You will then receive a confirmation email from cocoapods.org. You may have to whitelist this domain.

Further information can be found here https://guides.cocoapods.org/making/getting-setup-with-trunk.html


Once you are ready to deploy the pod, tag your most recent commit and push it to the remote.

```code
$ git tag 0.1.0
$ git push origin 0.1.0
```
The tag must match the version in your podspec

Next validte the podspec to ensure that there are no issues, Do this by using the following command:

```code
$ pod spec lint GeniusSportWidgetLoader.podspec
```
This should output the following:

```code
$ pod spec lint GeniusSportWidgetLoader.podspec
 -> GeniusSportWidgetLoader (0.1.0)
Analyzed 1 podspec.
GeniusSportWidgetLoader.podspec passed validation.
```

Once the podspec is verified you can push the spec to the specs repository using the following command:

```code
$ pod trunk push GeniusSportWidgetLoader.podspec
```

Only owners can push the spec, but adding an owner is just a case of using the 'pod trunk add-owner' command.

```code
$ pod trunk add-owner GeniusSportWidgetLoader <email address>
```
The email address used will need to have a registered account set up on trunk in order to add them to a library.

Owners can be removed using the following command.

```code
$ pod trunk remove-owner GeniusSportWidgetLoader <email address>
```

## Author

Genius Sport

## License

GeniusSportWidgetLoader is available under the MIT license. See the LICENSE file for more info.
