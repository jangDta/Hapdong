//
//  DetailOfMenuViewController.swift
//  Hapdong
//
//  Created by 장한솔 on 2018. 6. 1..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailOfMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var menuList : [StoreMenu]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션바 버튼 색깔
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        
        tableView.delegate = self
        tableView.dataSource = self
        networkMenu()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let menus = menuList{
            return menus.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailOfMenuTableViewCell") as! DetailOfMenuTableViewCell
        
        if let menus = menuList{
            cell.menuNameLabel.text = menus[indexPath.row].menu_name
            cell.menuPriceLabel.text = menus[indexPath.row].menu_info
        }
        
        return cell
    }
    
    func networkMenu(){
        let URL = "http://13.124.11.199:3000/store/menulist/14"
        let header = [
            "store_idx" : "14"
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData(){res in
            switch res.result{
            case .success:
                print("suceess")
                if let value = res.result.value{
                    print("---------------0-----------------")
                    
                    print(JSON(value)["result"])
                    print(JSON(value)["result"][0])
                    let decoder = JSONDecoder()
                    do {
                        print("----------------1-----------------")
                        let storeMenuData = try decoder.decode(StoreMenuData.self, from: value)
                        self.menuList = storeMenuData.result
                        self.tableView.reloadData()
                    }catch{
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

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
