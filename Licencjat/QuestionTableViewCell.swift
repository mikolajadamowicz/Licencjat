//
//  QuestionTableViewCell.swift
//  Licencjat
//
//  Created by Mikolaj Adamowicz on 04.06.2018.
//  Copyright © 2018 Mikolaj Adamowicz. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    //    MARK:Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var forLabel: UILabel!
    @IBOutlet weak var againstLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
