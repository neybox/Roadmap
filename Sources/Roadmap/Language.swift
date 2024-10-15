//
//  Language.swift
//  Roadmap
//
//  Created by Abdullah Alhaider on 21/02/2023.
//

import Foundation

enum Language {
    case LTR, RTL
    
    static var code: String {
		if #available(iOS 16.0, *) {
			return Locale.current.language.languageCode?.identifier ?? "en"
		} else {
			return Locale.current.languageCode ?? "en"
		}
	}
}
