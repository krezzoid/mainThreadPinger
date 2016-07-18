# mainThreadPinger
[![codebeat badge](https://codebeat.co/badges/2b978a49-8336-4271-847a-adc12a928d9a)](https://codebeat.co/projects/github-com-krezzoid-mainthreadpinger)

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
