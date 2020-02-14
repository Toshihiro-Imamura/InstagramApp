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

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var commentCaptionLabel: UILabel!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var commentTableViewCell: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    
    
    var postData: PostData!
    var postArray: [PostData] = []
    
    var listener: ListenerRegistration!
    
    @IBAction func commentPostButton(_ sender: Any) {
        let PostRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
        
        SVProgressHUD.show()
        
        //コメントを投稿する
        let commentName = Auth.auth().currentUser?.displayName
        
        let postDic = [
            "comment": "\(commentName!) : \(self.commentTextField.text!)",
            ] as [String: Any]
        
        
        let comment = postDic["comment"]
        let updateValue: FieldValue = FieldValue.arrayUnion([comment!])

        PostRef.updateData(["comment":updateValue])
        
        SVProgressHUD.showSuccess(withStatus: "コメントを投稿しました")
        
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func commentCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.commentCaptionLabel!.text = "\(postData.name!) : \(postData.caption!)"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTableView.delegate = self
        commentTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.comment.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath )
        cell.textLabel!.text = "\(postData.comment[indexPath.row])"
        return cell
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
