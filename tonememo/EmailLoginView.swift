//
//  EmailLoginView.swift
//  tonememo
//
//  Created by Richard Martin on 2017-05-22.
//  Copyright © 2017 Anton McConville. All rights reserved.
//

import UIKit
import Firebase

class EmailLoginView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var emailLoginText: LoginTextFieldStyle!
    @IBOutlet weak var passwordText: LoginTextFieldStyle!

    

    // MARK: authenticate user with email + password OR create new user account with email + password
    @IBAction func signinTapped(_ sender: Any) {
        if let email = emailLoginText.text, let password = passwordText.text {
            
            if email.isEmpty || password.isEmpty {
                // send an alert that one of the fields is empty
                displayAlert(messageToDisplay: "Your email address and/or password field(s) is/are empty. Please try again.")
            } else {
                let isEmailAddressValid = verifyEmailAddressValid(emailAddressString: email)
                if isEmailAddressValid {
                    // verify password is valid
                    if password.characters.count >= 6 {
                        firebaseEmailAuth(email: email, password: password)
                    } else {
                        // fire alert controller indicating that password is too short in length
                        displayAlert(messageToDisplay: "The password you provided is too short. You need at least 6 characters.")
                    }
                } else {
                    // fire alert controller stating that email address is invalid and must be enter a valid email address
                    displayAlert(messageToDisplay: "The email address you provided is invalid. Please make sure the email address is correct.")
                }
            }
        }
    }

    // MARK: firebase email sign authorization and signin in process
    func firebaseEmailAuth(email: String, password: String) {
    
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                // firebase authentication successful
                self.performSegue(withIdentifier: "emailSuccessSegue", sender: nil)
            } else {
                // user does not exist in firebase :: create new user
                Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                    if error != nil {
                        // alert user that there was a problem creating user
                        self.displayAlert(messageToDisplay: "Unable to create your account. Please try again.")
                    } else {
                        // new user successfully created in firebase
                        // post user on firebase database using func inside DataService
                        if let user = user {
                            let userData = ["provider": user.providerID]
                            self.completeSignIn(id: user.uid, userData: userData)
                        }
                    }
                })
            }
        })
    }

    // MARK: alert controller to display message to user
    func displayAlert(messageToDisplay: String) {
        let alertController = UIAlertController(title: "Problem with Email Login.", message: messageToDisplay, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Please try again.", style: .default) { (action: UIAlertAction) in
            self.emailLoginText.text = ""
            self.passwordText.text = ""
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Mark: function to verify email address
    func verifyEmailAddressValid(emailAddressString: String) -> Bool {
        var returnValue = true
        
        /* regex options
         "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
         "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
         "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
         */
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,6}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegex, options: NSRegularExpression.Options.caseInsensitive)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, options: [], range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return returnValue
    }

    // MARK: function to complete the signin process :: post new user in firebase database and segue to RecordView
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        performSegue(withIdentifier: "emailSuccessSegue", sender: nil)
    }
    
    // MARK: unwind segue
    @IBAction func unwindToEmail(segue: UIStoryboardSegue) {
        // unwind back to this view
    }
}
