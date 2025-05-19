//
//  Member.swift
//  Group5_Gym
//
//  Created by Ash Bisol on 2025-05-16.
//

import Foundation

class Member {
    private var name: String
    private let id: String
    private var balance: Int
    private var bookedServices: [String: (sessionAttended: Int, service: Service)] = [:]
    
    init(name: String, balance: Int = 100) {
        self.name = name
        self.id = UUID.init().uuidString
        self.balance = balance
    }
    
    func getName() -> String {
        return name
    }
    func getId() -> String {
        return id
    }
    func getBalance() -> Int {
        return balance
    }
    
    func bookService(service: Service) {
        // If the service is already booked, check if the course has been completed
        if let memberService = bookedServices[service.getId()] {
            if memberService.sessionAttended != service.getSessions() {
                // If the course is not complete, return the output string and exit the func early
                print (memberService.service.printReceipt(status: serviceStatus.alreadyEnrolled))
            }
        }
        // Check that the service can be afforded
        else if service.getFee() > balance {
            print ("You cannot afford this course. It costs \(service.getFee()) credits and you have \(balance) credits.")
        } else {
            // Add the service to the dict of bookedServices and set sessionAttended to 0, then deduce the fee from balance
            bookedServices[service.getId()] = (sessionAttended: 0, service: service)
            balance -= service.getFee()
            print (service.printReceipt(status: serviceStatus.booked))
        }
    }
    
    func cancelService(service: Service) {
        // Check if the service is already booked
        if let memberService = bookedServices[service.getId()] {
            // Check if more than one session attended, or the course is completed
            if (memberService.sessionAttended > 1) || (memberService.sessionAttended == memberService.service.getSessions()) {
                print (memberService.service.printReceipt(status: serviceStatus.cantRefund))
            } else {
                // If eligible for a refund, remove from bookedServices and refund the balance
                bookedServices[id] = nil
                balance += memberService.service.getFee()
                print (memberService.service.printReceipt(status: serviceStatus.refunded))
            }
        } else {
            print ("You aren't enrolled in a service with that ID.")
        }
    }
    
    func markAttendance(id: String) {
        // Check if the service is booked
        if let memberService = bookedServices[id] {
            // Increment sessions by one and then congratulate the member for completing the course or let them know how many sessions remain
            bookedServices[id]!.sessionAttended += 1
            if (memberService.sessionAttended+1 == memberService.service.getSessions()) {
                print ("Congrats on completing your course!")
            } else {
                print ("Attendance marked. You have \(memberService.service.getSessions() - bookedServices[id]!.sessionAttended) sessions left.")
            }
        } else {
            print ("You aren't enrolled in a service with that ID.")
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
