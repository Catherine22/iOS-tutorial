//
//  LogInViewController.swift
//  Flash Chat
//
//  This is the view controller where users login


import UIKit
import Firebase

class LogInViewController: UIViewController {

    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let screenName = title else {
            return
        }
        let screenClass = classForCoder.description()
        Analytics.setScreenName(screenName, screenClass: screenClass)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func logInPressed(_ sender: AnyObject) {

        //TODO: Log in the user
        if let email = emailTextfield.text {
            if let password = passwordTextfield.text {
                Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                    guard let user = authResult?.user else {
                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        let restartAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                            self.passwordTextfield.text = ""
                        })
                        alert.addAction(restartAction)
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                    print("\(user) log in successful!")
                    self.performSegue(withIdentifier: "goToChat", sender: self)
                    
                }
            }
        }
        
        
    }
    


    
}  
