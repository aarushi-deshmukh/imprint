import UIKit

class Profile: UIViewController {
    
    @IBOutlet weak var profileView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.delegate = self
        profileView.dataSource = self
        profileView.setCollectionViewLayout(generateLayout(), animated: true)
    }
    
    func generateLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, env in
            
            switch sectionIndex {
                
            case 0:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(120)
                )
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
                
                return section
                
            case 1:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(100)
                )
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
                
                return section
                
            case 2:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(50)
                )
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
                
                return section
                
            case 3:
                let bigItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(0.6)
                    )
                )
                
                let smallItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.5),
                        heightDimension: .fractionalHeight(0.4)
                    )
                )
                smallItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                
                let bottomGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(0.4)
                    ),
                    subitems: [smallItem, smallItem]
                )
                
                let mainGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(300)
                    ),
                    subitems: [bigItem, bottomGroup]
                )
                
                let section = NSCollectionLayoutSection(group: mainGroup)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
                
                return section
                
            default:
                return nil
            }
        }
        
        return layout
    }
    
    @IBAction func logOut(_ sender: UIButton){
        Task {
            do {
                try await NetworkManager.shared.logout()
                
                // Navigate to login screen
                DispatchQueue.main.async {
                    self.navigateToLogin()
                }
                
            } catch {
                print("Logout failed: \(error.localizedDescription)")
            }
        }
    }
    
    func navigateToLogin() {
        
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "AuthVC")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = loginVC
            window.makeKeyAndVisible()
        }
    }
}

extension Profile: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = profileView.dequeueReusableCell(withReuseIdentifier: "info_cell", for: indexPath)
            return cell
        } else if indexPath.section == 1 {
            let cell = profileView.dequeueReusableCell(withReuseIdentifier: "stat_cell", for: indexPath)
            return cell
        } else if indexPath.section == 2 {
            let cell = profileView.dequeueReusableCell(withReuseIdentifier: "action_buttons", for: indexPath)
            return cell
        }
        let cell = profileView.dequeueReusableCell(withReuseIdentifier: "slider_buttons", for: indexPath)
        return cell
        
    }
}
