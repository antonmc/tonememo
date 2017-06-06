//
//  LoginView.swift
//  tonememo
//
//  Created by Anton McConville on 2017-05-19.
//  Copyright © 2017 Anton McConville. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore
import FacebookLogin

class LoginView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: authenticate app with Facebook
    @IBAction func facebookButtonTapped(_ sender: UIButton) {
        
        let facebookLogin = LoginManager()
        facebookLogin.logIn([.publicProfile], viewController: self) { result in
            switch result {
            case .failed(let error):
                print(error) // TODO: include user notification that login via facebook failed
            case .cancelled:
                print("User cancelled login.") // TODO: include user notification that login via facebook was cancelled by user
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                // important
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                self.firebaseAuth(credential)
                
                // not important
                let allowed = grantedPermissions.description
                let notAllowed = declinedPermissions.description
                print(allowed)
                print(notAllowed)
            }
        }
      }
    
    // authenticate with Firebase :: used by Facebook and Twitter login methods
    func firebaseAuth(_ _credential: AuthCredential) {
        
        Auth.auth().signIn(with: _credential, completion: { (user, error) in
            if error != nil {
                // alert user that firebase authentication failed
            } else {
                // firebase authentication successful => post user in firebase database
                if let user = user {
                    let userData = ["provider": user.providerID]
                    self.completeSignIn(id: user.uid, userData: userData)
                }
                
            }
        })
    }
    
    
    @IBAction func phoneButtonTapped(_ sender: UIButton) {
        // TODO: autheticate user via phone
    }

    // MARK: unwind segue 
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        // unwind back to this view
    }
    
    // MARK: function to complete the signin process :: post new user in firebase database and segue to RecordView
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }

}

