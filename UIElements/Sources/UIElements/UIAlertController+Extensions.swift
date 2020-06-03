import UIKit

extension UIViewController {
    func showAlert(with error: Error) {
        let controller = UIAlertController(title: "Error Message",
                                           message: error.localizedDescription,
                                           preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        controller.addAction(action)
        
        present(controller, animated: true, completion: nil)
    }
}
