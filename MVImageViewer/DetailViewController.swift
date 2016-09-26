//  Copyright © 2016 mmvdv. All rights reserved.

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var labels: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var blurringView: UIVisualEffectView!
    
    var vision = CloudVision()
    
    var detailItem: Detail?
    
    var isLoading = false {
        willSet {
            switch newValue {
            case true:
                blurringView.isHidden = false
                activityIndicator.startAnimating()
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case false:
                blurringView.isHidden = true
                activityIndicator.stopAnimating()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
    
    private func configureView() {
        detailImageView.image = detailItem?.image
        if let image = detailItem?.image {
            fetchInformation(image: image)
        }
    }
    
    private func fetchInformation(image: UIImage) {
        isLoading = true
        vision.process(image: image) {[weak self] (response) in
            self?.handle(response: response)
        }
    }
    
    private func handle(response: CloudVisionResponse) {
        isLoading = false
        switch response {
        case .success(let result):
            labels.text = result.annotations.reduce("") { (currentString, annotation) -> String in
                currentString + ", \(annotation.label)"
            }
        case .failure(let error):
            let alert = UIAlertController(title: "Cloud Vision Error",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
