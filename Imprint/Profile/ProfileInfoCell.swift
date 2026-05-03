import UIKit

class ProfileInfoCell: UICollectionViewCell {
    
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var bioField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureInfo(with data: ProfileDB) {
        nameField.text = data.fullName
        bioField.text = data.bio
    }
}
