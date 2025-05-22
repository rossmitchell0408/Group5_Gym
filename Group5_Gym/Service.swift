//
//  Service.swift
//  Group5_Gym
//
//  Created by Ross Mitchell on 2025-05-15.
//

import Foundation

class Service: isPurchasable, CustomStringConvertible {
    private var id: String
    private var name: String
    private var fee: Int
    private var totalSessions: Int
    private var keywords: [String] = []
    private var type: String?
    var description: String {
        "\(type != nil ? type! + ":" : "Class:") \(name) - Fee: \(fee) - ID: \(id)"
    }
    
    init(id: String, name: String, fee: Int, sessions: Int, type: String? = nil) {
        self.id = id
        self.name = name
        self.fee = fee
        self.totalSessions = sessions
        self.type = type
        if let type = type {
            addKeyword(keyword: type)
        }
    }
    
    func addKeyword(keyword: String) {
        keywords.append(keyword.lowercased())
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
    
    func printReceipt(status: serviceStatus) -> String {
        switch status {
        case .booked:
            "Congrats on enrolling for the \(description) class! It cost \(fee) credits."
        case .refunded:
            "You've successfully cancelled your enrollment in the \(description) class. Refunding \(fee) credits to your account."
        case .alreadyEnrolled:
            "You're currently enrolled in this class! You can't register for the same course again before completing it."
        case .cantRefund:
            "Sorry, you are ineligble for a refund for this course."
        }
    }
}

enum serviceStatus {
    case booked
    case refunded
    case alreadyEnrolled
    case cantRefund
}
