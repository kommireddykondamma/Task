//
//  RestaurentCell.swift
//  Task
//
//  Created by LALITHA KONDA on 01/08/22.
//

import UIKit

class RestaurentCell: UICollectionViewCell {

    @IBOutlet weak var offerView: UIView!
    @IBOutlet weak var uptoLbl: UILabel!
    @IBOutlet weak var extraOffView: UIView!
    @IBOutlet weak var ratingLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        offerView.roundCorners(radius: 4, corners: [.topRight, .bottomRight])
        extraOffView.roundCorners(radius: 4, corners: [.topRight, .bottomRight])
        uptoLbl.text = "Up to \u{20b9}50"
        ratingLbl.text = "3.6 \u{272d}"
        // Initialization code
    }
// 272d
}
