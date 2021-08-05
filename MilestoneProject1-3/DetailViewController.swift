//
//  DetailViewController.swift
//  MilestoneProject1-3
//
//  Created by Harsh Verma on 05/08/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var flagPic: UIImageView!
    var hd: [String]?
    var number: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = getTextForFlag(flagName: hd![number!], type: .HD)
        flagPic.image = UIImage(named: hd![number!])
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        
        guard let image = flagPic.image?.jpegData(compressionQuality: 0.4) else {
            return
        }
        
        let vc = UIActivityViewController(activityItems: [title ?? "Unknown", image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}
