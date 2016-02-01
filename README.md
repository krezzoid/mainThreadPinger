# mainThreadPinger

### Usage
```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

//
// some of your code here ...
//

// will create mainThreadPinger object and start pinging main/ui thread
let pinger = mainThreadPinger.sharedInstance

return true
}
```