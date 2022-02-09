//
//  ServiceWrapper.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 01.02.22.
//

import Foundation
import CampusDualKit

class ServiceWrapper: ObservableObject {
    
    // MARK: - Schedule
    
    func checkCredentials(username: String, hash: String, completion: @escaping (Result<Bool, CampusDualKit.ScheduleServiceError>) -> Void) {
        
        // Show demo data for App Review
        if username == "appledemo" && hash == "appledemo" {
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
    
    func loadSchedule(username: String, hash: String, completion: @escaping (Result<[StudyDay], ScheduleServiceError>) -> Void) {
        
        // Show demo data for App Review
        if username == "appledemo" && hash == "appledemo" {
            #warning("Implement App Review mode.")
            completion(.failure(.network(nil)))
            return
        }
        
        var service: ScheduleService?
        
        ScheduleService.login(for: username, with: hash) { (result: Result<ScheduleService, ScheduleServiceError>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let result):
                service = result
            }
        }
        guard let service = service else {
            completion(.failure(.other(nil)))
            return
        }

        service.studyDays(from: Date(), to: Calendar.current.date(byAdding: .day, value: 90, to: Date()) ?? Date(), completion: { (result: Result<[StudyDay], ScheduleServiceError>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                completion(.success(response))
            }
        })
        
    }
}
