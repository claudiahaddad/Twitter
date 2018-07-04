//
//  Tweet.h
//  twitter
//
//  Created by Claudia Haddad on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *idStr;
@property (strong, nonatomic) NSString *tweetText;
@property (nonatomic) int favoriteCount;
@property (nonatomic) BOOL favorited;
@property (nonatomic) int retweetCount;
@property (nonatomic) int replyCount;
@property (nonatomic) BOOL retweeted;
@property (strong, nonatomic) User *user;
@property (strong,nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *createdAtString;
@property (strong, nonatomic) NSURL *picURL;

@property (strong,nonatomic) User *retweetedByUser;

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
