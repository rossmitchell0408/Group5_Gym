//
//  Service.swift
//  Group5_Gym
//
//  Created by Ross Mitchell on 2025-05-15.
//

import Foundation

class Service {
    private var id: String
    private var name: String
    private var fee: Int
    
    init(id: String, name: String, fee: Int) {
        self.id = id
        self.name = name
        self.fee = fee
    }
    
    func getId() -> String {
        return id
    }
    func getName() -> String {
        return name
    }
    func getFee() -> Int {
        return fee
    }
}
