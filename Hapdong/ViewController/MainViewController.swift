//
//  MainViewController.swift
//  Hapdong
//
//  Created by 장한솔 on 2018. 5. 21..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var koreanFoodButton: UIButton!
    @IBOutlet weak var chickenButton: UIButton!
    @IBOutlet weak var pizzaButton: UIButton!
    @IBOutlet weak var hamburgerButton: UIButton!
    var selectedMenu = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func mainMenuClick(_ sender: UIButton) {
        switch sender{
        case koreanFoodButton:
            selectedMenu = "한식"
            break
        case chickenButton:
            selectedMenu = "치킨"
            break
        case pizzaButton:
            selectedMenu = "피자"
            break
        case hamburgerButton:
            selectedMenu = "햄버거"
            break
        default:
            break
        }
        performSegue(withIdentifier: "selectMenuSegue", sender: self)
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MarketTableViewController{
            destination.navigationItem.title = selectedMenu
        }
    }
   

}
