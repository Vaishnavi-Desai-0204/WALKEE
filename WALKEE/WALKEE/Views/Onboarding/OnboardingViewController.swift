//
//  OnboardingViewController.swift
//  WALKEE
//
//  Created by Vikas desai  on 09/04/22.
//  Copyright © 2022 Vaishnavi desai. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("GET STARTED", for: .normal)
            } else{
                nextBtn.setTitle("NEXT", for: .normal)
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
      slides = [
        OnboardingSlide(title: "Contribute your every step to the future", description: "As your steps grow ,so will your tree", image: #imageLiteral(resourceName: "group_of_trees-removebg-preview")),
        OnboardingSlide(title: "Travel the world on your foot", description: "Join the race with your friends and family ", image: #imageLiteral(resourceName: "cartoon-earth-with-trees-vector-31778642-modified-removebg-preview (1)")),
        
        ]
        pageControl.numberOfPages = slides.count
    }


    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(identifier: "HomeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
            print("go to next page")
        } else {
           //fix this part
        }
        
        print("clicked")
        
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath)as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
}
