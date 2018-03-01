//
//  ChatGroupViewController.swift
//  FirebasePratice
//
//  Created by CAUCSE on 2018. 3. 1..
//  Copyright © 2018년 mouda. All rights reserved.
//

import UIKit

class ChatGroupViewController: UITableViewController {

    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchChatGroupList()
    }

    func fetchChatGroupList() {
        if let uid = FirebaseDataService.instance.currentUserUid {
            FirebaseDataService.instance.userRef.child(uid).child("groups").observeSingleEvent(of: .value, with: {(snapshot) in
                if let dict = snapshot.value as? Dictionary<String, Int> {
                    for (key, _) in dict {
                        FirebaseDataService.instance.groupRef.child(key).observeSingleEvent(of: .value, with: {(snapshot) in
                            if let data = snapshot.value as? Dictionary<String, AnyObject> {
                                let group = Group(key: key, data: data)
                                self.groups.append(group)
                                
                                DispatchQueue.main.async(execute: {
                                    self.tableView.reloadData()
                                })
                            }
                        })
                    }
                }
            })
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "chatting", sender: groups[indexPath.row].key)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = groups[indexPath.row].name
        return cell
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "userList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userList" {
            let userListVC = segue.destination as! UserListViewController
            let chatGroupVC = sender as! ChatGroupViewController
            userListVC.chatGroupVC = chatGroupVC
        } else if segue.identifier == "chatting" {
            let chatVC = segue.destination as! ChatRoomViewController
            chatVC.groupKey = sender as? String
        }
    }
    

}
