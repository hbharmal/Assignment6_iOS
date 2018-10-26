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

    @IBOutlet weak var CharacterNameUILabel: UILabel!
    @IBOutlet weak var ClassNameUILabel: UILabel!
    @IBOutlet weak var AttackPowerUILabel: UILabel!
    @IBOutlet weak var HpUILabel: UILabel!
    @IBOutlet weak var LevelUILabel: UILabel!
    
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
        let profession = adventurer.value(forKey: "profession") as? String
        let level = adventurer.value(forKey: "level") as? String
        print(level)
        let current_hitpoints = adventurer.value(forKey: "current_hitpoints") as! CVarArg
        let total_hitpoints = adventurer.value(forKey: "total_hitpoints") as! CVarArg
        let attack_pre = adventurer.value(forKey: "attack_multiplier") as! CVarArg
        let numerator: String = String(String(format: "%@", current_hitpoints).prefix(5))
        let denominator: String = String(String(format: "%@", total_hitpoints).prefix(5))
        let attack: String = String(String(format: "%@", attack_pre).prefix(4))
        let HP = numerator + "/" + denominator
        
        ClassNameUILabel.text = "Class: \(profession)"
        CharacterNameUILabel.text = "Name: \(name)"
        AttackPowerUILabel.text = attack
        HpUILabel.text = HP
        LevelUILabel.text = level
        
        playertimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(player), userInfo: nil, repeats: true)
        enemytimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(enemy), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        QuestLogTextView.text = quest_text
    }
    
    @objc func player() {
        quest_text += "fuck yeah \n"
        QuestLogTextView.text = quest_text
    }
    
    @objc func enemy() {
        quest_text += "oh no \n"
        QuestLogTextView.text = quest_text
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
