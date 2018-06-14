//
//  DetailOfReviewTableViewCell.swift
//  Hapdong
//
//  Created by 김예은 on 2018. 6. 2..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit

class DetailOfReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var writeTimeLabel: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
