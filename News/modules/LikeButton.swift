//
//  LikeButton.swift
//  News
//
//  Created by Anbusekar Murugesan on 09/04/2022.
//

import UIKit

class LikeButton: UIButton {

    
    
    func liked() {
        setImage(UIImage(systemName: "heart.fill"), for: .normal)
        setTitle("Liked", for: .normal)
    }
    
    func unLiked() {
        setImage(UIImage(systemName: "heart"), for: .normal)
        setTitle("Like", for: .normal)
    }

    
}
