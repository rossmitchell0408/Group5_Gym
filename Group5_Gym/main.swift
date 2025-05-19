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

var testPersonal = PersonalTraining(id:"A1",name:"Pers",fee:105,trainer:"Tim", durationMinutes:50)
var testFitness = FitnessClass(id:"B2",name:"Fitness",fee:102,activity:"Swim Class")
var testMember = Member(name: "Ben", balance: 1000)

var testGym = Gym()

testGym.listServices()

testGym.addService(service: testPersonal)
testGym.addService(service: testFitness)

testGym.listServices()

testMember.bookService(service: testFitness)
testMember.cancelService(service: testFitness)
testMember.bookService(service: testPersonal)
testMember.bookService(service: testPersonal)
testMember.markAttendance(id: testPersonal.getId())
testMember.markAttendance(id: testPersonal.getId())
testMember.markAttendance(id: testPersonal.getId())
testMember.cancelService(service: testPersonal)

print(testFitness.getKeywords())
