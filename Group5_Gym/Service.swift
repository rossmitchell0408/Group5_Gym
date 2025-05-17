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
    private var totalSessions: Int
    private var keywords: [String] = []
    
    init(id: String, name: String, fee: Int) {
        self.id = id
        self.name = name
        self.fee = fee
        self.totalSessions = 5
    }
    
    convenience init(id: String, name: String, fee: Int, sessions: Int) {
        self.init(id: id, name: name, fee: fee)
        self.totalSessions = sessions
    }
    
    func addKeyword(keyword: String) {
        keywords.append(keyword)
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
    func getSessions() -> Int {
        return totalSessions
    }
    func getKeywords() -> [String] {
        return keywords
    }
}

extension Service: CustomStringConvertible {
    var description: String {
        return "\(id)-\(name): Cost: $\(fee), Sessions: \(totalSessions)"
    }
}
