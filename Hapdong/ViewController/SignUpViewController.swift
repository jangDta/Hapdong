//
//  SignUpViewController.swift
//  Hapdong
//
//  Created by 장한솔 on 2018. 5. 21..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    var isReady : Bool {
        get{
            return !((idTextField.text?.isEmpty)!) && !((pwTextField.text?.isEmpty)!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션바 버튼 색깔
        self.navigationController?.navigationBar.tintColor = UIColor.black;

    }

    @IBAction func signUpClick(_ sender: Any) {
        if isReady{
            let URL = "http://13.124.11.199:3000/user/signup"
            let body: [String: Any] = [
                "user_id" : gsno(idTextField.text),
                "user_pw" : gsno(pwTextField.text)
            ]
            Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseData(){ res in
                switch res.result{
                case .success:
                    if let value = res.result.value{
                        if let message = JSON(value)["message"].string{
                            if message == "Successfully Sign Up"{
                                self.navigationController?.popViewController(animated: true)
                            }else if message == "Already Exists"{
                                let alertView = UIAlertController(title: "중복", message: "이미 존재하는 아이디입니다.", preferredStyle: .alert)
                                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                                alertView.addAction(ok)
                                self.present(alertView, animated: true, completion: nil)
                            }
                        }
                    }
                    
                    break
                case .failure(let err):
                    print("err......")
                    print(err.localizedDescription)
                    break
                }
            }
        }else{
            self.signUpButton.shake()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
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
