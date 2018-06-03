//
//  ViewController.swift
//  Hapdong
//
//  Created by 장한솔 on 2018. 5. 21..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignInViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    let userdefault = UserDefaults.standard
    var isReady : Bool {
        get{
            return !((idTextField.text?.isEmpty)!) && !((pwTextField.text?.isEmpty)!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func signInClick(_ sender: Any) {
        if isReady{
            let URL = "http://13.124.11.199:3000/user/signin"
            let body: [String: Any] = [
                "user_id" : gsno(idTextField.text),
                "user_pw" : gsno(pwTextField.text)
            ]
            
            Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseData(){ res in
                switch res.result{
                case .success:
                    if let value = res.result.value{
                        if let message = JSON(value)["message"].string{
                            if message == "Login Success"{
                                self.userdefault.set(body["user_id"], forKey: "user_id")
                                if let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVCTab") as? UITabBarController {
                                    self.present(mainVC, animated: true, completion: nil)
                                }
                            }else{
                                let alertView = UIAlertController(title: "로그인 실패", message: "아이디와 비밀번호를 확인해주세요", preferredStyle: .alert)
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
            self.signInButton.shake()
        }
        
    }
    
    
    @IBAction func signUpClick(_ sender: Any) {
        if let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController{
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    

}

