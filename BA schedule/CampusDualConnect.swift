//
//  CampusDualConnect.swift
//  BA schedule
//
//  Created by Jonas Richard Richter on 20.03.21.
//

import Foundation
import SwiftyJSON
import SwiftUI
import KeychainSwift

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
    
    public func getStartToEnd() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let startTime = dateFormatter.string(from: NSDate.init(timeIntervalSince1970: TimeInterval(start)) as Date)
        let endTime = dateFormatter.string(from: NSDate.init(timeIntervalSince1970: TimeInterval(end)) as Date)
        
        return "\(startTime) - \(endTime)"
    }
}

public struct StudyDay: Codable, Hashable {
    public var day: String
    public var lessonsOfTheDay: [Lesson]
}

public class CampusDualConnect: ObservableObject {
    
    let keychain = KeychainSwift()
    
    @AppStorage("lastUpdate") var lastUpdate: String?
    
    let dateFormatter = DateFormatter()
    
    @Published var lessonsUnsorted: [Lesson] = []
    @Published var lessonsSortedByDay: [StudyDay] = []
    
    init() {
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss Z"
    }
    
    func downloadJson() {
        
        // Get Matrikel and Hash from Keychain
        let matrikel = keychain.get("matrikel")
        let hash = keychain.get("hash")
        
        
        // Download the json for the next 20 weeks and save it
        
        // Generate link of the request
        let startString = String(NSDate.now.timeIntervalSince1970)
        let endString = String(NSDate.now.timeIntervalSince1970 + 5266800)
        
        let lessonsJsonUrl = NSURL(string: "https://selfservice.campus-dual.de/room/json?userid=\(matrikel ?? "")&hash=\(hash ?? "")&start=\(startString)&end=\(endString)&_=1608918010896")!
        
        print("LOG: generated link: \(lessonsJsonUrl)")
        
        // Create session, download json and save to lessons.txt
        
        let session = URLSession(configuration: .default)
        
        session.downloadTask(with: lessonsJsonUrl as URL) { localURL, urlResponse, error in
            if let localURL = localURL {
                    if let json = try? String(contentsOf: localURL) {
                        let fileManager: FileManager = FileManager()
                        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("lessons.txt") else { return }
                        if fileManager.fileExists(atPath: url.absoluteString) {
                            print("LOG: lessons.txt exists, deleting it to create one with new data")
                            do {
                                try fileManager.removeItem(atPath: url.absoluteString)
                                print("LOG: lessons.txt deleted")
                            } catch {
                                print("ERROR: there was a problem while removing lessons.json")
                            }
                        }
                        do {
                            let data = Data(json.utf8)
                            try data.write(to: url)
                            print("LOG: created lessons.txt")
                            
                            self.lastUpdate = self.dateFormatter.string(from: Date())
                            print("LOG: updated last updated with current date")
                            
                            self.parseJson()
                        } catch  {
                            print("ERROR: can't create lessons.txt")
                        }
                    }
                }
        }.resume()
    }
    
    func parseJson() {
        
        let fileManager:FileManager = FileManager()
        
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("lessons.txt") else { return }
        
        let jsonData:Data
    
        do {
            jsonData = try Data(contentsOf: url)
        } catch {
            print("ERROR: couldn't read lessons.txt")
            return
        }
        
        do {
            let json = try JSON(data: jsonData)
            for (index,_):(String, JSON) in json {
                DispatchQueue.main.async {
                    let IntIndex = Int(index)!
                    let jsonLesson = Lesson.init(title: json[IntIndex]["title"].string ?? "", start: json[IntIndex]["start"].int ?? 0, end: json[IntIndex]["end"].int ?? 0, description: json[IntIndex]["description"].string ?? "", room: json[IntIndex]["room"].string ?? "", instructor: json[IntIndex]["instructor"].string ?? "")
                    print("LOG: Created new lesson: \(jsonLesson)")
                    self.lessonsUnsorted.append(jsonLesson)
                }
            }
        } catch {
            print(error)
        }
        
    }
    
    #warning("Build function to sort Lessons by Day")
    func sortLessonsByDay() {
        
    }
    
    public func getTimeTable() {
        
        // Check when the last update happend to reduce calls to Campus Dual
        if lastUpdate != nil {
            if let lastUpdateDate = dateFormatter.date(from: lastUpdate!){
                if Calendar.current.isDateInYesterday(lastUpdateDate) {
                    print("LOG: Last update is away more than yesterday, downloading new.")
                    downloadJson()
                } else {
                    print("LOG: Last update is within yesterday, skipping auto-update")
                    
                    // Parse JSON from file
                    parseJson()
                }
            } else {
                print("ERROR: Couldn't convert lastUpdate string to Date")
                
                downloadJson()
            }
        } else {
            downloadJson()
        }
    }
}
