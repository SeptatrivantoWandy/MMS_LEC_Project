//
//  ExerciseTableViewCell.swift
//  MMS_LEC_Project
//
//  Created by Septatrivanto Wandy on 22/12/21.
//  Copyright © 2021 Septatrivanto Wandy. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    
    // insert outlet-outletnya
    
    @IBOutlet weak var imgExercise: UIImageView!
    @IBOutlet weak var lblExerciseRestNominal: UILabel!
    @IBOutlet weak var lblExerciseRoundNominal: UILabel!
    @IBOutlet weak var lblExerciseName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
