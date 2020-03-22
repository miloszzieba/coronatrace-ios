//
//  MainButton.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 21/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import UIKit

final class MainButton: UIButton {
    // MARK: - View Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        layer.cornerRadius = 8.0
        backgroundColor = R.color.backgroundSecondary()
        setTitleColor(R.color.fontPrimary(), for: .normal)
        titleLabel?.font = R.font.baloo2SemiBold(size: 14.0)
    }
}
