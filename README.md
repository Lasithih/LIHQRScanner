# LIHQRScanner

[![CI Status](http://img.shields.io/travis/Lasith Hettiarachchi/LIHQRScanner.svg?style=flat)](https://travis-ci.org/Lasith Hettiarachchi/LIHQRScanner)
[![Version](https://img.shields.io/cocoapods/v/LIHQRScanner.svg?style=flat)](http://cocoapods.org/pods/LIHQRScanner)
[![License](https://img.shields.io/cocoapods/l/LIHQRScanner.svg?style=flat)](http://cocoapods.org/pods/LIHQRScanner)
[![Platform](https://img.shields.io/cocoapods/p/LIHQRScanner.svg?style=flat)](http://cocoapods.org/pods/LIHQRScanner)


## Installation

LIHQRScanner is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LIHQRScanner"
```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

#### Step 1
Declare an instance of LIHQRScanner

``` Swift
private var qrScanner: LIHQRScanner?
```
#### Step 2
Add the following code inside viewDidLoad method
``` Swift
self.qrScanner = LIHQRScanner()
self.qrScanner?.delegate = self
```
#### Step 3
Add the following code inside viewDidLayoutSubviews method
``` Swift
self.qrScanner?.initialize(videoContainer: self.scannerContainer)
self.qrScanner?.startSession(nil)
```

#### Step 4
Implement from LIHQRScannerDelegate
``` Swift
class ViewController: UIViewController, LIHQRScannerDelegate
```

#### Step 5
override qrDetected method
``` Swift
func qrDetected(qrString: String?, error: NSError?) {

    if let qrCode = qrString {
        print(qrCode)
    }
}
```


## Requirements

iOS 8.0+

## Known Issues

Only supports for portrait yet. 

## Author

Lasith Hettiarachchi, lasithih@yahoo.com

## License

LIHQRScanner is available under the MIT license. See the LICENSE file for more info.
