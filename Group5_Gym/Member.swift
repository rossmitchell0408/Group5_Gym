//
//  Member.swift
//  Group5_Gym
//
//  Created by Ash Bisol on 2025-05-16.
//

import Foundation

// TODO - Add some func or something to make receipt printouts easier, either here or in Service, not 100% sure yet
// I'm just being lazy about it atm (:

class Member {
    private var name: String
    private let id: Int
    private var balance: Int
    private var bookedServices: [String: (sessionAttended: Int, service: Service)] = [:]
    
    init(name: String, id: Int) {
        // TODO - Some functionality for randomly generated UUIDs
        self.name = name
        self.id = id
        self.balance = 100
    }
    
    // TODO - Remove any getters that aren't needed at the end of everything
    func getName() -> String {
        return name
    }
    func getId() -> Int {
        return id
    }
    func getBalance() -> Int {
        return balance
    }
    
    func bookService(service: Service) -> String {
        // If the service is already booked, check if the course has been completed
        if let memberService = bookedServices[service.getId()] {
            if memberService.sessionAttended != service.getSessions() {
                // If the course is not complete, return the output string and exit the func early
                return "You're currently enrolled in this course! You've attended \(memberService.sessionAttended) out of \(service.getSessions()) total sessions."
            }
        }
        // Check that the service can be afforded
        if service.getFee() < balance {
            return "You cannot afford this course. It costs \(service.getFee()) and you have \(balance)."
        } else {
            // Add the service to the dict of bookedServices and set sessionAttended to 0, then deduce the fee from balance
            bookedServices[service.getId()] = (sessionAttended: 0, service: service)
            balance -= service.getFee()
            return "Congrats! You've just booked the \(service.getName()) class! It cost \(service.getFee()) and you have \(balance) remaining."
        }
    }
    
    func cancelService(id: String) -> String {
        // Check if the service is already booked
        if var memberService = bookedServices[id] {
            // Check if more than one session attended, or the course is completed
            if (memberService.sessionAttended > 1) || (memberService.sessionAttended == memberService.service.getSessions()) {
                return "Sorry, you've either attended more than one session or completed this class. You are ineligible for a refund at this time."
            } else {
                // If eligible for a refund, remove from bookedServices and refund the balance
                bookedServices[id] = nil
                balance += memberService.service.getFee()
                return "You've been refunded \(memberService.service.getFee()) and your new balance is \(balance)."
            }
        } else {
            return "You aren't enrolled in a service with that ID."
        }
    }
    
    func markAttendance(id: String) -> String {
        // Check if the service is booked
        if let memberService = bookedServices[id] {
            // Increment sessions by one and then congratulate the member for completing the course or let them know how many sessions remain
            bookedServices[id]!.sessionAttended += 1
            if (memberService.sessionAttended+1 == memberService.service.getSessions()) {
                return "Congrats on completing your course!"
            } else {
                return "Attendance marked. You have \(memberService.service.getSessions() - bookedServices[id]!.sessionAttended) courses left."
            }
        } else {
            return "You aren't enrolled in a service with that ID."
        }
    }
    
    func addBalance(num: Int) {
        self.balance+=num
    }
    
    func printServices() {
        for memberService in bookedServices.values {
            var printString: String = "\(memberService.service.getName()): "
            if (memberService.sessionAttended == memberService.service.getSessions()) {
                printString += "Course complete!"
            } else {
                printString += "\(memberService.sessionAttended)/\(memberService.service.getSessions())"
            }
            print("\(printString)")
        }
    }
}
