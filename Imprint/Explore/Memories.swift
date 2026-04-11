import UIKit

class Memories: UIViewController {

    @IBOutlet weak var memoryView: UICollectionView!
    let grabber = UIView(frame: CGRect(x: 0, y: 8, width: 40, height: 5))
    override func viewDidLoad() {
        super.viewDidLoad()
        grabber.center.x = view.center.x
        grabber.backgroundColor = .systemGray3
        grabber.layer.cornerRadius = 2.5
        view.addSubview(grabber)
        print("Memories loaded")
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    
}

extension Memories: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = memoryView.dequeueReusableCell(withReuseIdentifier: "memory_cell", for: indexPath)
        return cell
    }
    
    
}
