/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var username_tf: UITextField!
    @IBOutlet weak var password_tf: UITextField!

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    func displayAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) in
        self.dismissViewControllerAnimated(true, completion: nil) })))
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    
    
    @IBAction func signUp(sender: AnyObject) {
        if username_tf.text == "" || password_tf.text == "" {
            displayAlert("Error in Form", message: "Please enter a username")
            
        } else {
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0,50,50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            let user = PFUser()
            user.username = username_tf.text
            user.password = password_tf.text
            
            var errorMessage = "Please try again later"
            
            user.signUpInBackgroundWithBlock({ (success, error) in
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if error == nil {
                    // Signup Successful
                } else {
                    if let errorString = error!.userInfo["error"] as? NSString{
                        
                        errorMessage = errorString as String
                            
                        
                    }
                    self.displayAlert("Failed Signup", message: errorMessage)
                }
                
            })
            
        }
    
    
    
    
    
    }

    
        
        
    @IBAction func logIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(username_tf.text!, password: password_tf.text!) { (user, error) in
            if user != nil {
                print("logged in")
            } else {
                
                if let errorString = error!.userInfo["error"] as? String {
                   let errorMessage = errorString
                    self.displayAlert("Failed Login", message: errorMessage)

                }
            }
        
        }
    }
    


}
