//
//  DetailOfMenuTableViewCell.swift
//  Hapdong
//
//  Created by 김예은 on 2018. 6. 2..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit

class DetailOfMenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var menuNameLabel: UILabel!
    @IBOutlet weak var menuPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
