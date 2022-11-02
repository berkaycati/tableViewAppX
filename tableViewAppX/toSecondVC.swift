//
//  toSecondVC.swift
//  tableViewAppX
//
//  Created by Berkay on 25.08.2022.
//

import UIKit

class toSecondVC: UIViewController {
    
    @IBOutlet weak var newTextLabel: UILabel!
    @IBOutlet weak var newImageView: UIImageView!
    
    var selectedName = ""
    var selectedImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        newTextLabel.text = selectedName
        newImageView.image = selectedImage
        
    }
    
}
