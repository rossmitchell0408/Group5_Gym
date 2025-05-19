//
//  main.swift
//  Group5_Gym
//
//  Created by Ross Mitchell on 2025-05-15.
//

/* TODO - probably standardize class/course/service, this is entirely my bad
            ill go through and clean things up later
 */

import Foundation

print("Group5_Gym")

var testPersonal = PersonalTraining(id:"A1",name:"Pers",fee:105,trainer:"Tim", durationMinutes:50)
var testFitness = FitnessClass(id:"B2",name:"Fitness",fee:102,trainer:"Jim", durationMinutes:60)
var testMember = Member(name: "Ben", id: "M103")

var testGym = Gym()

testGym.listServices()

testGym.addService(service: testPersonal)
testGym.addService(service: testFitness)

testGym.listServices()
