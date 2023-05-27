//
//  ViewController.swift
//  ColorPalette
//
//  Created by Yuchen Guo on 4/6/23.
//

import UIKit

class colorListViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    var colors: [Color] = []
    var colorService: ColorService!
    private var selectedColors: [Color] = []
    private(set) var filteredColors: [Color] = []
    var searching: Bool = false
    
    var spinner = UIActivityIndicatorView(style: .medium)
    
    // MARK: UI Components
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let text: UITextView = {
        
        let attributedString = NSMutableAttributedString(string: "For thousands of years, all aspects of the Han nationality’s traditional culture, including clothing, architecture, painting, jade, porcelain, crafts, etc., have been associated with colors, and they have also shown the past. We listing here 526 colors, the original data collection from \"Color Name Dictionary\", published by Chinese Acadamy of Science in 1957.")
        attributedString.addAttribute(.link, value: "reference://Color-Name-Dictionary", range: (attributedString.string as NSString).range(of: "Color Name Dictionary"))
        
        let txt = UITextView()
        txt.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        txt.backgroundColor = .clear
        txt.attributedText = attributedString
        txt.textColor = .label
        txt.isSelectable = true
        txt.isEditable = false
        txt.isScrollEnabled = false
        txt.delaysContentTouches = false
        txt.font = UIFont.systemFont(ofSize: 20)
        return txt
    }()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        self.spinner.hidesWhenStopped = true
        self.spinner.startAnimating()
        self.view.addSubview(spinner)
        self.spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        // Do any additional setup after loading the view.
        
        //https://color-term.com/traditional-color-of-china/5/index.html
        // Rectangle().fill(.red).frame(width: 200, height: 200)
        
        self.colorService = ColorService()
        guard let confirmedService = self.colorService else {return}
        
        confirmedService.getColors(completion: {colors, error in
            guard let colors = colors, error == nil else {
                print(error)
                if (colors == nil && confirmedService.hasProblemGeneratingURL == true) {
                    print("The url is not generated.")
                    let alert = UIAlertController(title: "Alert", message: "The url is not generated.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: {return})
                }
                if (colors == nil && confirmedService.hasProblemGettingDataFromAPI == true) {
                    print("The url is incorrect.")
                    let alert = UIAlertController(title: "Alert", message: "Data is not fetched from the API.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: {return})
                }
                if (colors == nil && confirmedService.hasProblemDecodingData == true) {
                    print("The list is empty")
                    let alert = UIAlertController(title: "Alert", message: "Color list is empty.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: {return})
                }
                return }
            self.colors = colors
            self.tableView.reloadData()
            
        })
        //self.colors = self.colorService.getColors()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.setupSearchController()
       
        let tableHeaderView = TableViewHeader(frame: CGRect(x:0, y:0, width: self.tableView.frame.width, height: 500))
        self.tableView.tableHeaderView = tableHeaderView
        
        let tableFooterView = TableViewFooter(frame: CGRect(x:0, y:0, width: self.tableView.frame.width, height: 100))
        self.tableView.tableFooterView = tableFooterView
        //if #available(IOS 16.2, *){tableView.sectionHeaderTopPadding = 0.0}
        
        tableFooterView.onButtonClicked = {[weak self] in
            
            for i in 0...self!.colors.count-1 {
                if (self!.colors[i].confirmedSave == true) {
                    self?.selectedColors.append(self!.colors[i])
                }
            }
            
            
            if (self?.selectedColors.count)! > 0 {
                // Navigate to the NewColorViewController
                self?.performSegue(withIdentifier: "newColorSegue", sender: self)
                
                self?.selectedColors = []
            }
            else {
                let alert = UIAlertController(title: "Alert", message: "You must select colors to submit", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: {return})
            }
                        
            /*
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
            */
        }
        
        
        self.spinner.stopAnimating()
    }
    
    private func calculateNewColor(selectedColorList: [Color] ) -> String {
        print(self.selectedColors)
        
            
        var rSum = 0
        var gSum = 0
        var bSum = 0
        
        for i in 0...self.selectedColors.count-1 {
            let curHex = self.selectedColors[i].colorHexValue
            print(curHex)
            let rHex = curHex.substring(with: 1..<3)
            let gHex = curHex.substring(with: 3..<5)
            let bHex = curHex.substring(with: 5..<7)

            rSum += Int(UInt8(rHex, radix: 16)!)
            gSum += Int(UInt8(bHex, radix: 16)!)
            bSum += Int(UInt8(gHex, radix: 16)!)
        }
        
        let rVal = Int((Double(rSum) / Double(self.selectedColors.count)).rounded())
        let gVal = Int((Double(bSum) / Double(self.selectedColors.count)).rounded())
        let bVal = Int((Double(gSum) / Double(self.selectedColors.count)).rounded())
        
        let rString = String(format:"%02X", rVal)
        let gString = String(format:"%02X", gVal)
        let bString = String(format:"%02X", bVal)
        
        print("#" + rString + gString + bString)
        return "#" + rString + gString + bString
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        /*
        guard let confirmedService = self.colorService else {return}
        
        confirmedService.getColors(completion: {colors, error in
            guard let colors = colors, error == nil else {
                print(error)
                if (colors == nil && confirmedService.hasProblemGeneratingURL == true) {
                    print("The url is not generated.")
                    let alert = UIAlertController(title: "Alert", message: "The url is not generated.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: {return})
                }
                if (colors == nil && confirmedService.hasProblemGettingDataFromAPI == true) {
                    print("The url is incorrect.")
                    let alert = UIAlertController(title: "Alert", message: "Data is not fetched from the API.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: {return})
                }
                if (colors == nil && confirmedService.hasProblemDecodingData == true) {
                    print("The list is empty")
                    let alert = UIAlertController(title: "Alert", message: "Color list is empty.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: {return})
                }
                return }
            print("get colors is called")
            self.colors = colors
            self.tableView.reloadData()
            
        })
         */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "newColorSegue" {
            if let destinationVC = segue.destination as? NewColorViewController {
                // Set the desired data on the property of the destination view controller
                destinationVC.newColorHexValue = self.calculateNewColor(selectedColorList: self.selectedColors)

            }
        }
        
        if segue.identifier == "detailViewSegue" {
            // guard clause check condition
            guard
                let destination = segue.destination as? DetailViewController,
                let selectedIndexPath = self.tableView.indexPathForSelectedRow,
                let confirmedCell = self.tableView.cellForRow(at: selectedIndexPath) as? ColorCell
                else {return}
            let confirmedColor = confirmedCell.color
            destination.color = confirmedColor
            
            /*
            if let destination = segue.destination as? DetailViewController {
                if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
                    if let confirmedCell = self.tableView.cellForRow(at: selectedIndexPath) as? ColorCell {
                        let confirmedColor = confirmedCell.color
                        destination.color = confirmedColor
                    }
                }
            }
            */
        }
        
        
    }
    

    
    // MARK: UI Setup
    private func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "search colors"
        self.searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    

}

// MARK: Search Controller Functions
extension colorListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.searching = true
        guard let text = searchController.searchBar.text else {
            return
        }
        //let viewController = searchController.searchResultsController as? SearchResultViewController
        //viewController?.view.backgroundColor = .systemYellow

        self.tableView.reloadData()
    }
}

