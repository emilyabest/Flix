//
//  MoviesViewController.m
//  Flix2
//
//  Created by emilyabest on 6/26/19.
//  Copyright © 2019 emilyabest. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController2.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UISearchController *searchController;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *filteredData;

@end

@implementation MoviesViewController

/**
 Loads the view.
 */
- (void)viewDidLoad {
    // Initialize?
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Fill the movies initially
    [self fetchMovies];
    
    // Refresh the list when user pulls down
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    // Set cell height
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Initializing with searchResultsController set to nil means that
    // searchController will use this view controller to display the search results
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    
    // If we are using this same view controller to present the results
    // dimming it out wouldn't make sense. Should probably only set
    // this to yes if using another controller to display the search results.
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    // Make search bar visible on the top of the screen
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // Sets this view controller as presenting view controller for the search interface
    self.definesPresentationContext = YES;
}

/**
 Gets a list of movies.
 */
- (void)fetchMovies {
    // Start the activity indicator (appears when first opening app)
    [self.activityIndicator startAnimating];
    
    // Access the website
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // If movies can't be loaded, print error message
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            
            // Display network signal error (1-3)
            // 1. Create the UIAlertController
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please connect to the internet." preferredStyle:UIAlertControllerStyleAlert];
            
            // 2. Add buttons
            // Create a cancel action
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                // Handle cancel response here. Doing nothing will dismiss the view.
            }];
            // Add the cancel action to the alertController
            [alert addAction:cancelAction];
            // Create an OK action
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // handle response here. NOTE: cannot cancel app, Apple will not allow
            }];
            // Add the OK action to the alert controller
            [alert addAction:okAction];
            
            // 3. Show the UIAlertController
            [self presentViewController:alert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
            }];
        }
        else {
            // Fill movies array with data from dictionary
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.movies = dataDictionary[@"results"];
            self.filteredData = self.movies;
            
            // Reload table view
            [self.tableView reloadData];
        }
        
        // Stop refresh
        [self.refreshControl endRefreshing];
        
        // Stop the activity indicator, hides automatically if "Hides When Stopped" is enabled
        [self.activityIndicator stopAnimating];
        
    }];
    [task resume];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
/**
 Passes info of tapped movie to DetailsViewController
 In a storyboard-based application, you will often want to do a little preparation before navigation
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Access tapped movie cell
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    NSDictionary *movie = self.filteredData[indexPath.row];
    
    // Pass selected movie to the new view controller
    DetailsViewController2 *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie;
}

/**
 Table contains the number of movies in the search results
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredData.count;
}

/**
 Fill table view
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Access next cell
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    // Fill movie titles and synposes
    NSDictionary *movie = self.filteredData[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"overview"];
    
    // Fill movie posters
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    cell.posterView.image = nil;
    [cell.posterView setImageWithURL:posterURL];
    
    return cell;
}

/**
 Updates search results as it finds the movies
 */
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // Identify if the user is searching
    NSString *searchText = searchController.searchBar.text;
    if (searchText) {
        // User has entered text, find titles that contain their search query
        if (searchText.length != 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title contains[cd] %@", searchText];
            self.filteredData = [self.movies filteredArrayUsingPredicate:predicate];
        }
        // User has not entered any text
        else {
            self.filteredData = self.movies;
        }
    }
    // Reload the data
    [self.tableView reloadData];
}

@end
