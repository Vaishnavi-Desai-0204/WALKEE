//
//  HomeViewController.swift
//  WALKEE
//
//  Created by Vikas desai  on 10/04/22.
//  Copyright © 2022 Vaishnavi desai. All rights reserved.
//

import UIKit
import HealthKit


class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var coins: UIBarButtonItem!
    
    @IBOutlet weak var plantImage: UIImageView!
    
    @IBOutlet weak var stepsCount: UILabel!
    
    var healthStore = HKHealthStore()
    
    let shape = CAShapeLayer()
    var s = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorizeHealthKit()
        
        plantImage.layer.cornerRadius = plantImage.frame.size.width / 2
        plantImage.clipsToBounds = true
        
        self.getStepsCount(forSpecificDate: Date()) { (steps) in
            self.s = steps
            if steps == 0.0 {
                
                print("steps :: \(steps)")
            }
            else {
                DispatchQueue.main.async {
                    print("steps :: \(steps)")
                }
            }
            
        }
        self.stepsCount.text = "\(s)"
        stepsCount.textAlignment = .center
        if s == 0.0 {
        self.plantImage.image = UIImage(named: "plant")
        }
        
        title = "WALKEE"
        
        
        
        let circlePath = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: -(.pi / 2), endAngle: .pi * 2, clockwise: true)
        
        let trackShape = CAShapeLayer()
        trackShape.path = circlePath.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 10
        trackShape.strokeColor =  UIColor.lightGray.cgColor
        view.layer.addSublayer(trackShape)
        
        shape.path = circlePath.cgPath
        shape.lineWidth = 10
        shape.lineCap = CAShapeLayerLineCap.round
        shape.strokeColor = UIColor.systemGreen.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd = 0
        view.layer.addSublayer(shape)
        
        let button = UIButton(frame: CGRect(x: 20, y: view.frame.size.height-70, width: view.frame.size.width-40, height: 50))
        view.addSubview(button)
        button.setTitle("Animate", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
    }
    @objc func didTapButton() {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 3
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        shape.add(animation, forKey: "animation")
        
    }
    
    func authorizeHealthKit(){
        
        
            guard HKHealthStore.isHealthDataAvailable() else {
                return
            }
        
        let steptype = Set([HKQuantityType.quantityType(forIdentifier: .stepCount)!])
        let share = Set([HKQuantityType.quantityType(forIdentifier: .stepCount)!])
        healthStore.requestAuthorization(toShare: share, read: steptype) { (chk, error) in
            if (chk){
                print("permission granted")
            }
        }
    }
    
    func getWholeDate(date: Date) -> (startDate: Date, endDate: Date) {
          var startDate = date
          var length = TimeInterval()
          _ = Calendar.current.dateInterval(of: .day, start: &startDate, interval: &length, for: startDate)
          let endDate:Date = startDate.addingTimeInterval(length)
          return(startDate,endDate)
      }
    
    func getStepsCount(forSpecificDate: Date, completion: @escaping (Double) -> Void){
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let(start, end) = self.getWholeDate(date: forSpecificDate)
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) {
             _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        self.healthStore.execute(query)
    }
       
  
    
}
