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
    
    let userDefault = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userDefault.string(forKey: "user_id"))
    }

    
    @IBAction func mainMenuClick(_ sender: UIButton) {
        switch sender{
        case koreanFoodButton:
            
            let marketVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MarketTableViewController") as! MarketTableViewController
            marketVC.category = "korean"
            marketVC.topTitle = "한식"
            self.navigationController?.pushViewController(marketVC, animated: true)
            
            break
        case chickenButton:
            
            let marketVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MarketTableViewController") as! MarketTableViewController
            marketVC.category = "chicken"
            marketVC.topTitle = "치킨"
            self.navigationController?.pushViewController(marketVC, animated: true)
            
            break
        case pizzaButton:
            
            let marketVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MarketTableViewController") as! MarketTableViewController
            marketVC.category = "pizza"
            marketVC.topTitle = "피자"
            self.navigationController?.pushViewController(marketVC, animated: true)
            
            break
        case hamburgerButton:
            
            let marketVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MarketTableViewController") as! MarketTableViewController
            marketVC.category = "night"
            marketVC.topTitle = "야식"
            self.navigationController?.pushViewController(marketVC, animated: true)
            
            break
            
        default:
            break
        }

    }

}
