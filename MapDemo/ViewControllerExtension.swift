//
//  ViewControllerExtension.swift
//  MapDemo
//
//  Created by Julian Tejera on 5/14/15.
//  Copyright (c) 2015 Julian Tejera. All rights reserved.
//

import UIKit


extension UIViewController {
    
    var contentViewController: UIViewController {
        if let controller = self as? UINavigationController {
            return controller.visibleViewController
        }
        return self
    }
}