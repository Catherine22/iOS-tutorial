//
//  RegisterViewController.swift
//  Flash Chat
//
//  This is the View Controller which registers new users with Firebase
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

    
    //Pre-linked IBOutlets

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

  
    @IBAction func registerPressed(_ sender: AnyObject) {
        SVProgressHUD.show()
        
        //TODO: Set up a new user on our Firbase database
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) {
            // callback
            (authResult, error) in
            SVProgressHUD.dismiss()
            if error != nil {
//                print("//---")
//                print(error!)
//                print("---//")
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let restartAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                    self.passwordTextfield.text = ""
                })
                alert.addAction(restartAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                // success
//                print("Registeraction successful")
                self.passwordTextfield.text = ""
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
            
//            guard let user = authResult?.user else { return }
        }
        

        
        
    } 
    
    
}
