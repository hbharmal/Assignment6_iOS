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
    var count: Int = 0
    
    var picuture_index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.register(AdventurerTableViewCell.self, forCellReuseIdentifier: "AdventurerTableViewCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? AdventurerQuestViewController {
            if let cell = sender as? UITableViewCell,
                let indexPath = self.tableView.indexPath(for: cell) {
                destinationViewController.index_row = indexPath.row
            }
        }
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
            count = adventurers.count
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        if let results = fetchedResults {
            adventurers = results
        }
        count = adventurers.count
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
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AdventurerTableViewCell

        let adventurer = adventurers[indexPath.row]
        let name = adventurer.value(forKeyPath: "name") as! String
//        let profession = adventurer.value(forKey: "profession") as? String
        let level = adventurer.value(forKey: "level") as! CVarArg
        let current_hitpoints = adventurer.value(forKey: "current_hitpoints") as! CVarArg
        let total_hitpoints = adventurer.value(forKey: "total_hitpoints") as! CVarArg
        let attack_pre = adventurer.value(forKey: "attack_multiplier") as! CVarArg
        let numerator: String = String(String(format: "%@", current_hitpoints).prefix(5))
        let denominator: String = String(String(format: "%@", total_hitpoints).prefix(5))
        let attack: String = String(String(format: "%@", attack_pre).prefix(4))
        print(attack)
        let picture_name = adventurer.value(forKey: "portrait") as? String
        let HP = numerator + "/" + denominator
        let level_string: String = String(format: "%@", level)

        //let imageFile = adventurer.value(forKey: "image")
        cell.AdventurerNameLabel.numberOfLines = 0

        cell.AdventurerImageView.image = UIImage(named: picture_name!)
        cell.AdventurerNameLabel.text = "Name: \(name)"
        cell.AdventurerHPLabel.text = "HP: \(HP)"
        cell.AdventurerAttackLabel.text = "Attack:  \(attack)"
        cell.AdventurerTypeLabel.text = adventurer.value(forKey: "profession") as? String
        cell.AdventurerLevelLabel.text = "Level:  \(level_string)"
        return cell
    }
//
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 180
        } else {
            return 181
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let del_adv = adventurers[indexPath.row]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            managedContext.delete(del_adv)
            
            do {
                try managedContext.save()
                print("Saved")
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            count -= 1
            tableView.reloadData()
    }
    }
    
    }


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

extension UIImage {
    func getCropRatio() -> CGFloat {
        let widthRatio = CGFloat(self.size.width / self.size.height)
        return widthRatio
    }
}
