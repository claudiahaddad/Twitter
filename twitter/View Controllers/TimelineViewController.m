//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DetailViewController.h"


@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *tweetArray;
@end

@implementation TimelineViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];

      [self beginRefresh:refreshControl];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    
            [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
                                                    if (tweets) {
                                                        self.tweetArray = tweets;
                                                        [self.tableView reloadData];
                                                    } else {
                                                        NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
                                                    }
                                                }];
                                                [refreshControl endRefreshing];
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tweet = self.tweetArray[indexPath.row];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetArray.count;
}

- (void)didTweet:(Tweet *)tweet {
    
   [self.tweetArray insertObject:tweet atIndex:0];
   [self.tableView reloadData];
}
- (IBAction)onLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"composeSegue"]) {
 UINavigationController *navigationController = [segue destinationViewController];
 ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
 composeController.delegate = self;
    } else if ([segue.identifier isEqualToString:@"detailSegue"]) {
    TweetCell *tappedCell = sender;
        Tweet *tweet = tappedCell.tweet;
    DetailViewController *detailViewController = [segue destinationViewController];
    detailViewController.tweet = tweet;
    
    NSLog(@"Tapping on a tweet!");
}
}



@end
