//
//  FieldLabel.swift
//  MVC-MyToDos
//
//  Created by 이종선 on 8/17/24.
//

import UIKit

class FieldLabel: UILabel {

    required init(title: String) {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .left
        font = .systemFont(ofSize: 21, weight: .light)
        textColor = .grayTextColor
        text = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
