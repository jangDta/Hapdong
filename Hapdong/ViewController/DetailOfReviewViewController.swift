//
//  DetailOfReviewViewController.swift
//  Hapdong
//
//  Created by 장한솔 on 2018. 6. 1..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit

class DetailOfReviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func registerReviewClick(_ sender: Any) {
        performSegue(withIdentifier: "registerReviewSegue", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
