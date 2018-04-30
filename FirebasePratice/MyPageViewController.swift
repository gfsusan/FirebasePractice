//
//  LoginViewController.swift
//  FirebasePratice
//
//  Created by CAUCSE on 2018. 4. 9..
//  Copyright © 2018년 mouda. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var feeds:[Feed] = []
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "loginSegue", sender: self)
        feeds = dataCenter.feeds
        tableview.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchFeeds()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(feeds.count)dkfjalsfjlskd")
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableview")
        let cell = tableview.dequeueReusableCell(withIdentifier: "myFeedCell", for: indexPath) as! MyPageTableViewCell
        
        let feed = feeds[indexPath.row]
        cell.titleLabel.text = feed.book.title!
        cell.lineLabel.text = feed.line
        cell.pageLabel.text = "\(feed.page)"
        cell.thoughtLabel.text = feed.thought
        
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func fetchFeeds() {
        print("fetch feeds")
        if let uid = FirebaseDataService.instance.currentUserUid {
            FirebaseDataService.instance.userRef.child(uid).child("feeds").observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? Dictionary<String, Int> {
                    for (key, _) in dict {
                        FirebaseDataService.instance.feedRef.child(key).observeSingleEvent(of: .value, with: {(snapshot) in
                            if let data = snapshot.value as? Dictionary<String, AnyObject> {
//                                let feed = Feed(key: key, data: data)
//                                self.feeds.append(feed)
                                print(data)
                                print(type(of: data))
                                DispatchQueue.main.async(execute: {
                                    self.tableview.reloadData()
                                    })
                            }
                        })
                    }
                }
                })
        }
    }
}
