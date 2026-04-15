import UIKit

class SignUp: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        
        guard let email = emailField.text,
              let password = passwordField.text,
              !email.isEmpty,
              !password.isEmpty else {
            print("Missing fields")
            return
        }
        
        Task {
            do {
                try await NetworkManager.shared.signUp(email: email, password: password)
                print("Signup successful")
                let storyboard = UIStoryboard(name: "Auth", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ProfileVC")
                
                navigationController?.pushViewController(vc, animated: true)
            } catch {
                print("Signup error:", error)
            }
        }
    }
}
