//
//  DataCenter.swift
//  FirebasePratice
//
//  Created by CAUCSE on 2018. 4. 9..
//  Copyright © 2018년 mouda. All rights reserved.
//

import Foundation


class DataCenter {
    var feeds:[Feed] = []
    var bookmarks:[Bookmark] = []
    
    init () {
        // 피드 파일 존재하는지 확인
        if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: Feed.ArchiveURL.path) as? [Feed] {
            print("피드 파일 있음")
            feeds += unarchArray
            
        } else {
            print("피드 파일 없음")
            // feeds += defaultFeedData()
            feeds += [Feed(book: Book(title: "모으다에 오신 걸 환영합니다.", coverImageURL: "http://cfile5.uf.tistory.com/image/214D5C37583EE5952C31D0", publisher: "모으다", writer: "모으다개발자", bookDescription: "nothing"), page: 100, line: "'쓰다' 버튼을 터치해 간직하고 싶은 책 속의 한 문장을 작성해주세요.", thought: "기록한 문장에 대한 본인만의 생각이나 감정을 표현해보세요.")]
        }
        
        
        if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: Bookmark.ArchiveURL.path) as? [Bookmark] {
            print("북마크 파일 있음")
            bookmarks += unarchArray
        } else {
            print("북마크 파일 없음")
            // bookmarks += defaultBookmarkData()
        }
    }
    
}
