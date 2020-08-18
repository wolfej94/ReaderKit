# ReaderKit
A swift library for quickly integrating a built in camera session into your app.
 
**Installing with cocoapods**
```
pod 'ReaderKit'
```

**Quick start**

First start by creating a ReaderKitDelegate, this will handle the result of any images being captured
```
extension ViewController: ReaderKitDelegate {
    
    func didFindText(text: String, frame: CGRect) {
        print(text)
    }
    
}
```

Once you have your delegate setup, you can initialize your ReaderKit object. The initializer takes 2 arguments:

- A view that will be used to display your camera preview
- The delegate which we declare above.

```
do {
    camera = try ReaderKit(view: captureView, delegate: self)
} catch let error {
    showReaderKitError(error as? ReaderKitError)
}
```

Once this is done you can toggle flash, switch cameras, take photos and record videos
```
try? camera.switchCamera()
try? camera.toggleFlash(.auto)
```
