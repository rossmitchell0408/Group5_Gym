//
//  PersonalTraining.swift
//  Group5_Gym
//
//  Created by Ross Mitchell on 2025-05-15.
//

import Foundation

// TODO: Make personal training different from fitness
class PersonalTraining: Service {
    private var trainer: String
    private var durationMinutes: Int
    
    init(id: String, name: String, fee: Int, trainer: String, durationMinutes: Int) {
        self.trainer = trainer
        self.durationMinutes = durationMinutes
        super.init(id: id, name: name, fee: fee)
    }
}
