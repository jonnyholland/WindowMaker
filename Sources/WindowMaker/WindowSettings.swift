//
//  WindowSettings.swift
//  Buttery
//
//  Created by Jonathan Holland on 7/7/21.
//

import Foundation
import SwiftUI

#if os(macOS)
@available(macOS 11, *)
public struct WindowSettings {
    public var identifier: String?
    public var title: String?
    public var showCloseButton: Bool?
    public var showMiniaturizeButton: Bool?
    public var showZoomButton: Bool?
    public var backgroundColor: NSColor?
    public var isOpaque: Bool?
    public var isMovable: Bool
    public var isMovableByWindowBackground: Bool
    public var acceptsMouseMovedEvents: Bool
    public var titleVisibility: NSWindow.TitleVisibility?
    public var titleBarAppearsTransparent: Bool?
    public var showsToolbarButton: Bool?
    public var toolbarIsVisible: Bool?
    public var contentAspectRatio: NSSize?
    
    public init(identifier: String? = nil, title: String? = nil, showCloseButton: Bool? = nil, showMiniaturizeButton: Bool? = nil, showZoomButton: Bool? = nil, backgroundColor: NSColor? = nil, isOpaque: Bool? = nil, isMovable: Bool = true, isMovableByWindowBackground: Bool = true, acceptsMouseMovedEvents: Bool = true, titleVisibility: NSWindow.TitleVisibility? = nil, titleBarAppearsTransparent: Bool? = nil, showsToolbarButton: Bool? = nil, toolbarIsVisible: Bool? = nil, contentAspectRatio: NSSize? = nil) {
        self.identifier = identifier
        self.title = title
        self.showCloseButton = showCloseButton
        self.showMiniaturizeButton = showMiniaturizeButton
        self.showZoomButton = showZoomButton
        self.backgroundColor = backgroundColor
        self.isOpaque = isOpaque
        self.isMovable = isMovable
        self.isMovableByWindowBackground = isMovableByWindowBackground
        self.acceptsMouseMovedEvents = acceptsMouseMovedEvents
        self.titleVisibility = titleVisibility
        self.titleBarAppearsTransparent = titleBarAppearsTransparent
        self.showsToolbarButton = showsToolbarButton
        self.toolbarIsVisible = toolbarIsVisible
        self.contentAspectRatio = contentAspectRatio
    }
    
    /// This method sets up the NSWindow according to the settings provided and passes it out to the
    /// completion handler.
    ///
    /// - Parameters:
    ///     - view (NSView): pass in the view for the window
    ///     - handler: escaping out the NSWindow that is setup according to the settings.
    public func setupWindow(from view: NSView, handler: @escaping (NSWindow?) -> Void){
        let window = view.window
        if let identifier = identifier {
            window?.identifier = .init(identifier)
        }
        if let title = title {
            window?.title = title
            window?.miniwindowTitle = title
            window?.setAccessibilityTitle(title)
        }
        window?.standardWindowButton(NSWindow.ButtonType.closeButton)?.isHidden = !(showCloseButton ?? true)
        window?.standardWindowButton(NSWindow.ButtonType.miniaturizeButton)?.isHidden = !(showMiniaturizeButton ?? true)
        window?.standardWindowButton(NSWindow.ButtonType.zoomButton)?.isHidden = !(showZoomButton ?? true)
        if let backgroundColor = backgroundColor {
            window?.backgroundColor = backgroundColor
        }
        if let isOpaque = isOpaque {
            window?.isOpaque = isOpaque
        }
        window?.isMovable = isMovable
        window?.isMovableByWindowBackground = isMovableByWindowBackground
        window?.acceptsMouseMovedEvents = acceptsMouseMovedEvents
        if let titleVisibility = titleVisibility {
            window?.titleVisibility = titleVisibility
        }
        if let titleBarAppearsTransparent = titleBarAppearsTransparent {
            window?.titlebarAppearsTransparent = titleBarAppearsTransparent
        }
        if let showsToolbarButton = showsToolbarButton {
            window?.showsToolbarButton = showsToolbarButton
        }
        if let toolbarIsVisible = toolbarIsVisible {
            window?.toolbar?.isVisible = toolbarIsVisible
        }
        if let contentAspectRatio = contentAspectRatio {
            window?.contentAspectRatio = contentAspectRatio
        }
        handler(window)
    }
    
    /// Create a basic borderless window of NSWindow and allows user to move the window by background
    /// User can click anywhere in the background of the window to move it.
    public static func borderlessWindow() -> WindowSettings {
        return .init(showCloseButton: false, showMiniaturizeButton: false, showZoomButton: false, backgroundColor: .clear, isOpaque: false, isMovable: true, isMovableByWindowBackground: true, acceptsMouseMovedEvents: true, titleVisibility: .hidden, titleBarAppearsTransparent: true, showsToolbarButton: false, toolbarIsVisible: false)
    }
    /// Create a customized borderless window of NSWindow and allows user to move by click-dragging anywhere
    ///
    /// - Parameters:
    /// - id (String): Provides the window with an identifier to assist with managing it later.
    public static func borderlessWindow(with id: String) -> WindowSettings {
        return .init(identifier: id, showCloseButton: false, showMiniaturizeButton: false, showZoomButton: false, backgroundColor: .clear, isOpaque: false, isMovable: true, isMovableByWindowBackground: true, acceptsMouseMovedEvents: true, titleVisibility: .hidden, titleBarAppearsTransparent: true, showsToolbarButton: false, toolbarIsVisible: false)
    }
}
#endif
