//
//  Adventurer.swift
//  group18_assignment6
//
//  Created by Vadrevu, Anirudh S on 10/18/18.
//  Copyright © 2018 Vadrevu, Anirudh S. All rights reserved.
//

class Adventurer {
    var name: String
    var level: Int
    var type: String
    var attack: Float
    var hp: Int
    
    // constructor
    init(name: String, level: Int, type: String, attack: Float, hp: Int){
        self.name = name
        self.level = level
        self.type = type
        self.attack = attack
        self.hp = hp
    }
}
