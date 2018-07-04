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



@end
