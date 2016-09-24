// Created by mmvdv on 13/07/16.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let splitViewController = self.window?.rootViewController as? UISplitViewController,
                let navigationController = splitViewController.viewControllers.last as? UINavigationController {
            navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
            splitViewController.delegate = self
        }
        return true
    }
    
    // MARK: - Split view
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else {return false}
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else {return false}
        if topAsDetailController.detailItem == nil {
            return true
        }
        return false
    }
}
