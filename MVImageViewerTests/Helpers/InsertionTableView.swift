//  Created by mmvdv on 14/07/16.

import UIKit

class InsertionTableView: UITableView {
    var insertedIndexPath: IndexPath?
    
    override func insertRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        insertedIndexPath = indexPaths.first
    }
}
