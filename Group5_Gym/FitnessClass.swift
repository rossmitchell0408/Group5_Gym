//
//  FitnessClass.swift
//  Group5_Gym
//
//  Created by Ross Mitchell on 2025-05-15.
//

import Foundation

class FitnessClass: Service {
    private var activity: String
    
    init(id: String, name: String, fee: Int, sessions: Int = 7, activity: String) {
        self.activity = activity
        super.init(id: id, name: name, fee: fee, sessions: sessions, type: "Fitness")
        let keywords = activity.components(separatedBy: " ")
        for keyword in keywords {
            super.addKeyword(keyword: keyword)
        }
    }
}
