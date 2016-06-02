//
//  BarTableViewCell.swift
//  Appartoo
//
//  Created by chris 78 on 01/06/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

import UIKit

class BarTableViewCell: UITableViewCell
{

    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
