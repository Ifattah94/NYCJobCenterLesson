//
//  JobCenterAPIClient.swift
//  NYCJobCentersLesson
//
//  Created by C4Q on 11/6/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import Foundation
struct JobCenterAPIClient {
    private init() {}
    
    static let shared = JobCenterAPIClient()
    
    
    func getJobCenter(completionHandler: @escaping (Result<[JobCenter], AppError>) -> Void)  {
        let urlStr = "https://data.cityofnewyork.us/resource/9ri9-nbz5.json"
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return}
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.other(rawError: error)))
            case .success(let data):
                do {
                let jobCenters = try JSONDecoder().decode([JobCenter].self, from: data)
                    completionHandler(.success(jobCenters))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
        
    }
}
