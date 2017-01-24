//
//  AppSettings.swift
//  pep9pad
//  Copyright © 2016 Pepperdine University. All rights reserved.
//

import UIKit

/// Shared instance of the app's settings. 
var appSettings = AppSettings()

/// Keeps track of the user's personal preferences, including font size and dark mode.
class AppSettings {
    init() {
        
    }
    
    // MARK: - Attributes
    
    var darkModeOn: Bool = false
    var font: UIFont = UIFont(name: "Courier", size: 12.0)!
    
    // MARK: - Methods
    
    func toggleDarkMode() {
        darkModeOn = !darkModeOn
    }
    
    /// Rather than giving `appSettings` a lot of attributes for, 
    /// say, `textColor` or `backgroundColor` or whatever, I figure we
    /// should just handle this info with a method.
    func getColorFor(_ thing: ColoredObject) -> UIColor {
        switch thing {
        case .background: return darkModeOn ? .black : .white
        case .text: return darkModeOn ? .white : .black
        case .errorText: return .red
        }
    }
}
