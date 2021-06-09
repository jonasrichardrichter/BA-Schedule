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

public class CampusDualConnect: ObservableObject {
    
    let keychain = KeychainSwift()
    
    @AppStorage("lastUpdate") var lastUpdate: String?
    @AppStorage("campusDualUrl") var campusDualUrl: String = "https://selfservice.campus-dual.de/room/json"
    
    let dateFormatter = DateFormatter()
    
    @Published var lessonsUnsorted: [Lesson] = []
    @Published var studyDays: [StudyDay] = []
    
    init() {
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss Z"
    }
    
    func generateUrl() -> URL {
        
        // Get Matrikel and Hash from Keychain
        
        let matrikel = keychain.get("matrikel")
        let hash = keychain.get("hash")
        
        
        // Generate link of the request
        
        let startString = String(NSDate.now.timeIntervalSince1970)
        let endString = String(NSDate.now.timeIntervalSince1970 + 5266800)
        
        let lessonsJsonUrl = NSURL(string: "\(campusDualUrl)?userid=\(matrikel ?? "")&hash=\(hash ?? "")&start=\(startString)&end=\(endString)")!
        
        
        print("LOG: generated link: \(lessonsJsonUrl)")
        
        return lessonsJsonUrl as URL
    }

    func downloadJson() {
        
        // Download the json for the next 20 weeks and save it
        
        // Create session, download json and save to lessons.txt
        let url = self.generateUrl()
        
        let session = URLSession(configuration: .default)
        
        session.downloadTask(with: url) { localURL, _, _ in
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
        
        let jsonData: Data
    
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
                    let intIndex = Int(index)!
                    if self.isLessonInFuture(startTime: json[intIndex]["start"].int ?? 0) {
                        let jsonLesson = Lesson.init(title: json[intIndex]["title"].string ?? "", start: json[intIndex]["start"].int ?? 0, end: json[intIndex]["end"].int ?? 0, description: json[intIndex]["description"].string ?? "", room: json[intIndex]["room"].string ?? "", instructor: json[intIndex]["instructor"].string ?? "")
                        print("LOG: Created new lesson: \(jsonLesson)")
                        self.lessonsUnsorted.append(jsonLesson)
                    } else {
                        print("LOG: Skipped lesson.")
                    }
                }
            }
        } catch {
            print(error)
        }
        
        self.sortByStudyDay()
        
    }
    
    func sortByStudyDay() {
        
        // Sorts all lessons by day into StudyDays
        
        for lesson in lessonsUnsorted {
            let nsDate = NSDate(timeIntervalSince1970: TimeInterval(lesson.start))
            dateFormatter.dateStyle = .short
            let date = dateFormatter.string(from: nsDate as Date)

            
            
        }
        
    }
    
    func isLessonInFuture(startTime: Int) -> Bool {
        
        // Checks if a lesson is in the future or today
        
        print("LOG: Trying to parse startTime: \(startTime)")
        let startDate: Date = NSDate.init(timeIntervalSince1970: TimeInterval(startTime)) as Date
        print("LOG: Start time of the lesson is: \(startDate)")
        
        if Calendar.current.isDateInToday(startDate) || Date() < startDate {
            print("LOG: Lesson is in the future.")
            return true
        } else {
            print("LOG: Lesson is in the past. Skipping lesson creation.")
            return false
        }
    }
    
    public func isConnectedToInternet() -> Bool {
        return true
    }
    
    public func getTimeTable(forceUpdate: Bool) {
        
        if forceUpdate {
            lessonsUnsorted = []
            downloadJson()
        }
        
        // Check when the last update happend to reduce calls to Campus Dual
        
        if lastUpdate != nil {
            if let lastUpdateDate = dateFormatter.date(from: lastUpdate!) {
                if isConnectedToInternet() {
                    if Calendar.current.isDateInToday(lastUpdateDate) {
                        print("LOG: Last update was today, skipping auto-update")
                        parseJson()
                    } else {
                        print("LOG: Last update wasn't today, downloading new.")
                        downloadJson()
                    }
                } else {
                    print("LOG: No Internet Connection, parsing the fetched version.")
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
