//
//  LoginViewController.swift
//  FirebasePratice
//
//  Created by CAUCSE on 2018. 4. 9..
//  Copyright © 2018년 mouda. All rights reserved.
//

import UIKit
import Firebase

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
        FirebaseDataService.instance.feedRef.observe(.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.feeds.removeAll()
                
                for feeds in snapshot.children.allObjects as! [DataSnapshot] {
                    let feedObject = feeds.value as? [String: AnyObject]
                    let feedLine = feedObject?["line"]
                    let feedPage = feedObject?["page"]
                    let feedThought = feedObject?["thought"]
                    
                    let feedBookUid = feedObject?["bookUid"]
                    FirebaseDataService.instance.bookRef.child(feedBookUid as! String).observeSingleEvent(of: .value, with: {(snapshot) in
//                        let bookObject = snapshot.children.nextObject() as! DataSnapshot
//                        let bookTitle = bookObject["title"]
//                        let bookPublisher = bookObject["publisher"]
//                        let bookAuthor = bookObject["author"]
//                        let bookCoverImageURL = bookObject["coverImageURL"]
                        
                    
                    })
                    

                    
//                    let feed = Feed(book: Book(title: feedTitle as! String, coverImageURL: "dslfasdlk", publisher: "sdsdf", writer: "sdf", bookDescription: "dslkfj"), page: feedPage as! Int, line: feedLine as! String, thought: feedThought as! String)
                    
//                    self.feeds.append(feed)
                }
                self.tableview.reloadData()
            }
        })
    }

}
