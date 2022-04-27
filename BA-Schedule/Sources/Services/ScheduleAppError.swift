//
//  ScheduleAppError.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 27.04.22.
//

import Foundation

enum ScheduleAppError: Error {
    
    enum offlineSupport: Error {
        case directoryNotFound
    }
    
}
