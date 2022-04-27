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
            return try await service.studyDays(from: Date(), to: Calendar.current.date(byAdding: .day, value: 90, to: Date()) ?? Date(), session: .shared)
        } catch {
            throw error
        }
    }
    
    // MARK: - Offline Support
    
    
    
}
