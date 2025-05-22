//
//  Gym.swift
//  Group5_Gym
//
//  Created by Ash Bisol on 2025-05-16.
//

import Foundation

class Gym {
    private var services: [Service] = []
    
    func addService(service: Service) {
        services.append(service)
    }
    func addService(service: [Service]) {
        services += service
    }
    
    func listServices() {
        print("Listing all services:")
        for service in services{
            print("\(service.description)")
        }
    }
    func search(keyword: String?) -> [Service]? {
        var results : [Service] = []
        print("Searching...")
        if (keyword == "" || keyword == " " || keyword == nil) {
            print("Please enter a key word to search.")
            return nil
        }
        for service in services {
            if (service.getName().lowercased() == keyword!.lowercased()) {
                results.append(service)
            } else if (checkKeywords(keyword: keyword!, keywords: service.getKeywords())) {
                results.append(service)
            }
        }
        return results
    }
    private func checkKeywords(keyword: String, keywords: [String]) -> Bool {
        for word in keywords {
            if (word.lowercased() == keyword.lowercased()) {
                return true
            }
        }
        return false
    }
}
