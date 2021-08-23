//
//  Wnd.swift
//  Buttery TV
//
//  Created by Jonathan Holland on 8/12/21.
//

#if os(macOS)
import AppKit

enum Wnd {
    static var urlName = "WindowMaker"
    
    static var mainView = "MainView"
    static var shareView = "ShareView"
    static var controlsView = "ControlsView"
    
    static func open(_ identifier: String){
        if let url = URL(string: "\(Wnd.urlName)://\(identifier)") {
            NSWorkspace.shared.open(url)
        }
    }
}
#endif
