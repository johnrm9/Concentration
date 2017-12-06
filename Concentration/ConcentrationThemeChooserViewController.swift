//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by John Martin on 12/5/17.
//  Copyright © 2017 John Martin. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {
    
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🎾🎱🏓🏸🤺⛷🏄‍♀️⛳️🏹🎳",
        "Animals": "🐶🐱🐭🐸🙉🐦🐔🦉🦀🐙🐋🦄🐓🐪🐼",
        "Faces": "😍😎😳🤐🤓😜🤠🙄😀😱🙀"
    ]
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let button = sender as? UIButton, let themeName = button.currentTitle, let theme = themes[themeName] {
                if let concentrationViewController = segue.destination as? ConcentrationViewController {
                    concentrationViewController.theme = theme
                }
            }
        }
    }
}
