//
//  DetailViewController.m
//  twitter
//
//  Created by Claudia Haddad on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "DetailViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "TimelineViewController.h"
#import "APIManager.h"
#import "NSDate+DateTools.h"


@interface DetailViewController ()

@property (strong, nonatomic) NSString *createdAtOriginalString; // Display date
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *userHandle;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIButton *retweetButton;
@property (strong, nonatomic) IBOutlet UILabel *retweetLabel;
@property (strong, nonatomic) IBOutlet UIButton *favButton;
@property (strong, nonatomic) IBOutlet UILabel *favLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *tweetLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //_tweet = tweet;
    //NAME,HANDLE, PIC
    self.userName.text = self.tweet.user.name;
    self.userHandle.text = self.tweet.user.screenName;
    self.tweetLabel.text = self.tweet.tweetText;
    
    [self.profilePic setImageWithURL:self.tweet.user.picURL];
    //RETWEETS & FAVORITES
    [self.favLabel setText:[NSString stringWithFormat:@"%d", self.tweet.favoriteCount]];
    [self.retweetLabel setText:[NSString stringWithFormat:@"%d", self.tweet.retweetCount]];

    //DATE
    self.dateLabel.text = self.createdAtOriginalString;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
