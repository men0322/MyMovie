//
//  HomeViewController.swift
//  MyMovie
//
//  Created by Hung Nguyen on 10/12/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,HomeDelegate ,UISearchBarDelegate{
    @IBOutlet weak var homeTableView: UITableView!
    var homeController  = HomeController()
    var movies: [Class_Movie] =  [Class_Movie]()
    let homeCell: String = "MovieTableViewCell"
    var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 290, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLayout()
        self.createObjective()
        self.registerCell()
    }
    private func initLayout(){
        searchBar.placeholder = "Search"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
    }
    
    private func createObjective(){
        homeTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        homeController.eventHandler = self
        searchBar.delegate = self
        homeController.getMoviesWithType(movieType: .AllList)
    }
    
    private func registerCell(){
        homeTableView.register(UINib(nibName: homeCell, bundle: nil), forCellReuseIdentifier: homeCell)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    //MARK: - TABLEVIEW DELEGATE
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return  self.movies.count
    }
    func  tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellAddView = tableView.dequeueReusableCell(withIdentifier: homeCell) as! MovieTableViewCell
        cellAddView.classMovie = self.movies[indexPath.row]
        return cellAddView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailView.movie = movies[indexPath.row]
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    //MARK: - HOME DELEGATE
    func didEndGetDataFromThemoviedb(movies: [Class_Movie]) {
        self.movies = movies
        homeTableView.reloadData()
    }
    
    //MARK: - SEARCH BAR DELEGATE
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    //MARK: - ACTION CLICK
    @IBAction func actionBar(_ sender: AnyObject) {
        let btn = sender as! UIButton
        movies = [Class_Movie]()
        homeTableView.reloadData()
        homeController.getMoviesWithType(movieType: MovieType(rawValue: btn.tag)!)
    }

}
