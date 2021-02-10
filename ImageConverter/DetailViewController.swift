//
//  DetailViewController.swift
//  ImageConverter
//
//  Created by Sanket Marakana on 29/06/19.
//  Copyright © 2019 Sanket Marakana. All rights reserved.
//

import UIKit
import Toaster

class DetailViewController: UIViewController {

    var image_url : URL!
    
    @IBOutlet weak var fullscreen_imageview: UIImageView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fullscreen_imageview.image = UIImage(contentsOfFile: image_url.path)
        let download_button: UIButton = UIButton(type: UIButton.ButtonType.custom) as! UIButton
      
        download_button.setImage(UIImage(named: "download"), for: .normal)
        download_button.addTarget(self, action: #selector(downloadButtonPressed), for: .touchUpInside)
        download_button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        
        
        let share_button: UIButton = UIButton(type: UIButton.ButtonType.custom) as! UIButton
        
        share_button.setImage(UIImage(named: "share"), for: .normal)
        share_button.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        share_button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: download_button)
        let barButton1 = UIBarButtonItem(customView: share_button)
//        assign button to navigationbar
        self.navigationItem.rightBarButtonItems = [barButton,barButton1]
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = NSLocalizedString("Preview", comment: "")
        
    }
    @objc func downloadButtonPressed()
    {
        Toast(text: NSLocalizedString("Image download successfully in photos.", comment: "")).show()
        UIImageWriteToSavedPhotosAlbum(UIImage(contentsOfFile: image_url.path) ?? UIImage(), nil, nil, nil)
    }
    @objc func shareButtonPressed()
    {
        let image = UIImage(contentsOfFile: image_url.path)
        let text  = NSLocalizedString("You can convert iamge into jpeg or png using Simple Image Converter app. It is available at itms-apps://itunes.apple.com/app/1470771922", comment: "")
        let imageShare = [ image!,text ] as [Any]
        let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    

}
