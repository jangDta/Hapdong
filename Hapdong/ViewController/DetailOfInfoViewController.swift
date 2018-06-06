//
//  DetailOfInfoViewController.swift
//  Hapdong
//
//  Created by 장한솔 on 2018. 6. 1..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit

class DetailOfInfoViewController: UIViewController {

    @IBOutlet weak var marketImageView: UIImageView!
    @IBOutlet weak var reviewNumLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //네비게이션바 버튼 색깔
        self.navigationController?.navigationBar.tintColor = UIColor.black;
    }


}
