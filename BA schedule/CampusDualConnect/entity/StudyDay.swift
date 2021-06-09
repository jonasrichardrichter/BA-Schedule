//
//  StudyDay.swift
//  BA schedule
//
//  Created by Jonas Richard Richter on 21.05.21.
//

import Foundation

public struct StudyDay: Codable, Hashable {
    
    public var day: Date
    public var lessons: [Lesson]

}
