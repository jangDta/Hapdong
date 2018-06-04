//
//  BookMarkTableViewController.swift
//  Hapdong
//
//  Created by 장한솔 on 2018. 6. 1..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class BookMarkTableViewController: UITableViewController {

    var bookmarks: [BookMarkList] = [BookMarkList]()
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookMarkListInit()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return bookmarks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookMarkTableViewCell.reuseIdentifier, for: indexPath) as! BookMarkTableViewCell
        
        cell.marketNameLabel.text = bookmarks[indexPath.row].store_name
        cell.marketImageView.kf.setImage(with: URL(string: bookmarks[indexPath.row].store_img),placeholder: UIImage())
        cell.reviewNumLabel.text = bookmarks[indexPath.row].reviewCnt

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
 
    func bookMarkListInit() {
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
                            self.tableView.reloadData()
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
