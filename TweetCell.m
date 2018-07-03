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
    
    self.tweetLabel.text = self.tweet.tweetText;
    self.dateLabel.text = self.tweet.createdAtString;
    self.profilePic.image = nil;
    if (self.tweet.user.picURL != nil) {
        [self.profilePic setImageWithURL:self.tweet.user.picURL];
        self.userName.text = self.tweet.user.name;
        self.handle.text = self.tweet.user.screenName;
    // Initialization code
}
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
   self.tweetLabel.text = self.tweet.tweetText;
   self.dateLabel.text = self.tweet.createdAtString;
    self.profilePic.image = nil;
    if (self.tweet.user.picURL != nil) {
      [self.profilePic setImageWithURL:self.tweet.user.picURL];
    self.userName.text = self.tweet.user.name;
    self.handle.text = self.tweet.user.screenName;
    
    }
}


@end
