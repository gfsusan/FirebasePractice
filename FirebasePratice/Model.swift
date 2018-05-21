//
//  Model.swift
//  FirebasePratice
//
//  Created by CAUCSE on 2018. 3. 1..
//  Copyright © 2018년 mouda. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Book:NSObject, NSCoding {
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("books")
    
    var title: String?
    var coverImage: UIImage?
    var coverImageURL: String?
    var publisher: String?
    var writer: String?
    
    override init () {
        title = "DefaultTitle"
        coverImageURL = "DefaultImageURL"
        publisher = "DefaultPublisher"
        writer = "DefaultWriter"
    }
    
    init(title:String, coverImageURL:String, publisher:String, writer:String, bookDescription:String) {
        self.title = title
        self.coverImageURL = coverImageURL
        self.publisher = publisher
        self.writer = writer
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let title = aDecoder.decodeObject(forKey: "title") as? String {
            self.title = title
        }
        if let coverImageURL = aDecoder.decodeObject(forKey: "coverImage") as? String {
            self.coverImageURL = coverImageURL
        }
        if let publisher = aDecoder.decodeObject(forKey: "publisher") as? String {
            self.publisher = publisher
        }
        if let writer = aDecoder.decodeObject(forKey: "writer") as? String {
            self.writer = writer
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.coverImageURL, forKey: "coverImage")
        aCoder.encode(self.publisher, forKey: "publisher")
        aCoder.encode(self.writer, forKey: "writer")
    }
    
    func getCoverImage(withURL imageURL: String) -> UIImage? {
        if let url = URL(string: imageURL) {
            if let imgData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imgData) {
                    return image
                }
            }
        }
        return nil
    }
}

class Feed: NSObject, NSCoding {
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("feeds")
    
    //MARK: Properties
    let book:Book
    var bookUid: String?
    var userUid: String?
    var line:String
    var thought:String
    var page:Int
    let date:Date
    
    init(book:Book, page:Int, line:String, thought:String) {
        self.book = book
        self.line = line
        self.thought = thought
        self.page = page
        self.date = Date()
    }
    
    init(book:Book, page:Int, line:String, thought:String, date:Date) {
        self.book = book
        self.line = line
        self.thought = thought
        self.page = page
        self.date = date
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let book = aDecoder.decodeObject(forKey: "book") as? Book else {
            os_log("Unable to decode the Book object for a Feed object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let line = aDecoder.decodeObject(forKey: "line") as? String else {
            os_log("Unable to decode the line for a Feed object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let thought = aDecoder.decodeObject(forKey: "thought") as? String else {
            os_log("Unable to decode the line for a Feed object.", log: OSLog.default, type: .debug)
            return nil
        }
        let timeIntervalSince1970 = aDecoder.decodeDouble(forKey: "date")
        
        self.book = book
        self.line = line
        self.thought = thought
        self.page = aDecoder.decodeInteger(forKey: "page")
        self.date = Date(timeIntervalSince1970: timeIntervalSince1970)
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.book, forKey: "book")
        aCoder.encode(self.line, forKey: "line")
        aCoder.encode(self.thought, forKey: "thought")
        aCoder.encode(self.page, forKey: "page")
        aCoder.encode(self.date.timeIntervalSince1970, forKey: "date")
    }
    
}

class Bookmark:NSObject, NSCoding {
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("bookmarks")
    
    var book:Book
    var pageMark:Int?
    
    init(book:Book, page:Int) {
        self.book = book
        self.pageMark = page
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let book = aDecoder.decodeObject(forKey: "book") as? Book else {
            os_log("Unable to decode the Book object for a Bookmark Object", log: OSLog.default, type: .debug)
            return nil
        }
        if let page = aDecoder.decodeObject(forKey: "pageMark") as? Int  {
            self.pageMark = page
        }
        self.book = book
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.book, forKey: "book")
        if let pageNum = self.pageMark {
            aCoder.encode(self.pageMark, forKey: "pageMark")
        }
    }
}

