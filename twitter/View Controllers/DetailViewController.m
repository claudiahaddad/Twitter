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

@property (strong, nonatomic) NSString *createdAtNewString; // Display date
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
    self.dateLabel.text = self.tweet.createdAtNewString;
}
- (IBAction)didTapLike:(id)sender {

    if (!self.tweet.favorited) {
        self.tweet.favoriteCount += 1;
        [self.favLabel setText:[NSString stringWithFormat:@"%d", self.tweet.favoriteCount]];
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
        self.tweet.favorited = YES;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.tweetText);
            }
        }];
        
    } else {
        self.tweet.favoriteCount -= 1;
        [self.favLabel setText:[NSString stringWithFormat:@"%d", self.tweet.favoriteCount]];
        self.tweet.favorited = NO;
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){ NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{ NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.tweetText);
            }
        }];
    }
}
- (IBAction)didTapRetweet:(id)sender {

    if (!self.tweet.retweeted) {
        self.tweet.retweetCount += 1;
        [self.retweetLabel setText:[NSString stringWithFormat:@"%d", self.tweet.retweetCount]];
        self.tweet.retweeted = YES;
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error reweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.tweetText);
            }
        }];
    }  else {
        self.tweet.retweetCount -= 1;
        [self.retweetLabel setText:[NSString stringWithFormat:@"%d", self.tweet.retweetCount]];
        self.tweet.retweeted = NO;
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){ NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{ NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.tweetText);
            }
        }];
    }
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
