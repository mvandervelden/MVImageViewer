// Created by mmvdv on 13/07/16.

import UIKit

protocol Detail {
    func description() -> String
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    var detailItem: Detail? {
        didSet {
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        if let label = detailDescriptionLabel {
            if let item = detailItem {
                label.text = item.description()
            } else {
                label.text = ""
            }
        }
    }
}
