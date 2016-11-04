//
//  HelperMethods.swift
//  TheAPIAwakens
//
//  Created by Mathias Vang on 27/10/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import UIKit

func designScreen() {
//    UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
//    
//    UINavigationBar.appearance().shadowImage = UIImage()
//    
//    UINavigationBar.appearance().barTintColor = UIColor(red: 27/255, green: 32/255, blue: 36/255, alpha: 1.0)
//    
//    UINavigationBar.appearance().translucent = false
//    
//    UINavigationBar.appearance().clipsToBounds = false
//    
//    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
}

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.Top:
            border.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), thickness)
            break
        case UIRectEdge.Bottom:
            border.frame = CGRectMake(0, CGRectGetHeight(self.frame) - thickness, CGRectGetWidth(self.frame), thickness)
            break
        case UIRectEdge.Left:
            border.frame = CGRectMake(0, 0, thickness, CGRectGetHeight(self.frame))
            break
        case UIRectEdge.Right:
            border.frame = CGRectMake(CGRectGetWidth(self.frame) - thickness, 0, thickness, CGRectGetHeight(self.frame))
            break
        default:
            break
        }
        
        border.backgroundColor = color.CGColor;
        
        self.addSublayer(border)
    }
}
