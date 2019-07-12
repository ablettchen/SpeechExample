//
//  ViewController.swift
//  BestLe
//
//  Created by ablett on 2019/7/7.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit

open class ViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }
    
    /**
     Prepares the view instance when intialized. When subclassing,
     it is recommended to override the prepareView method
     to initialize property values and other setup operations.
     The super.prepareView method should always be called immediately
     when subclassing.
     */
    open func prepare() {
        extendedLayoutIncludesOpaqueBars = false
        edgesForExtendedLayout = []
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.contentScaleFactor = Screen.scale
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutSubviews()
    }
    
    /**
     Calls the layout functions for the view heirarchy.
     To execute in the order of the layout chain, override this
     method. `layoutSubviews` should be called immediately, unless you
     have a certain need.
     */
    open func layoutSubviews() { }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
