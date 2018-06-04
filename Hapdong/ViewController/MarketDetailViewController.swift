//
//  MarketDetailViewController.swift
//  Hapdong
//
//  Created by 장한솔 on 2018. 6. 1..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit

class MarketDetailViewController: UIViewController {

    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var container: UIView!
    
    var store_name = ""
    var store_idx = 0
    
    private lazy var detailOfMenuViewController: DetailOfMenuViewController = {
       
        var viewController = storyboard?.instantiateViewController(withIdentifier: "DetailOfMenuViewController") as! DetailOfMenuViewController
        viewController.store_idx = self.store_idx
        
        self.addChildViewController(viewController)
        return viewController
    }()
    
    private lazy var detailOfInfoViewController: DetailOfInfoViewController = {
        
        var viewController = storyboard?.instantiateViewController(withIdentifier: "DetailOfInfoViewController") as! DetailOfInfoViewController
        
        self.addChildViewController(viewController)
        return viewController
    }()
    
    private lazy var detailOfReviewViewController: DetailOfReviewViewController = {
        
        var viewController = storyboard?.instantiateViewController(withIdentifier: "DetailOfReviewViewController") as! DetailOfReviewViewController
        viewController.store_idx = self.store_idx
        
        self.addChildViewController(viewController)
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션바 버튼 색깔
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        self.navigationItem.title = store_name
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(selectMenu1))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(selectMenu2))
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(selectMenu3))
        menuLabel.addGestureRecognizer(tap1)
        infoLabel.addGestureRecognizer(tap2)
        reviewLabel.addGestureRecognizer(tap3)
        
        container.addSubview(detailOfMenuViewController.view)
        
    }
    @objc func selectMenu1(){
        menuLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        infoLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        reviewLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        container.addSubview(detailOfMenuViewController.view)
        
    }

    @objc func selectMenu2(){
        menuLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        infoLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        reviewLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        container.addSubview(detailOfInfoViewController.view)
        
    }

    @objc func selectMenu3(){
        menuLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        infoLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        reviewLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        container.addSubview(detailOfReviewViewController.view)
        
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
