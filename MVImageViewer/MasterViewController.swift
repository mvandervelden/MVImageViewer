//  Copyright © 2016 mmvdv. All rights reserved.

import UIKit

class MasterViewController: UITableViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var imagePicker = UIImagePickerController()
    var detailViewController: DetailViewController? = nil
    var objects = [Image]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        imagePicker.delegate = self
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            let navigationController = controllers.last as? UINavigationController
            detailViewController = navigationController?.topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let split = splitViewController {
            clearsSelectionOnViewWillAppear = split.isCollapsed
        }
        super.viewWillAppear(animated)
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - Segues
extension MasterViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let navigationController = segue.destination as? UINavigationController
            if let indexPath = tableView.indexPathForSelectedRow,
                    let controller = navigationController?.topViewController as? DetailViewController {
                controller.detailItem = objects[indexPath.row]
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
        
        let object = objects[indexPath.row]
        cell.imageView?.image = object.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - Image Picker Delegate
extension MasterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            insert(pickedImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func insert(_ image: UIImage) {
        objects.insert(Image(image: image), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}
