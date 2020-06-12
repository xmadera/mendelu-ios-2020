//
//  ImageURL+Extension.swift
//  KinoCircle
//
//  Created by Jan Madera on 04/06/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import Foundation

extension String {
    var getImageUrl: URL? {
        let poster = self
        return URL(string: poster) ?? URL(string: "https://www.tibs.org.tw/images/default.jpg")!
    }
}

