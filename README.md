#  VelaSMS iOS SDK


## Getting Started

Follow the instructions below to get started with `VelaOffline` iOS SDK  


### Initialize

For this step, you will need to set your SMS Sort Code, Shared Service Code and SMS Encryption Key for the Vela Control System. To Setup, Initialize the SDK as shown below:  

1.  Extend the `VelaAPI` class, and override `smsAPIShortCode(bool: isLive)`,  `smsEncryptionKey()`, `merchantSharedCode` functions  to set the SMS Sort Code, Encryption Key, and Shared Service Code respectively.  e.g.  
```
class MyAPI: VelaAPI{
    override func smsAPIShortCode(bool: isLive) -> String{
        return isLive ? "33445" : "12345"
    }
    
    override func smsEncryptionKey() -> String{
        return "enkey12221931933"
    }
    
    override func merchantSharedCode() -> String? {
        return "05"
    }
}
```

2. In your `AppDelegate`  application func, i.e `func application`, call the `initVela(api: VelaAPI, isLive: Bool)` function by passing the  extended `VelaAPI` class instance. e.g  
```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    initVela(api: VelaAPI(), isLive: false)
}
```
