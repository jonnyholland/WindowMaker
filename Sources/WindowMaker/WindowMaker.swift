//
//  WindowMaker.swift
//  Buttery
//
//  Created by Jonathan Holland on 7/7/21.
//

import Foundation
import SwiftUI

#if os(macOS)
@available(macOS 11, *)
public struct WindowMaker: NSViewRepresentable {
    @Binding var window: NSWindow?
    public var settings: WindowSettings
    
    public init(window: Binding<NSWindow?>, settings: WindowSettings = .init()) {
        self._window = window
        self.settings = settings
    }
    
    public func makeNSView(context: Context) -> some NSView {
        let view = NSView()
        DispatchQueue.main.async {
            settings.setupWindow(from: view) { window in
                self.window = window
            }
        }
        return view
    }
    public func updateNSView(_ nsView: NSViewType, context: Context) {
        
    }
}
#endif
