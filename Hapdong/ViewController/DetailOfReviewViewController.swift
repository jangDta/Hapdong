//
//  DetailOfReviewViewController.swift
//  Hapdong
//
//  Created by 장한솔 on 2018. 6. 1..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class DetailOfReviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var store_idx = 0
    @IBOutlet weak var tableView: UITableView!
    var reviews = [ReviewList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션바 버튼 색깔
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        networkReview()
        print(reviews.count)

    }

    @IBAction func registerReviewClick(_ sender: Any) {
        performSegue(withIdentifier: "registerReviewSegue", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailOfReviewTableViewCell.reuseIdentifier) as! DetailOfReviewTableViewCell
        cell.reviewImageView.kf.setImage(with: URL(string: reviews[indexPath.row].review_img),placeholder: UIImage())
        cell.reviewTextView.text = reviews[indexPath.row].review_content
        cell.writeTimeLabel.text = reviews[indexPath.row].review_writetime
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func networkReview(){
        let URL = "http://13.124.11.199:3000/store/review/\(store_idx)"
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData(){res in
            switch res.result{
            case .success:
                if let value = res.result.value{
                    print("---------------0리뷰-----------------")
                    
                    print(JSON(value)["result"])
                    let decoder = JSONDecoder()
                    do {
                        print("----------------1리뷰-----------------")
                        let reviewListData = try decoder.decode(ReviewListData.self, from: value)
                        self.reviews = reviewListData.result
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
    
    

}
