//
//  ViewController.swift
//  News
//
//  Created by Anbusekar Murugesan on 05/04/2022.
//

import UIKit
// 43996ec534d848288d024dcf87a388d2
class NewsViewController: UIViewController {
    
    
    // MARK: - View Life Cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customiseUI()
    }

    // MARK: - Custom methods
    func customiseUI() {
        
    }
    
    // Screen width.
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    // Screen height.
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    
    
}

