//
//  BookMarkTableViewCell.swift
//  Hapdong
//
//  Created by 김예은 on 2018. 6. 2..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit

class BookMarkTableViewCell: UITableViewCell {
    @IBOutlet weak var marketImageView: UIImageView!
    @IBOutlet weak var marketNameLabel: UILabel!
    @IBOutlet weak var reviewNumLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        marketImageView.layer.cornerRadius = marketImageView.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
