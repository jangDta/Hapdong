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
    private lazy var detailOfMenuViewController: DetailOfMenuViewController = {
       
        var viewController = storyboard?.instantiateViewController(withIdentifier: "DetailOfMenuViewController") as! DetailOfMenuViewController
        
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
        
        self.addChildViewController(viewController)
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션바 버튼 색깔
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(selectMenu1))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(selectMenu2))
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(selectMenu3))
        menuLabel.addGestureRecognizer(tap1)
        infoLabel.addGestureRecognizer(tap2)
        reviewLabel.addGestureRecognizer(tap3)
        
        container.addSubview(detailOfMenuViewController.view)
        
    }
    @objc func selectMenu1(){
        container.addSubview(detailOfMenuViewController.view)
        
    }

    @objc func selectMenu2(){
        container.addSubview(detailOfInfoViewController.view)
        
    }

    @objc func selectMenu3(){
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
