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
    var bookmarks = [BookMarkList]()
    
    
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
        print("length :\(bookmarks.count)")
    
        
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
        print("heart!!")
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
                    print("---------------0-----------------")
                    
                    print(JSON(value)["msg"])
                    if JSON(value)["msg"] == "Successfully get list"{
                        let decoder = JSONDecoder()
                        do {
                            print("----------------1-----------------")
                            let bookmarkListData = try decoder.decode(BookMarkListData.self, from: value)
                            self.bookmarks = bookmarkListData.list
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
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
