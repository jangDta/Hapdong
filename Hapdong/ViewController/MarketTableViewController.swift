//
//  MarketTableViewController.swift
//  Hapdong
//
//  Created by 장한솔 on 2018. 6. 1..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

class MarketTableViewController: UITableViewController {
    
    var lists: [List] = [List]()
    
    var category: String = ""
    var topTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listInit()
        print(category)
        
        //네비게이션바 버튼 색깔
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        
        self.navigationItem.title = topTitle
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.reuseIdentifier, for: indexPath) as! MarketTableViewCell
        
        cell.marketNameLabel.text = lists[indexPath.row].store_name
        cell.reviewNumLabel.text = String(lists[indexPath.row].review_cnt)
        
        cell.marketImageView.kf.setImage(with: URL(string: lists[indexPath.row].store_img),placeholder: UIImage())
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //TODO: 다음 뷰 인텐트로 넘기기
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let datailVC = storyboard?.instantiateViewController(withIdentifier: MarketDetailViewController.reuseIdentifier) as! MarketDetailViewController
        datailVC.store_name = lists[indexPath.row].store_name
        datailVC.store_idx = lists[indexPath.row].store_idx
        self.navigationController?.pushViewController(datailVC, animated: true)
    }
    
    func listInit() {
        let URL = "http://13.124.11.199:3000/main/list/"+category
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData() { res in
            switch res.result {
            case .success:
                
                if let value = res.result.value {
                    
                    //print(JSON(value)["myPosts"])
                    let decoder = JSONDecoder()
                    
                    do {
                        let listData = try decoder.decode(ListData.self, from: value)
                        
                        if listData.message == "Successfully get list" {
                            self.lists = listData.myPosts
                            self.tableView.reloadData()
                        }
                        
                    } catch {
                        print("catch")
                        
                    }
                }
                
                break
                
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
    }
    
    
    @IBAction func registerMarketClick(_ sender: Any) {
        performSegue(withIdentifier: "registerMarketSegue", sender: self)
    }
    
    
}