extension colorListViewController: UITableViewDataSource {
    // MARK：DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searching {
            return self.filteredColors.count
        }
        else {
            return self.colors.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "colorCell") as! ColorCell
        if self.searching {
            cell.color = self.filteredColors[indexPath.row]
        }
        else {
            cell.color = self.colors[indexPath.row]
        }
        
        //let currentColor = self.colors[indexPath.row]
       
        //cell.color = currentColor
        
        return cell
    }
    
    
}

extension colorListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            self.filteredColors = self.colors.filter{$0.colorEnglishName.lowercased().contains(searchText.lowercased())}
        }
        else {
            self.searching = false
            print("Enter the english name of the color")
            self.filteredColors = self.colors
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searching = false
        searchBar.text = ""
        self.filteredColors = self.colors
        self.tableView.reloadData()
    }
}

extension colorListViewController: UITableViewDelegate {
    // MARK: Delegate
    
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        if
            let cell = self.tableView.cellForRow(at: indexPath) as? ColorCell,
            let confirmedColor = cell.color
        {
            confirmedColor.confirmedSighting = true
            cell.accessoryType = confirmedColor.confirmedSighting ? .checkmark : .none
        }
        
    }
    */
     
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let title = NSLocalizedString("Save", comment: "Save action")
        let color = self.colors[indexPath.row]
        let saveActionTitle = color.confirmedSave ? "Unselect" : "Select"
        
        // Add the accessoryView
        let heart = UIImageView(frame: CGRect(x: 0, y: 65, width: 35, height: 30))
        heart.image = UIImage(systemName: "heart.fill")
        heart.tintColor = .systemRed
        
        
        let action = UIContextualAction(style: .normal, title: saveActionTitle, handler: { (action, view, completionHandler) in

            if let cell = self.tableView.cellForRow(at: indexPath) as? ColorCell, let confirmedColor = cell.color {
                
                confirmedColor.confirmedSave.toggle()
                
                //cell.backgroundColor = confirmedColor.confirmedSave ? UIColor(red: 120/255.0, green: 150/255.0, blue: 200/255.0, alpha: 0.5) : .none

                // Add the accessoryView
                cell.accessoryView = confirmedColor.confirmedSave ? heart : .none
            }
            
            completionHandler(true)
        })
        
        action.backgroundColor = .systemGray5
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        
        return configuration
    }

     
}

// https://stackoverflow.com/questions/39677330/how-does-string-substring-work-in-swift
extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
