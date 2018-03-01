//
//  UserListViewController.swift
//  FirebasePratice
//
//  Created by CAUCSE on 2018. 3. 1..
//  Copyright © 2018년 mouda. All rights reserved.
//

import UIKit

class UserListViewController: UITableViewController {

    var chatGroupVC: ChatGroupViewController?
    var userList: [User] = []
    
    func fetchUserList() {
        FirebaseDataService.instance.userRef.observeSingleEvent(of: .value, with: {(snapshot) in
            if let data = snapshot.value as? Dictionary<String, AnyObject>, let uid = FirebaseDataService.instance.currentUserUid {
                for (key, data) in data {
                    if uid != key {
                        if let userData = data as? Dictionary<String, AnyObject> {
                            let username = userData["name"] as! String
                            let email = userData["email"] as! String
                            let user = User(uid: uid, email: email, username: username)
                            self.userList.append(user)
                            
                            DispatchQueue.main.async(execute: {
                                self.tableView.reloadData()
                            })
                        }
                    }
                }
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserList()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ref = FirebaseDataService.instance.groupRef.childByAutoId()
        ref.child("name").setValue(userList[indexPath.row].username as String)
        dismiss(animated: true) {
            if let chatGroupVC = self.chatGroupVC {
                chatGroupVC.performSegue(withIdentifier: "chatting", sender: ref.key)
            }
        }
        return
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.textLabel?.text = userList[indexPath.row].username
        cell.detailTextLabel?.text = userList[indexPath.row].email
        return cell
    }
    
    
}
