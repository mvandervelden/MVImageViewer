import UIKit

extension UIViewController {
    class func loadViewController(withIdentifier identifier: String, fromStoryboard storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}

extension UIViewController {
    func show() {
        UIApplication.shared.keyWindow!.rootViewController = self
        let _ = self.view
    }
}
