//
//  main.swift
//  Group5_Gym
//
//  Created by Ross Mitchell on 2025-05-15.
//

/* TODO - Remove any getters that aren't needed in all classes at the end of everything
        - Add driver code (while loop or something?)
        - Add service searching to Gym class
 */

import Foundation

print("Group5_Gym")

var setupServices = [
    PersonalTraining(id: createRandomId(), name: "Lifting", fee: 100, trainer: "Tim", durationMinutes: 40),
    FitnessClass(id: createRandomId(), name: "Intermediate Swim", fee: 110, activity: "Swimming"),
    PersonalTraining(id: createRandomId(), name: "Couch to 10K", fee: 80, sessions: 9, trainer: "Lisa", durationMinutes: 60),
    FitnessClass(id: createRandomId(), name: "Yoga", fee: 95, sessions: 1, activity: "Yoga Class")
]
var gym = Gym()
gym.addService(service: setupServices)

var running = true
var loggedin = false
var member = Member(name: "default")

// This is the main loop that will run until the user quits
while (running) {
    var userType: String?
    while !loggedin {
        userType = login()
    }
    // This loop will run until the user decides to quit
    // It is where the bulk of the user decisions are made
    while loggedin && running {
        switch userType {
        case "1":
            runMember()
            break
        case "2":
            runOwner();
            break
        default:
            break
        }
    }
    
    // This is the final logout check where the user decides to quit or return to the original login
    print("Press 0 to quit\nPresss 1 to return to Login")
    let input = readLine()
    switch input {
    case "0":
        running = false
        break
    case "1":
        loggedin = false
        break
    default:
        break
    }
}
print("Thank you for visiting!")

// This function checks if the user wants to log in as a Member or an Owner and returns the answer
func login() -> String? {
    print("Welcome!\nPress 1 to login in as a Member.\nPress 2 to login in as an Owner.\nPress 0 to quit")
    let userType = readLine()
    loggedin = false
    switch userType {
    case "1":
        print("Please enter your name")
        let name = readLine()
        if (name == nil) {
            print("Please try again")
            break
        }
        member = Member(name: name!)
        loggedin = true
        break
    case "2":
        print("Welcome Owner")
        loggedin = true
        break
    case "0":
        loggedin = true
        running = false
        break
    default:
        print("Invalid Input")
        break
    }
    return userType
}

// This function contains all the choises presented to a Member of the Gym
func runMember() {
    print("Welcome \(member.getName()) - Current Credits: \(member.getBalance())")
    print("Would you like to...\n1: Reload Credits\n2: Search for a service\n3: Attend a session\n4: Cancel a service\n0: Log out")
    let input = readLine()
    switch input {
    case "1":
        print("How many credits would you like to load?")
        let credits = Int(readLine()!) ?? 0
        if (credits != 0) {
            member.addBalance(num: credits)
        }
        print("You now have \(String(describing: member.getBalance())) credits")
        break
    case "2":
        print("Please enter a key word to search")
        let keyword = readLine()
        let results = gym.search(keyword: keyword)
        if (results == nil || results?.count == 0) {
            print("Could not find anything.")
        } else {
            for i in 0...results!.count - 1 {

                print("Press \(i + 1) to sign up for \(results![i])")
            }
            print("Press 0 to return")
            let selection = Int(readLine()!) ?? 0
            if (selection != 0 && selection <= results!.count) {
                member.bookService(service: results![selection - 1])
            }
        }
        break
    case "3":
        let services = member.getBookedServices()
        print("Here are your currently booked services")
        if (services.count == 0) {
            print("You have nothing booked.")
            return
        }
        for i in 0...services.count - 1 {
            print("Press \(i + 1) to attend \(services[i])")
        }
        print("Press 0 to cancel")
        let serviceIndex = Int(readLine()!) ?? 0
        if (Int(serviceIndex) > 0 && Int(serviceIndex) <= services.count) {
            member.markAttendance(id: services[serviceIndex - 1].getId())
        }
        break
    case "4":
        let services = member.getBookedServices()
        print("Here are your currently booked services")
        if (services.count == 0) {
            print("You have nothing booked.")
            return
        }
        for i in 0...services.count - 1 {
            print("Press \(i + 1) to cancel \(services[i])")
        }
        print("Press 0 to return")
        let serviceInput = readLine()
        let serviceIndex = Int(serviceInput!) ?? 0
        if (Int(serviceIndex) > 0 || Int(serviceIndex) <= services.count) {
            member.cancelService(service: services[serviceIndex - 1])
        }
        break
    case "0":
        loggedin = false
        break
    default:
        break
    }
}

// This is the main function that runs when the user is an Owner
// It contains all the decions presented to an Owner
func runOwner() {
    print ("Would you like to...\n1: Create a new service\n2: Search for a service\n3: View all services\n0: Logout")
    let input = readLine()
    switch input {
    case "1":
        let service = createService()
        if (service == nil) {
            break
        }
        print(service!)
        print("Is this correct? 1: Yes 0: No")
        let answer = readLine()
        if (answer == "1") {
            gym.addService(service: service!)
        }
        break
    case"2":
        print("Please enter a key word to search")
        let keyword = readLine()
        let results = gym.search(keyword: keyword)
        if (results == nil || results?.count == 0) {
            print("Could not find anything.")
        } else {
            for service in results! {
                print(service)
            }
        }
        break
    case"3":
        gym.listServices()
        break
    case"0":
        loggedin = false
        break
    default:
        break
    }
}

// This function ask the user for all the necessary variables needed to create a new service then tries to create one
// If there is any bad input or the user changes their mind it will return nil
func createService() -> Service? {
    var service: Service?
    var id: String
    var name: String?
    var fee: Int
    var sessions: Int
    var activity: String?
    var trainer: String?
    var minutes: Int
    print("1: Create Fitness Class\n2: Create Personal Training\n0: Cancel")
    let input = readLine()
    switch input {
    case "1":
        print("Enter name")
        name = readLine()
        print("Enter fee")
        fee = Int(readLine()!) ?? 0
        print("Enter number of sessions")
        sessions = Int(readLine()!) ?? 0
        print("Enter activity")
        activity = readLine()
        id = createRandomId()
        if (name == nil || fee == 0 || sessions == 0 || activity == nil) {
            break
        }
        service = FitnessClass(id: id, name: name!, fee: fee, activity: activity!)
        print("Adding service")
        break
    case "2":
        print("Enter name")
        name = readLine()
        print("Enter fee")
        fee = Int(readLine()!) ?? 0
        print("Enter number of sessions")
        sessions = Int(readLine()!) ?? 0
        print("Enter Trainer")
        trainer = readLine()
        print("Enter Duration in minutes")
        minutes = Int(readLine()!) ?? 0
        id = createRandomId()
        if (name == nil || fee == 0 || sessions == 0 || trainer == nil || minutes == 0) {
            break
        }
        service = PersonalTraining(id: id, name: name!, fee: fee,  trainer: trainer!, durationMinutes: minutes)
        print("Adding service")
        break
    case "0":
        break
    default:
        break
    }
    
    return service
}

func createRandomId() -> String {
    return String(Int.random(in: 100000...999999))
}
