//
//  EVEKills.h
//  EVEOnlineAPI
//
//  Created by Artem Shimanski on 8/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVERequest.h"

@interface EVEKillsItem : NSObject<NSCoding>
@property (nonatomic) int32_t solarSystemID;
@property (nonatomic) int32_t shipKills;
@property (nonatomic) int32_t factionKills;
@property (nonatomic) int32_t podKills;

+ (id) killsItemWithXMLAttributes:(NSDictionary *)attributeDict;
- (id) initWithXMLAttributes:(NSDictionary *)attributeDict;

@end


@interface EVEKills : EVERequest
@property (nonatomic, strong) NSArray *solarSystems;

+ (id) killsWithCachePolicy:(NSURLRequestCachePolicy) cachePolicy error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress, BOOL* stop)) progressHandler;
- (id) initWithCachePolicy:(NSURLRequestCachePolicy) cachePolicy error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress, BOOL* stop)) progressHandler;
@end