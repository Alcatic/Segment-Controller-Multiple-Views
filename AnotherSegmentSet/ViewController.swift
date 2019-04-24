//
//  ViewController.swift
//  AnotherSegmentSet
//
//  Created by c85529 on 4/24/19.
//  Copyright © 2019 c85529. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupViews()
    }

    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        
        
    }
    
    @IBOutlet weak var myView: UIView!
    
    func setupViews(){
        setupSegmentedControl()
        updateView()
    }
    
    private func setupSegmentedControl() {
        // Configure Segmented Control
        segmentControlOutlet.removeAllSegments()
        segmentControlOutlet.insertSegment(withTitle: "Black", at: 0, animated: false)
        segmentControlOutlet.insertSegment(withTitle: "Red", at: 1, animated: false)
        segmentControlOutlet.addTarget(self, action: #selector(selectionDidChange), for: .valueChanged)
        
        // Select First Segment
        segmentControlOutlet.selectedSegmentIndex = 0
    }
    
    @objc func selectionDidChange(){
        updateView()
    }
    
    
    private func updateView() {
        if segmentControlOutlet.selectedSegmentIndex == 0 {
            remove(asChildViewController: vc2)
            add(asChildViewController: vc)
        } else {
            remove(asChildViewController: vc)
            add(asChildViewController: vc2)
        }
    }
    
    
    private lazy var vc: VC = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "VCID") as! VC
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var vc2: VC2 = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "VC2ID") as! VC2
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        myView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = myView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    
}

