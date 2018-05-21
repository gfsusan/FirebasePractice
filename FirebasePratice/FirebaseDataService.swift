//
//  FirebaseDataService.swift
//  FirebasePratice
//
//  Created by CAUCSE on 2018. 3. 1..
//  Copyright © 2018년 mouda. All rights reserved.
//

import Foundation
import Firebase

fileprivate let baseRef = Database.database().reference()

class FirebaseDataService {
    static let instance = FirebaseDataService()
    
    // 특정 데이터들이 저장되는 장소에 대한 레퍼런스
    // user : 특정 사용자
    let userRef = baseRef.child("user")
    
    // feed : 피드 하나 단위
    let feedRef = baseRef.child("feed")
    
    // book : 책 하나 단위
    let bookRef = baseRef.child("book")
    
    // 현재 접속중인 유저의 uid
    var currentUserUid: String? {
        get {
            guard let uid = Auth.auth().currentUser?.uid else {
                return nil
            }
            
            return uid
        }
    }

    
    // 신규 유저 만들기
    func createUserInfoFromAuth(uid:String, userData:Dictionary<String,String>) {
        userRef.child(uid).updateChildValues(userData)
    }

    // 사용자 로그인 하ㅣㄱ
    func signIn(withEmail email: String, password: String, completion: @escaping() -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            guard error == nil else {
                print("Error occurred during Sign in")
                return
            }
            completion()
        })
    }
}

