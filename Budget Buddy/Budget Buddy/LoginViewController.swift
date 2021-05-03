//
//  LoginViewController.swift
//  Budget Buddy
//
//  Created by Jose Lopez on 4/21/21.
//

import UIKit
import Parse


class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    class ViewController: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            overrideUserInterfaceStyle = .dark
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "LoggedIn") == true{
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
        
    }
    
    
    @IBAction func onLogin(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if (user != nil){
                UserDefaults.standard.setValue(true, forKey: "LoggedIn")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            print("Error: \(String(describing: error?.localizedDescription))")
            
        }
    }
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user.signUpInBackground { (success, error) in
            if (success){
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
