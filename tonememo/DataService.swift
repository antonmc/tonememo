//
//  DataService.swift
//  tonememo
//
//  Created by Richard Martin on 2017-05-23.
//  Copyright © 2017 Anton McConville. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()
let STORAGE_BASE = Storage.storage().reference()

// MARK: file contains references to firebase database endpoints

class DataService {
    
    // MARK: create a single instance of type DataService :: singleton
    
    static let ds = DataService()
    
    // MARK: reference endpoints for Firevase Database
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: DatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    // MARK: custom func to create user in firebase database
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    // MARK: reference endpoint for Firebase Storage
    private var _REF_IMAGES = STORAGE_BASE.child("post-images")
    
    var REF_IMAGES: StorageReference {
        return _REF_IMAGES
    }
    
}
