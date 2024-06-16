//
//  API.swift
//  ANF Code Test
//
//  Created by Daniel Espinosa on 6/13/24.
//

import Foundation
import UIKit


class APIClient: NSObject {
    
    var mockData: Data?
    
    let exploreEndpoint: URL = URL(string: "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.css")!

    override init() {
        //Auto Sets mock Data on unit tests
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            // Code only executes when tests are running
            let path = Bundle.main.path(forResource: "exploreData", ofType: "json")!
            do {
                let mockData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                self.mockData = mockData
            } catch {
                
            }
        }
    }
    

    func fetchExploreCards(completion: @escaping (Result<[Card], Error>) -> Void) {
        if let mockData {
            completion(self.extractExploreCardData(mockData))
        } else {
            URLSession.shared.dataTask(with: exploreEndpoint) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NSError(domain: "Data not available", code: 0, userInfo: nil)))
                    return
                }
                
                completion(self.extractExploreCardData(data))
                
            }.resume()
        }
    }
    
    private func extractExploreCardData(_ data: Data) -> Result<[Card], Error> {
        do {
            let decoder = JSONDecoder()
            let contentArray = try decoder.decode([Card].self, from: data)
            return(.success(contentArray))
        } catch {
            return(.failure(error))
        }
    }
    
}

