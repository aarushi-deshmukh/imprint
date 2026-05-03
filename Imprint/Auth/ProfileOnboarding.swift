import UIKit

class ProfileOnboarding: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var fullnameField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var pfpView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pfpView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
            pfpView.addGestureRecognizer(tapGesture)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let editedImage = info[.editedImage] as? UIImage {
            pfpView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            pfpView.image = originalImage
        }

        picker.dismiss(animated: true)
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary   // or .camera
        picker.allowsEditing = true         // optional (crop)

        present(picker, animated: true)
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
