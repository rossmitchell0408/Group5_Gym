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
    
    func listServices() {
        print("Listing all services:")
        for service in services{
            print("\(service.description)")
        }
    }
}
