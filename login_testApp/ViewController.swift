//
//  ViewController.swift
//  login_testApp
//
//  Created by Maxim Mitin on 30.01.22.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, LoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let token = AccessToken.current, !token.isExpired {
            let token = token.tokenString
            
            let reuqest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields":"email, name"],
                                                     tokenString: token, version: nil,
                                                     httpMethod: .get)
            
            reuqest.start(completion: {connection,results,error in
                print("\(results)")
            })
        } else {
            let loginButton = FBLoginButton()
            loginButton.delegate = self
            loginButton.permissions = ["public_profile", "email, name"]
            view.addSubview(loginButton)
        }
        
    }

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        
        let reuqest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields":"email"],
                                                 tokenString: token, version: nil,
                                                 httpMethod: .get)
        
        reuqest.start(completion: {connection,results,error in
            print("\(results)")
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }

}

