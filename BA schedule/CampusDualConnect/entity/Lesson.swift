//
//  Lesson.swift
//  BA schedule
//
//  Created by Jonas Richard Richter on 21.05.21.
//

import Foundation

public struct Lesson: Codable, Hashable {
    public var  title: String
    public var  start: Int
    public var  end: Int
    public var  description: String
    public var  room: String
    public var  instructor: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case start = "start"
        case end = "end"
        case description = "description"
        case room = "room"
        case instructor = "instructor"
    }
    
    public func getStart() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: NSDate.init(timeIntervalSince1970: TimeInterval(start)) as Date)
    }
    
    public func getEnd() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: NSDate.init(timeIntervalSince1970: TimeInterval(end)) as Date)
    }
}
