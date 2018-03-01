//
//  SignInViewController.swift
//  FirebasePratice
//
//  Created by CAUCSE on 2018. 3. 1..
//  Copyright © 2018년 mouda. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    let chatViewController = ViewController()
    
    func openChattingView() {
        performSegue(withIdentifier: "chattingRooms", sender: nil)
    }
    
    @IBAction func youButtonTapped(_ sender: Any) {
        FirebaseDataService.instance.signIn(withEmail: "youemail@naver.com", password: "123456") {
            self.openChattingView()
        }
    }
    
    @IBAction func meButtonTapped(_ sender: Any) {
        FirebaseDataService.instance.signIn(withEmail: "myemail@naver.com", password: "123456") {
            self.openChattingView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
