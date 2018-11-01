//
//  AdventurerTableViewCell.swift
//  group18_assignment6
//
//  Created by Manciu, Bianca M on 10/25/18.
//  Copyright © 2018 Vadrevu, Anirudh S. All rights reserved.
//

import UIKit

class AdventurerTableViewCell: UITableViewCell {

    @IBOutlet weak var AdventurerImageView: UIImageView!
    @IBOutlet weak var AdventurerNameLabel: UILabel!
    @IBOutlet weak var AdventurerTypeLabel: UILabel!
    @IBOutlet weak var AdventurerAttackLabel: UILabel!
    @IBOutlet weak var AdventurerHPLabel: UILabel!
    @IBOutlet weak var AdventurerLevelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    

}
