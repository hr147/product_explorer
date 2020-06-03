import UIKit.UIImageView
import Kingfisher

extension UIImageView {
    public func setImage(with url: URL?, placeholder: UIImage? = nil) {
        kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(0.1))])
    }
}
