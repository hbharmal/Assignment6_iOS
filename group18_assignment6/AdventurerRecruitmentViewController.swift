//
//  AdventurerRecruitmentViewController.swift
//  group18_assignment6
//
//  Created by Manciu, Bianca M on 10/25/18.
//  Copyright © 2018 Vadrevu, Anirudh S. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class AdventurerRecruitmentViewController: UIViewController {
    
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var ClassTextField: UITextField!
    var portrait: UIImage? = nil
    
    @IBAction func AdventurerSaveAction(_ sender: Any) {
        let name: String = NameTextField.text!
        let profession: String = ClassTextField.text!
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Adventurer_attributes", in: managedContext)
        
        let adventurer = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        let hitpoints: Int32 = Int32(arc4random_uniform(120))
        var level: Int32 = 1
        let attack_multiplier: Float = Float(drand48() * 5)
        
        adventurer.setValue(name, forKeyPath: "name")
        adventurer.setValue(profession, forKey: "profession")
        adventurer.setValue(Int32(1), forKey: "level")
        adventurer.setValue(hitpoints, forKey: "total_hitpoints")
        adventurer.setValue(hitpoints, forKey: "current_hitpoints")
        adventurer.setValue(attack_multiplier, forKey: "attack_multiplier")
        
        do {
            try managedContext.save()
            print("Saved")
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
