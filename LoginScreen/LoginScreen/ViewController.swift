//
//  ViewController.swift
//  LoginScreen
//
//  Created by 萧奇 on 2018/4/14.
//  Copyright © 2018年 萧奇. All rights reserved.
//

import UIKit

func delay(_ seconds: Double, completion: @escaping () ->Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud4: UIImageView!
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    let message = ["连接中...", "授权中...", "发送证书...", "失败"]
    
    var messageStatus = CGPoint.zero
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel.center.x -= view.bounds.width
        username.center.x -= view.bounds.width
        password.center.x -= view.bounds.width
        
        cloud1.alpha = 0
        cloud2.alpha = 0
        cloud3.alpha = 0
        cloud4.alpha = 0
        
        loginButton.center.y += 30.0
        loginButton.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        moveAnimation(delayTime: 0.3, imageView: titleLabel)
        moveAnimation(delayTime: 0.4, imageView: username)
        moveAnimation(delayTime: 0.5, imageView: password)
        
        alphaAnimation(delayTime: 0.5, imageView: cloud1)
        alphaAnimation(delayTime: 0.7, imageView: cloud2)
        alphaAnimation(delayTime: 0.9, imageView: cloud3)
        alphaAnimation(delayTime: 1.1, imageView: cloud4)
        
        // usingSpringWithDamping 弹簧  initialSpringVelocity 初始速度
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.loginButton.center.y -= 30.0
            self.loginButton.alpha = 1.0
        }, completion: nil)
        
        cloudAnimation(cloud: cloud1)
        cloudAnimation(cloud: cloud2)
        cloudAnimation(cloud: cloud3)
        cloudAnimation(cloud: cloud4)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginButton.addSubview(spinner)
        
        status.isHidden = true
        status.center = loginButton.center
        view.addSubview(status)
        
        label.frame = CGRect(x: 0, y: 0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .center
        status.addSubview(label)
        
        messageStatus = loginButton.center
    }
    
    func showMessage(index: Int) {
        label.text = message[index]
        
        UIView.transition(with: status, duration: 0.33, options: [.curveEaseOut, .transitionCurlDown], animations: {
            self.status.isHidden = false
        }) { (_) in
            delay(2.0) {
                if index < self.message.count - 1 {
                    self.removeMessage(index: index)
                } else {
                    self.resetForm()
                }
            }
        }
    }
    
    func resetForm() {
        UIView.transition(with: status, duration: 0.2, options: .transitionCurlUp, animations: {
            self.status.isHidden = true
            self.status.center = self.messageStatus
        }, completion: nil)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
            self.spinner.center = CGPoint(x: -20.0, y: -16.0)
            self.spinner.isHidden = true
            self.loginButton.backgroundColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
            self.loginButton.bounds.size.width -= 80.0
            self.loginButton.center.y -= 60.0
        }, completion: nil)
    }
    
    func removeMessage(index: Int) {
        UIView.animate(withDuration: 0.33, delay: 0, options: [], animations: {
            self.status.center.x += self.view.frame.width
        }) { (_) in
            self.status.isHidden = true
            self.status.center = self.messageStatus
            
            self.showMessage(index: index + 1)
        }
    }
    
    func cloudAnimation(cloud: UIImageView) {
        let cloudSpeed = 60.0 / view.frame.size.width
        let duration = (view.frame.size.width - cloud.frame.origin.x) * cloudSpeed
        UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, options: [], animations: {
            cloud.frame.origin.x = self.view.frame.size.width
        }, completion: {(_) in
            cloud.frame.origin.x = -cloud.frame.size.width
            self.cloudAnimation(cloud: cloud)
        })
        
    }
    
    func moveAnimation(delayTime: TimeInterval, imageView: UIView) {
        UIView.animate(withDuration: 0.5, delay: delayTime, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [], animations: {
            imageView.center.x += self.view.bounds.width
        }, completion: nil)
    }
    
    func alphaAnimation(delayTime: TimeInterval, imageView: UIImageView) {
        UIView.animate(withDuration: 0.5, delay: delayTime, options: [], animations: {
            imageView.alpha = 1.0;
        }, completion: nil)
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        view.endEditing(true)
        
        UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.bounds.size.width += 80.0
        }, completion: { _ in
            self.showMessage(index: 0)
        })
        
        UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.center.y += 60.0
            self.loginButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
            self.spinner.center = CGPoint(
                x: 40.0,
                y: self.loginButton.frame.size.height/2
            )
            self.spinner.alpha = 1.0
        }, completion: nil)
    }
    


}

