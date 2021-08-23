# WindowMaker

Easily customize macOS NSWindow and adapt on the fly.

[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-orange.svg)](#swift-package-manager) ![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg) ![platforms](https://img.shields.io/badge/platform-macOS-lightgrey.svg) ![languages](https://img.shields.io/badge/language-Swift%20%7C%20SwiftUI-lightgrey.svg)

## Getting Started

Simply import WindowMaker into the Swift file you want to use it in. 

## SwiftUI
In SwiftUI, add an optional window variable to the top of the View struct and attach the WindowMaker to a background modifier as seen below. 

````swift 
@State private var window: NSWindow?
````

````swift
.background(WindowMaker(window: $window, settings: .init(identifier: Wnd.shareView.rawValue, showCloseButton: false, showMiniaturizeButton: false, showZoomButton: false, backgroundColor: .black, isOpaque: true, isMovable: true, isMovableByWindowBackground: true, acceptsMouseMovedEvents: true, titleVisibility: .hidden, titleBarAppearsTransparent: true, showsToolbarButton: false, toolbarIsVisible: false, contentAspectRatio: controller.unwrappedAspectRatio)))
````

You can also react to changes to the window as below. 

````swift
.onReceive(NotificationCenter.default.publisher(for: NSApplication.willTerminateNotification), perform: { _ in
    window?.isReleasedWhenClosed = true
    window?.close() 
})
````

### Open the Window

There are two ways to open the customized window

1. Register the Wnd url with the info.plist & use Wnd.open(_ identifier: String)
- You can either add "URL types" -> *add item* -> Document Role (Editor) + URL Schemes (WindowMaker or the name of your choice but if you customize this name *make sure you change the Wnd.urlName at run-time*) or you can go to the Target -> Info tab (along top) -> URL Types -> click + button and add in the name for "URL Schemes"
- Add the WindowGroup in the main app file and add "handlesExternalEvents(matching: )" to the WindowGroup.

````swift 
WindowGroup {
    if controller.shareFile {
        ShareView()
            .environmentObject(controller)
    }
}
.handlesExternalEvents(matching: Set(arrayLiteral: Wnd.shareView.rawValue))
````
- Then you simply call Wnd.open(_ identifier: String) and pass in the window identifier from anywhere in the app you want. 

````swift
Wnd.open(Wnd.shareView)
````

2. Manually activate the window easily by calling an @objc func and pass in the name.
- This method is more forceful and show be avoided unless there are issues with the first way.

````swift
@objc func activateShareWindow(_ sender: AnyObject) {
    NSApp.setActivationPolicy(.regular) //Optionally, set the activation policy.
    
    // This needs to be done on the main queue or the app will have issues rendering and with performance.
    DispatchQueue.main.async { 
        NSApp.windows.forEach({ Console("Window: \($0.identifier?.rawValue ?? "N/A")") })
        if let window = NSApp.windows.first(where: { $0.identifier?.rawValue ?? "" == Wnd.shareView.rawValue }) {
            window.orderFrontRegardless()
        }
    }
}
````

#### Swift Package Manager

If you use Swift Package Manager, simply add ReactiveSwift as a dependency
of your package in `Package.swift`:

```
.package(url: "https://github.com/jonnyholland/WindowMaker.git", from: "1.0.0")
```
