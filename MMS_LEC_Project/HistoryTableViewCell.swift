//
//  HistoryTableViewCell.swift
//  MMS_LEC_Project
//
//  Created by Septatrivanto Wandy on 22/12/21.
//  Copyright © 2021 Septatrivanto Wandy. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    
    //Insert outlet-outletnya table view cellnya
    
    @IBOutlet weak var lblHistoryName: UILabel!
    @IBOutlet weak var imgHistory: UIImageView!
    @IBOutlet weak var lblHistoryRepititionNominal: UILabel!
    @IBOutlet weak var lblCalBurnedNominal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
