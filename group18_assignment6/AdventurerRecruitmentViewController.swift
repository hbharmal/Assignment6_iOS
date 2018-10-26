//
//  AdventurerRecruitmentViewController.swift
//  group18_assignment6
//
//  Created by Manciu, Bianca M on 10/25/18.
//  Copyright © 2018 Vadrevu, Anirudh S. All rights reserved.
//

import UIKit
import CoreData

class AdventurerRecruitmentViewController: UIViewController {
    
    var adventurers: [NSManagedObject] = []
    
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var ClassTextField: UITextField!
    
    // Save adventurer here
    @IBAction func AdventurerSaveAction(_ sender: Any) {
        
        let name: String = NameTextField.text!
        let class_name: String = ClassTextField.text!
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Adventurer_entities", in: managedContext)!
        
        let adventurer = NSManagedObject(entity: entity, insertInto: managedContext)
        
        adventurer.setValue(name, forKeyPath: "name")
        adventurer.setValue(class_name, forKey: "profession")
        
        do {
            try managedContext.save()
            adventurers.append(adventurer)
        } catch let error as NSError {
            print("Could not save, try again")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
