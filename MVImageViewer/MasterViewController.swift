// Created by mmvdv on 13/07/16.

import UIKit

extension Date : Detail {
    func description() -> String {
        return description
    }
}

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var objects = [Detail]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            let navigationController = controllers[controllers.count - 1] as? UINavigationController
            detailViewController = navigationController?.topViewController as? DetailViewController
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let split = splitViewController {
            clearsSelectionOnViewWillAppear = split.isCollapsed
        }
        super.viewWillAppear(animated)
    }
    
    func insertNewObject(_ sender: AnyObject) {
        objects.insert(Date(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - Segues
extension MasterViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let navigationController = segue.destination as? UINavigationController
            if let indexPath = self.tableView.indexPathForSelectedRow,
                    let controller = navigationController?.topViewController as? DetailViewController {
                let object = objects[(indexPath as NSIndexPath).row]
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}

// MARK: - Table View
extension MasterViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        if let object = objects[(indexPath as NSIndexPath).row] as? Date {
            cell.textLabel!.text = object.description
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
}
