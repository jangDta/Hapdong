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
        cell.reviewNumLabel.text = "최근리뷰 \(lists[indexPath.row].review_cnt)"
        cell.marketImageView.kf.setImage(with: URL(string: lists[indexPath.row].store_img),placeholder: UIImage())

        return cell
    }

    //TODO: 다음 뷰 인텐트로 넘기기
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
    func listInit() {
            let URL = "http://13.124.11.199:3000/main/list/\(category)"
        
            Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData() { res in
                switch res.result {
                    case .success:
        
                        if let value = res.result.value {
        
                            print("ㅇㄹㅇㄴㄹ\(JSON(value)["myPosts"][0].string)")
                            let decoder = JSONDecoder()
        
                            do {
                                let listData = try decoder.decode(ListData.self, from: value)
        
                                if listData.message == "Successfully get list" {
                                    print("성공!")
                                    self.lists = listData.myPosts //디코드해서 받아온 데이터
                                    self.tableView.reloadData()
                                }
        
                            } catch {
        
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
