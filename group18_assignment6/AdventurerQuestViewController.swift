//
//  AdventurerQuestViewController.swift
//  group18_assignment6
//
//  Created by Manciu, Bianca M on 10/25/18.
//  Copyright © 2018 Vadrevu, Anirudh S. All rights reserved.
//

import UIKit
import CoreData



class AdventurerQuestViewController: UIViewController {
    
    var index_row: Int = 0
    var enemies_killed:Int = 0
    var turns_taken:Int = 0
    var monster_damage_taken:Int = 0
    var current_hp: Int = 0
    var total_hp: Int = 0
    var ad_level: Int = 0

    @IBOutlet weak var CharacterNameUILabel: UILabel!
    @IBOutlet weak var ClassNameUILabel: UILabel!
    @IBOutlet weak var AttackPowerUILabel: UILabel!
    @IBOutlet weak var HpUILabel: UILabel!
    @IBOutlet weak var LevelUILabel: UILabel!
    @IBOutlet weak var AdventurerImageView: UIImageView!
    
    @IBOutlet weak var QuestLogTextView: UITextView!
    
    var playertimer = Timer()
    var enemytimer = Timer()
    var quest_text = "Beginning quest... \n"
    
    @IBAction func EndQuestButtonAction(_ sender: Any) {
        playertimer.invalidate()
        enemytimer.invalidate()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let adventurer = adventurers[index_row]
        let name = adventurer.value(forKeyPath: "name") as! String
        let profession = adventurer.value(forKey: "profession") as! String
        let level = adventurer.value(forKey: "level") as! CVarArg
        let current_hitpoints = adventurer.value(forKey: "current_hitpoints") as! CVarArg
        let total_hitpoints = adventurer.value(forKey: "total_hitpoints") as! CVarArg
        let attack_pre = adventurer.value(forKey: "attack_multiplier") as! CVarArg
        let numerator: String = String(String(format: "%@", current_hitpoints).prefix(5))
        let denominator: String = String(String(format: "%@", total_hitpoints).prefix(5))
        let attack: String = String(String(format: "%@", attack_pre).prefix(4))
        let picture_name = adventurer.value(forKey: "portrait") as? String
        let level_string: String = String(format: "%@", level)
        // let HP = numerator + "/" + denominator
        
        
        current_hp = Int(numerator)!
        total_hp = Int(denominator)!
        ad_level = Int(level_string)! + 1
        
        ClassNameUILabel.text = "Class: \(profession)"
        CharacterNameUILabel.text = "Name: \(name)"
        AttackPowerUILabel.text = attack
        AdventurerImageView.image = UIImage(named: picture_name!)
        LevelUILabel.text = level_string 
        
        enemytimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(enemy), userInfo: nil, repeats: true)
        playertimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(player), userInfo: nil, repeats: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        QuestLogTextView.text = quest_text
        HpUILabel.text = "\(current_hp) / \(total_hp)"
    }
    
    
    
    @objc func player() {
        let adventurer = adventurers[index_row]
        let name = adventurer.value(forKeyPath: "name") as! String
        let attack_pre = adventurer.value(forKey: "attack_multiplier") as! Float
        var attack_points  = Int(arc4random_uniform(10))
        attack_points = Int(Float(attack_points) * attack_pre)
        monster_damage_taken = monster_damage_taken + attack_points
    
        quest_text += name + " attacks for " + String(attack_points) + " damage \n"
        QuestLogTextView.text = quest_text
        turns_taken += 1
    }
    
    @objc func enemy() {
        let damage = Int(arc4random_uniform(15))
        var enemy_actions_list = ["The monster is waiting...", "The monster attacks for \(damage) damage.", "Enemy is defeated!", "A new enemy appears!"]
        if turns_taken == 0 {
            quest_text += enemy_actions_list[3]
            quest_text += "\n"
            
        }else if monster_damage_taken <= 100{
            let random_attack = arc4random_uniform(2)
            if random_attack == 1{
                if current_hp <= 5 {
                    current_hp = 0
                    quest_text += "You died!"
                    playertimer.invalidate()
                    enemytimer.invalidate()
                } else {
                    current_hp -= damage
                    quest_text += enemy_actions_list[1]
                    quest_text += "\n"
                }
                
            } else{
                quest_text += enemy_actions_list[0]
                quest_text += "\n"
            }
        }else if monster_damage_taken > 100{
            let adventurer = adventurers[index_row]
            
            adventurer.setValue(ad_level, forKey: "level")
            quest_text += enemy_actions_list[2]
            enemies_killed += 1
            quest_text += "\n"
            monster_damage_taken = 0
            quest_text += enemy_actions_list[3]
            quest_text += "\n"
        }
        
        QuestLogTextView.text = quest_text
        viewWillAppear(true)
        turns_taken += 1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    /*
     
     // MARK: - Navigation
     
     
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     // Get the new view controller using segue.destinationViewController.
     
     // Pass the selected object to the new view controller.
     
     }
     
     */
 
}
