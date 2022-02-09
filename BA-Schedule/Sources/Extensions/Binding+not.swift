//
//  Binding+not.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 09.02.22.
//

import Foundation
import SwiftUI

extension Binding where Value == Bool {
    var not: Binding<Value> {
        Binding<Value>(
            get: { !self.wrappedValue },
            set: { self.wrappedValue = !$0 }
        )
    }
}
