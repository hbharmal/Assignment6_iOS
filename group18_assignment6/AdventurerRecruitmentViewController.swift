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

var images = [
    "anime-character-1", "anime-character-2", "anime-character-3"
]

class AdventurerRecruitmentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "picture_cell", for: indexPath) as! ImagesCollectionViewCell
        cell.imageView.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("sdfsdf")
        let cell = collectionView.cellForItem(at: indexPath) as! ImagesCollectionViewCell
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.gray.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("sdfsdf")
        let cell = collectionView.cellForItem(at: indexPath) as! ImagesCollectionViewCell
        cell.layer.borderWidth = 0
        cell.layer.borderColor = nil 
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true 
    }
    
    
    
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
//        self.ImagesCollection.delegate = self
//        self.ImagesCollection.dataSource = self
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
