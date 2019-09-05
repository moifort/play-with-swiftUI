//
//  StringUtil.swift
//  kohi
//
//  Created by Thibaut on 05/09/2019.
//  Copyright © 2019 Thibaut. All rights reserved.
//

import Foundation

extension String: Error {}
extension String {
    
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "\(self)", comment: "")
    }
}
