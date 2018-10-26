//
//  AdventurerTableViewController.swift
//  group18_assignment6
//
//  Created by Vadrevu, Anirudh S on 10/18/18.
//  Copyright © 2018 Vadrevu, Anirudh S. All rights reserved.
//

import UIKit
import CoreData

var adventurers: [NSManagedObject] = []

class AdventurerTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.register(AdventurerTableViewCell.self, forCellReuseIdentifier: "AdventurerTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let managedContext =
            appDelegate.managedObjectContext

        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Adventurer_attributes")
        var fetchedResults:[NSManagedObject]? = nil

        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        if let results = fetchedResults {
            adventurers = results
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return adventurers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AdventurerTableViewCell

        let adventurer = adventurers[indexPath.row]
        let name = adventurer.value(forKeyPath: "name") as! String
        let profession = adventurer.value(forKey: "profession") as? String
        let level = adventurer.value(forKey: "level") as? String
        let current_hitpoints = adventurer.value(forKey: "current_hitpoints") as! CVarArg
        let total_hitpoints = adventurer.value(forKey: "total_hitpoints") as! CVarArg
        let numerator: String = String(format: "%@", current_hitpoints)
        let denominator: String = String(format: "%@", total_hitpoints)

        let HP = numerator + "/" + denominator

        //let imageFile = adventurer.value(forKey: "image")
        cell.AdventurerNameLabel.numberOfLines = 0

        cell.AdventurerImageView.image = UIImage(named: "anime-character-1")
        cell.AdventurerNameLabel.text = "Name: \(name)"
        cell.AdventurerHPLabel.text = "HP: \(HP)"
        cell.AdventurerAttackLabel.text = "Attack: \(adventurer.value(forKey: "attack_multiplier") as? String)"
        cell.AdventurerTypeLabel.text = adventurer.value(forKey: "profession") as? String
        cell.AdventurerLevelLabel.text = level
        
        //       cell.textLabel?.text = "Name: \(name) \n Class: \(profession) \n Level: \(level) \n Attack: \(adventurer.value(forKey: "attack_multiplier") as? String) \n  HP: \(HP)"
        
        print("should have rendered")
        return cell
    }
//
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 180
        }else{
            return 181
        }
        }
//        let currentImage = images[0]
//        let imageCrop = currentImage.getCropRatio()
//        return tableView.frame.width / imageCrop
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIImage {
    func getCropRatio() -> CGFloat {
        let widthRatio = CGFloat(self.size.width / self.size.height)
        return widthRatio
    }
}
