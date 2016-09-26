//  Copyright © 2016 mmvdv. All rights reserved.

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var labels: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var blurringView: UIVisualEffectView!
    @IBOutlet weak var analyzeButton: UIBarButtonItem!
    
    var vision = CloudVision()
    
    var detailItem: Image? {
        didSet {
            if isViewLoaded {
                configureView()
            }
        }
    }
    
    var isLoading = false {
        willSet {
            blurringView.isHidden = !newValue
            newValue ?
                activityIndicator.startAnimating() :
                activityIndicator.stopAnimating()
            UIApplication.shared.isNetworkActivityIndicatorVisible = newValue
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
        analyzeButton.isEnabled = detailItem?.image != nil
        if detailItem?.analysis != nil {
            labels.text = detailItem?.analysis?.orderedLabels
        } else {
            labels.text = detailItem?.image != nil ?
                "Tap 'Analyze' to find fitting labels for this image" :
                "Choose an image in the list to enable analysis"
        }
    }
    
    @IBAction func analyzeTapped(_ sender: UIBarButtonItem) {
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
            detailItem?.analysis = result
            labels.text = result.orderedLabels
        case .failure(let error):
            let alert = UIAlertController(title: "Cloud Vision Error",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
