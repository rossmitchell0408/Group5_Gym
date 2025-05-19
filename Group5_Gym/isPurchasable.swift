//
//  isPurchasable.swift
//  Group5_Gym
//
//  Created by Ash Bisol on 2025-05-18.
//

import Foundation

protocol isPurchasable {
    var description: String { get }
    func printReceipt(status: serviceStatus) -> String
}
