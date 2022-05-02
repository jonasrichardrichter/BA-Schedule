//
//  ServiceWrapper.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 01.02.22.
//

import Foundation
import CampusDualKit

class ServiceWrapper: ObservableObject {
    
    // MARK: Credentials
    
    func checkCredentials(username: String, hash: String, completion: @escaping (Result<Bool, CampusDualKit.ScheduleServiceError>) -> Void) {
        
        // Show demo data for App Review
        if username == "99999" && hash == "appledemo" {
            completion(.success(true))
            return
        }
        
        ScheduleService.login(for: username, with: hash) { (result: Result<ScheduleService, ScheduleServiceError>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(_):
                completion(.success(true))
            }
        }
    }
    
    // MARK: - Schedule
    
    func loadSchedule(username: String, hash: String) async throws -> [StudyDay] {
        
        // Show demo data for App Review
        if username == "99999" && hash == "appledemo" {
            return StudyDay.demoData
        }
        
        do {
            let service = try await ScheduleService.login(for: username, with: hash)
            let schedule = try await service.studyDays(from: Date(), to: Calendar.current.date(byAdding: .day, value: 90, to: Date()) ?? Date(), session: .shared)
            try self.saveToJson(schedule)
            
            return schedule
        } catch {
            throw error
        }
    }
    
    // MARK: - Offline Support
    
    func loadFromJson() async throws -> [StudyDay] {
        let fileManager = FileManager()
        let jsonDecoder = JSONDecoder()
        
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("schedule.json") else { throw ScheduleAppError.offlineSupport.directoryNotFound }
        
        let data = try Data(contentsOf: url)
        
        let schedule = try jsonDecoder.decode([StudyDay].self, from: data)
        
        return schedule
    }
    
    func saveToJson(_ schedule: [StudyDay]) throws {
        let fileManager = FileManager()
        let jsonEncoder = JSONEncoder()
        
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("schedule.json") else { throw ScheduleAppError.offlineSupport.directoryNotFound }
        
        if fileManager.fileExists(atPath: url.absoluteString) {
            try fileManager.removeItem(at: url)
        }
        
        let data = try jsonEncoder.encode(schedule)
        
        try data.write(to: url)
    }
}
