//
//  MarketDetailViewController.swift
//  Hapdong
//
//  Created by 장한솔 on 2018. 6. 1..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MarketDetailViewController: UIViewController {
    
    
    @IBOutlet weak var menuBar: UIStackView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var reviewBtn: UIButton!
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var heartButton: UIBarButtonItem!
    
    let userDefault = UserDefaults.standard
    var myBookmarks = [String]()
    
    var store_name = ""
    var store_idx = 0
    
    @IBAction func menuAction(_ sender: UIButton) {
        updateView(selected: 0)
    }
    
    @IBAction func infoAction(_ sender: UIButton) {
        updateView(selected: 1)
    }

    @IBAction func reviewAction(_ sender: UIButton) {
        updateView(selected: 2)
    }
    
    private lazy var detailOfMenuViewController: DetailOfMenuViewController = {
        
        var viewController = storyboard?.instantiateViewController(withIdentifier: "DetailOfMenuViewController") as! DetailOfMenuViewController
        viewController.store_idx = self.store_idx
        
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var detailOfInfoViewController: DetailOfInfoViewController = {
        
        var viewController = storyboard?.instantiateViewController(withIdentifier: "DetailOfInfoViewController") as! DetailOfInfoViewController
        
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var detailOfReviewViewController: DetailOfReviewViewController = {
        
        var viewController = storyboard?.instantiateViewController(withIdentifier: "DetailOfReviewViewController") as! DetailOfReviewViewController
        viewController.store_idx = self.store_idx
        
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkBookmark()
        
        setupView()
    
        
        //네비게이션바 버튼 색깔
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        self.navigationItem.title = store_name
        
//        let tap1 = UITapGestureRecognizer(target: self, action: #selector(selectMenu1))
//        let tap2 = UITapGestureRecognizer(target: self, action: #selector(selectMenu2))
//        let tap3 = UITapGestureRecognizer(target: self, action: #selector(selectMenu3))
//        menuBtn.addGestureRecognizer(tap1)
//        infoBtn.addGestureRecognizer(tap2)
//        reviewBtn.addGestureRecognizer(tap3)
//
//        container.addSubview(detailOfMenuViewController.view)
        
        detailOfMenuViewController.view.frame = container.bounds
        detailOfMenuViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    @objc func selectMenu1(){
        menuBtn.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        infoBtn.titleLabel?.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        reviewBtn.titleLabel?.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        container.addSubview(detailOfMenuViewController.view)
        
    }
    
    @objc func selectMenu2(){
        menuBtn.titleLabel?.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        infoBtn.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        reviewBtn.titleLabel?.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        container.addSubview(detailOfInfoViewController.view)
        
    }
    
    @objc func selectMenu3(){
        menuBtn.titleLabel?.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        infoBtn.titleLabel?.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        reviewBtn.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        container.addSubview(detailOfReviewViewController.view)
        
    }
    
    @IBAction func heartButtonClick(_ sender: Any) {
        networkAddBookmark()
    }
    
    func networkAddBookmark(){
        let URL = "http://13.124.11.199:3000/bookmark/add"
        
        let body: [String: Any] = [
            "store_idx": "\(store_idx)",
            "user_id": userDefault.string(forKey: "user_id")!
        ]
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseData(){ res in
            switch res.result{
            case .success:
                if let value = res.result.value{
                    if JSON(value)["message"] == "insert bookmark succeed"{
                        self.showToast(message: "북마크에 추가되었습니다.")
                        self.heartButton.image = #imageLiteral(resourceName: "heart")
                    }
                }
                break
            case .failure(let err):
                print(err.localizedDescription)
                break
                
                
            }
            
            
        }
    }
    
    func checkBookmark(){
        let URL = "http://13.124.11.199:3000/bookmark/list/"+userDefault.string(forKey: "user_id")!
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData(){res in
            switch res.result{
            case .success:
                if let value = res.result.value{
                    
                    //print(JSON(value)["msg"])
                    if JSON(value)["msg"] == "Successfully get list"{
                        let decoder = JSONDecoder()
                        do {
                            let bookmarkListData = try decoder.decode(BookMarkListData.self, from: value)
                            for i in 0..<bookmarkListData.list.count{
                                self.myBookmarks.append(bookmarkListData.list[i].store_name)
                                // 내 북마크 담기
                            }
                            if self.myBookmarks.contains(self.store_name){
                                self.heartButton.image = #imageLiteral(resourceName: "heart")
                            }
                        }catch{
                            print("catch")
                        }
                    }
                    
                }
                
                break
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
        
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        container.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = container.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
    @objc private func updateView(selected : Int) {
        if selected == 0 {
            remove(asChildViewController: detailOfInfoViewController)
            remove(asChildViewController: detailOfReviewViewController)
            add(asChildViewController: detailOfMenuViewController)
        } else if selected == 1 {
            remove(asChildViewController: detailOfMenuViewController)
            remove(asChildViewController: detailOfReviewViewController)
            add(asChildViewController: detailOfInfoViewController)
        } else {
            remove(asChildViewController: detailOfMenuViewController)
            remove(asChildViewController: detailOfInfoViewController)
            add(asChildViewController: detailOfReviewViewController)
        }
    }
    
    func setupView() {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        updateView(selected: 0)
    }

    
}
