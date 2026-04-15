import UIKit

class ProfileOnboarding: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var fullnameField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func createTapped(_ sender: UIButton) {
        guard let username = usernameField.text,
              let fullName = fullnameField.text,
              let bio = bioTextView.text else { return }
        
        Task {
            do {
                try await NetworkManager.shared.createProfile(
                    username: username,
                    fullName: fullName,
                    bio: bio
                )
                
                DispatchQueue.main.async { [self] in
                    goToHome()
                }
                
            } catch {
                print("Profile creation error:", error)
            }
        }
    }
    
    func goToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }
    }
}
