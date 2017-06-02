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
    
    // MARK: authenticate app with Facebook
    @IBAction func facebookButtonTapped(_ sender: UIButton) {
        
        let facebookLogin = LoginManager()
        facebookLogin.logIn([.publicProfile], viewController: self) { result in
            switch result {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                let allowed = grantedPermissions.description
                let notAllowed = declinedPermissions.description
                print(allowed)
                print(notAllowed)
                self.firebaseAuth(credential)
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
                let userData = ["provider": user?.providerID]
                DataService.ds.createFirebaseDBUser(uid: (user?.uid)!, userData: userData as! Dictionary<String, String>)
            }
        })
    }
    
    @IBAction func twitterButtonTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func phoneButtonTapped(_ sender: UIButton) {
    }

    // MARK: unwind segue 
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {}
    

}

