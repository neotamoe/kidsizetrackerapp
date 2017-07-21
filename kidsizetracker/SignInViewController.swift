//
//  SignInViewController.swift
//  kidsizetracker
//
//  Created by Neota Moe on 7/21/17.
//  Copyright © 2017 Neota Moe. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

  @IBOutlet weak var signInSelector: UISegmentedControl!
  
  @IBOutlet weak var signInLabel: UILabel!
  
  @IBOutlet weak var emailTextField: UITextField!
  
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBOutlet weak var signInButton: UIButton!
  
  var isSignIn: Bool = true
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
    isSignIn = !isSignIn
    if isSignIn {
      signInLabel.text = "Sign In"
      signInButton.setTitle("Sign In", for: .normal)
    } else {
      signInLabel.text = "Register"
      signInButton.setTitle("Register", for: .normal)
    }
  }

  @IBAction func signInButtonTapped(_ sender: UIButton) {
    
    // TODO: do some form validation on the email and password
    if let email = emailTextField.text, let pass = passwordTextField.text{
      if isSignIn {
        Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
          if let u = user {
            // user is found, go to next screen
            self.performSegue(withIdentifier: "goToHome", sender: self)
          } else {
            // check error and show message
          }
        })
      } else {
        Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
          if let u = user {
            // user is found, go to next screen
            self.performSegue(withIdentifier: "goToHome", sender: self)
          } else {
            // check error and show message
          }
        })
      }
      
    }
    

  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    emailTextField.resignFirstResponder()
    passwordTextField.resignFirstResponder()
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
