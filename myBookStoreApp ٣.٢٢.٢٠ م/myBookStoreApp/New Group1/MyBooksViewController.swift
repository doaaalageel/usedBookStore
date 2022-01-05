//
//  MyBooksViewController.swift
//  myBookStoreApp
//
//  Created by Dua'a ageel on 02/06/1443 AH.
//

import UIKit
import Firebase
class MyBooksViewController: UIViewController {
    
    
    var posts = [Post]()
    var selectedPost:Post?
    var selectedPostImage:UIImage?
    
    @IBOutlet weak var myBooksTableView: UITableView! {
        didSet {
            myBooksTableView.delegate = self
            myBooksTableView.dataSource = self
            myBooksTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
        }
    }

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()

        // Do any additional setup after loading the view.
    }
    func getPosts() {
        self.myBooksTableView.reloadData()
        let ref = Firestore.firestore()
        ref.collection("posts").whereField("userId", isEqualTo: Auth.auth().currentUser!.uid).order(by: "createdAt",descending: true).addSnapshotListener {snapshot, error  in
                if let error = error {
                    print("DB ERROR Posts",error.localizedDescription)
                }
                if let snapshot = snapshot {
                    snapshot.documentChanges.forEach { diff in
                        let post = diff.document.data()
                        switch diff.type {
                        case .added :
                            if let userId = post["userId"] as? String {
                                ref.collection("users").document(userId).getDocument { userSnapshot, error in
                                    if let error = error {
                                        print("ERROR user Data",error.localizedDescription)
                                        
                                    }
                                    if let userSnapshot = userSnapshot,
                                       let userData = userSnapshot.data(){
                                        let user = User(dict:userData)
                                        let post = Post(dict:post,id:diff.document.documentID,user:user)
                                        self.posts.insert(post, at: 0)
                                        DispatchQueue.main.async {
                                            self.myBooksTableView.reloadData()
                                        }
                                        
                                    }
                                }
                            }
                            case .modified:
                            let postId = diff.document.documentID
                            if let currentPost = self.posts.first(where: {$0.id == postId}),
                               let updateIndex = self.posts.firstIndex(where: {$0.id == postId}){
                                let newPost = Post(dict:post, id: postId, user: currentPost.user)
                                self.posts[updateIndex] = newPost
                                DispatchQueue.main.async {
                                    self.myBooksTableView.reloadData()
                                }
                            }
                        case .removed:
                            let postId = diff.document.documentID
                            if let deleteIndex = self.posts.firstIndex(where: {$0.id == postId}){
                                self.posts.remove(at: deleteIndex)
                                DispatchQueue.main.async {
                                    self.myBooksTableView.reloadData()
                                }
                            }
                            }
                        }
                    }
                }
            }
    
    
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let identifier = segue.identifier {
        if identifier == "toPostVC" {
            let vc = segue.destination as! PostViewController
            vc.selectedPost = selectedPost
            vc.selectedPostImage = selectedPostImage
        }else {
            let vc = segue.destination as! DetailsViewController
            vc.selectedPost = selectedPost
            vc.selectedPostImage = selectedPostImage
        }
    }
 
}
}



        extension MyBooksViewController: UITableViewDataSource {
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return posts.count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
                return cell.configure(with: posts[indexPath.row])
            }
            
            
        }
        extension MyBooksViewController: UITableViewDelegate {
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 200
            }
        }

