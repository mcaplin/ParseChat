//
//  LoginViewController.swift
//  Parse Chat
//
//  Created by Michelle Caplin on 2/21/18.
//  Copyright © 2018 Michelle Caplin. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // add the OK action to the alert controller
    
    override func viewDidLoad() {

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        self.activityIndicator.startAnimating()

        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success, error) in
            if let error = error {
                print(error.localizedDescription)
                self.alert(code: error._code)
            }
            else {
                print("User registered successfully")
            }
        }
        self.activityIndicator.stopAnimating()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        self.activityIndicator.startAnimating()

        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                self.alert(code: error._code)
            }
            else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        self.activityIndicator.stopAnimating()

    }
    
    
    func alert(code: Int) {
        let alert = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
        if code == 200 { //username missing
            alert.title = "Username Required"
            alert.message = "Please enter your username."
        }
        if code == 201 { // password missing
            alert.title = "Password Required"
            alert.message = "Please enter your password."
        }
        if code == 202 { // username unavailable
            alert.title = "Username unavailable"
            alert.message = "Please enter a different username."
        }
        if code == 101 { // invalid password
            alert.title = "Password Incorrect"
        }
        if code == 100 {
            alert.title = "Cannot Connect to ParseChat"
        }
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        alert.addAction(OKAction)
        present(alert, animated: true) {
        }
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
