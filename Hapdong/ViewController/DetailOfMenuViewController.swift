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
    var store_idx = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션바 버튼 색깔
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        
        tableView.delegate = self
        tableView.dataSource = self
        print("-----------store idx : \(store_idx)----------")
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
        let URL = "http://13.124.143.2:3011/store/menulist/\(store_idx)"
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData(){res in
            switch res.result{
            case .success:
                if let value = res.result.value{
                    print("---------------0-----------------")
                    
                    if JSON(value)["message"] == "no menu"{
                        print("no menu")
                    }else{
                        print(JSON(value)["result"])
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
