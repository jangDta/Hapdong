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
    
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var heartButton: UIBarButtonItem!
    
    let userDefault = UserDefaults.standard
    var myBookmarks = [String]()
    
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
        
        checkBookmark()
        
        
    
        
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
    
}
