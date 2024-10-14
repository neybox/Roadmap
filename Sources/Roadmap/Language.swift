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
			print("~~~language code: \(Locale.current.language.languageCode?.identifier ?? "en")")
			return Locale.current.language.languageCode?.identifier ?? "en"
		} else {
			print("~~~language code: \(Locale.current.languageCode ?? "en")")
			return Locale.current.languageCode ?? "en"
		}
	}
}
