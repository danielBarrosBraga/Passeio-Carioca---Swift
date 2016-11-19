//
//  PTuristicosCell.swift
//  projetoDeBloco - danielBraga
//
//  Created by TechReviews on 9/28/16.
//  Copyright © 2016 Braga.ltda. All rights reserved.
//

import UIKit

class PTuristicosCell: UITableViewCell {
    
    
    @IBOutlet var PTImageView: UIImageView!
    
    @IBOutlet var PTNameLabel: UILabel!
    
    @IBOutlet var PTDressLabel: UILabel!
    
    @IBOutlet var PTTipoLabel: UILabel!
    
    @IBOutlet var PTNotaLabel: UILabel!
    
    @IBOutlet var PTImage2View: UIImageView!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
