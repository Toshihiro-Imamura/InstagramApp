//
//  CommentViewController.swift
//  Instagram
//
//  Created by 今村俊博 on 2020/02/06.
//  Copyright © 2020 toshihiro.imamura. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    
    var postData: PostData!
    
    var listener: ListenerRegistration!
    
    @IBAction func commentPostButton(_ sender: Any) {
        let PostRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
        
        SVProgressHUD.show()
        
        //コメントを投稿する
        let commentName = Auth.auth().currentUser?.displayName
        
        let postDic = [
            "comment": "\(commentName!) : \(self.commentTextField.text!)",
            ] as [String: String]
        
        PostRef.updateData(postDic, completion: nil)
        
        SVProgressHUD.showSuccess(withStatus: "コメントを投稿しました")
        
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func commentCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.commentCaptionLabel!.text = "\(postData.name!) : \(postData.caption!)"
        //self.commentLabel!.text = "\(postData.commentName!) : \(postData.comment!)"
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
