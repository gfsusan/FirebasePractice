//
//  ViewController.swift
//  FirebasePratice
//
//  Created by CAUCSE on 2018. 3. 1..
//  Copyright © 2018년 mouda. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                FirebaseDataService.instance.signIn(withEmail: email, password: password) {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
  
    @IBAction func forgotButtonPressed(_ sender: Any) {
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
