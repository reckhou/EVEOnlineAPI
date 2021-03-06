//
//  EVEFacWarSystems.h
//  EVEOnlineAPI
//
//  Created by Artem Shimanski on 8/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVERequest.h"

@interface EVEFacWarSystemsItem : NSObject<NSCoding>
@property (nonatomic) int32_t solarSystemID;
@property (nonatomic, copy) NSString *solarSystemName;
@property (nonatomic) int32_t occupyingFactionID;
@property (nonatomic, copy) NSString *occupyingFactionName;
@property (nonatomic) BOOL contested;

+ (id) facWarSystemsItemWithXMLAttributes:(NSDictionary *)attributeDict;
- (id) initWithXMLAttributes:(NSDictionary *)attributeDict;

@end


@interface EVEFacWarSystems : EVERequest
@property (nonatomic, strong) NSArray *solarSystems;

+ (id) facWarSystemsWithCachePolicy:(NSURLRequestCachePolicy) cachePolicy error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress, BOOL* stop)) progressHandler;
- (id) initWithCachePolicy:(NSURLRequestCachePolicy) cachePolicy error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress, BOOL* stop)) progressHandler;
@end