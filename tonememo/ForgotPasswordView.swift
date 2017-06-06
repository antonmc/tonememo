//
//  ForgotPasswordView.swift
//  tonememo
//
//  Created by Richard Martin on 2017-06-06.
//  Copyright © 2017 Anton McConville. All rights reserved.
//

import UIKit
import Firebase


class ForgotPasswordView: UIViewController {

    @IBOutlet weak var forgotEmailText: LoginTextFieldStyle!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func forgotPasswordButtonTapped(_ sender: UIButton) {
        
        if self.forgotEmailText.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter an email address.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            var message = ""
            var title = ""
            Auth.auth().sendPasswordReset(withEmail: self.forgotEmailText.text!, completion: { (error) in
                if error != nil {
                    title = "Something went wrong."
                    message = (error?.localizedDescription)!
                } else {
                    title = "Success"
                    message = "Email password has been sent."
                    self.forgotEmailText.text = ""
                }
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            })
        }
        
    }

}
