//
//  ViewController.swift
//  MilestoneProject1-3
//
//  Created by Harsh Verma on 04/08/21.
//

import UIKit

class ViewController: UIViewController {

    var high = [String]()
    var standard = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles =  true
        title = "Country Flags"
        readFromDisk()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    func readFromDisk() {
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix(getFlagPrefix(type: .HD)) {
                high.append(item)
            }else if item.hasPrefix(getFlagPrefix(type: .SD)) {
                standard.append(item)
            }
        }
        high = sortFlags(flags: high, type: .HD)
        standard = sortFlags(flags: standard, type: .SD)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return high.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "country", for: indexPath) as! FlagaViewCell
        cell.flagLabel.text = getTextForFlag(flagName: standard[indexPath.row], type: .SD)
        cell.flagPic.image = UIImage(named: standard[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.hd = high
            vc.number = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
