//
//  Helpers.swift
//  
//
//  Created by Jonathan Holland on 8/22/21.
//

import Foundation
import SwiftUI

#if os(macOS)
public func updateReact(newValue: NSWindow?, handler: @escaping (NSWindow?) -> Void) {
    handler(newValue)
}
#endif
