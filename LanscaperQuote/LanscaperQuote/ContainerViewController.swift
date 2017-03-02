//
//  ContainerViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/4/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

protocol ContainerViewControllerDelegate {
 
}

class ContainerViewController: UIViewController {
    var delegate: ContainerViewControllerDelegate?
    var currentSegueIdentifier:String?
    var currentCalculatorType:String = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()

        self.currentSegueIdentifier = EMPTY_SEGUE_RECTANGLE_IDENTIFIER
        self.performSegue(withIdentifier:self.currentSegueIdentifier! , sender: nil)
       
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == EMPTY_SEGUE_RECTANGLE_IDENTIFIER ) {
            let vc = segue.destination as! RectangleViewController
            vc.delegate = self.delegate as! AddLineItemViewController
            vc.calculatorType = currentCalculatorType
            if(self.childViewControllers.count > 0 ){
             //swap
               
                self.swapFromViewController(fromVC: self.childViewControllers[0], toViewCOntroller: segue.destination)
            }
            else{
                self.addChildViewController(segue.destination)
                segue.destination.view.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                self.view.addSubview(segue.destination.view)
                segue.destination.didMove(toParentViewController: self)
            }
        }
        else if (segue.identifier == EMPTY_SEGUE_CIRCLE_IDENTIFIER){
            let vc = segue.destination as! CircleViewController
            vc.delegate = self.delegate as! AddLineItemViewController
            vc.calculatorType = currentCalculatorType
            self.swapFromViewController(fromVC: self.childViewControllers[0], toViewCOntroller: segue.destination)
            
        }
        else if (segue.identifier == EMPTY_SEGUE_TRIANGLE_IDENTIFIER){
            let vc = segue.destination as! TriangleViewController
            vc.calculatorType = currentCalculatorType
            vc.delegate = self.delegate as! AddLineItemViewController
            self.swapFromViewController(fromVC: self.childViewControllers[0], toViewCOntroller: segue.destination)
            
        }
         else if (segue.identifier == EMPTY_SEGUE_PAVER_IDENTIFIER){
            let vc = segue.destination as! PaverBlockCalculatorViewController
            vc.delegate = self.delegate as! AddLineItemViewController
            vc.calculatorType = currentCalculatorType
            self.swapFromViewController(fromVC: self.childViewControllers[0], toViewCOntroller: segue.destination)
            
        }
        else if (segue.identifier == EMPTY_SEGUE_GRASS_SEED_IDENTIFIER){
            let vc = segue.destination as! GrassSeedViewController
            //vc.delegate = self.delegate as! AddLineItemViewController
            self.swapFromViewController(fromVC: self.childViewControllers[0], toViewCOntroller: segue.destination)
            }
      
    }
    
   
    
    func swapFromViewController(fromVC:UIViewController , toViewCOntroller toVC:UIViewController)  {
        toVC.view.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        fromVC.willMove(toParentViewController: nil)
        self.addChildViewController(toVC)
        self.transition(from: fromVC, to: toVC, duration: 1.0, options: .curveEaseOut, animations: nil) { (Bool) in
            fromVC.removeFromParentViewController()
            toVC.didMove(toParentViewController: self)
        }
    }
    
   
    
    
    func showViewWithSegue(segueIdentifier:String, calculatorType:String )  {
        self.currentSegueIdentifier = segueIdentifier
        self.currentCalculatorType = calculatorType
        self.performSegue(withIdentifier: self.currentSegueIdentifier!, sender: nil)
    }
 
    

   
}
