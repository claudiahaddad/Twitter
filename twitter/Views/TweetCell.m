//
//  TweetCell.m
//  twitter
//
//  Created by Claudia Haddad on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"


@implementation TweetCell
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
   self.tweetLabel.text = self.tweet.tweetText;
   self.dateLabel.text = self.tweet.createdAtString;
   [self.profilePic setImageWithURL:self.tweet.user.picURL];
    [self.favoritesLabel setText:[NSString stringWithFormat:@"%d", self.tweet.favoriteCount]];
    [self.retweetsLabel setText:[NSString stringWithFormat:@"%d", self.tweet.retweetCount]];
    [self.replyLabel setText:[NSString stringWithFormat:@"%d", self.tweet.replyCount]];
    
    self.userName.text = self.tweet.user.name;
    self.handle.text = self.tweet.user.screenName;
    
    }

- (IBAction)didTapLike:(id)sender {
    if (!self.tweet.favorited) {
        self.tweet.favoriteCount += 1;
    [self.favoritesLabel setText:[NSString stringWithFormat:@"%d", self.tweet.favoriteCount]];
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
        [self.favoritesLabel setText:[NSString stringWithFormat:@"%d", self.tweet.favoriteCount]];
        self.tweet.favorited = NO;
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
        [self.retweetsLabel setText:[NSString stringWithFormat:@"%d", self.tweet.retweetCount]];
        self.tweet.retweeted = YES;
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
        [self.retweetsLabel setText:[NSString stringWithFormat:@"%d", self.tweet.retweetCount]];
        self.tweet.retweeted = NO;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){ NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{ NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.tweetText);
            }
        }];
    }
}




@end
