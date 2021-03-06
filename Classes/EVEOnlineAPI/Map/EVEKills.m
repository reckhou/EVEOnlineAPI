//
//  EVEKills.m
//  EVEOnlineAPI
//
//  Created by Artem Shimanski on 8/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EVEKills.h"


@implementation EVEKillsItem

+ (id) killsItemWithXMLAttributes:(NSDictionary *)attributeDict {
	return [[EVEKillsItem alloc] initWithXMLAttributes:attributeDict];
}

- (id) initWithXMLAttributes:(NSDictionary *)attributeDict {
	if (self = [super init]) {
		self.solarSystemID = [[attributeDict valueForKey:@"solarSystemID"] intValue];
		self.shipKills = [[attributeDict valueForKey:@"shipKills"] intValue];
		self.factionKills = [[attributeDict valueForKey:@"factionKills"] intValue];
		self.podKills = [[attributeDict valueForKey:@"podKills"] intValue];
	}
	return self;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt32:self.solarSystemID forKey:@"solarSystemID"];
	[aCoder encodeInt32:self.shipKills forKey:@"shipKills"];
	[aCoder encodeInt32:self.factionKills forKey:@"factionKills"];
	[aCoder encodeInt32:self.podKills forKey:@"podKills"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super init]) {
		self.solarSystemID = [aDecoder decodeInt32ForKey:@"solarSystemID"];
		self.shipKills = [aDecoder decodeInt32ForKey:@"shipKills"];
		self.factionKills = [aDecoder decodeInt32ForKey:@"factionKills"];
		self.podKills = [aDecoder decodeInt32ForKey:@"podKills"];
	}
	return self;
}

@end


@implementation EVEKills

+ (EVEApiKeyType) requiredApiKeyType {
	return EVEApiKeyTypeNone;
}

+ (id) killsWithCachePolicy:(NSURLRequestCachePolicy) cachePolicy error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress, BOOL* stop)) progressHandler {
	return [[EVEKills alloc] initWithCachePolicy:cachePolicy error:errorPtr progressHandler:progressHandler];
}

- (id) initWithCachePolicy:(NSURLRequestCachePolicy) cachePolicy error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress, BOOL* stop)) progressHandler {
	if (self = [super initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/map/Kills.xml.aspx", EVEOnlineAPIHost]]
					   cachePolicy:cachePolicy
							error:errorPtr
				  progressHandler:progressHandler]) {
	}
	return self;
}

#pragma mark NSXMLParserDelegate

- (id) didStartRowset: (NSString*) rowset {
	if ([rowset isEqualToString:@"solarSystems"]) {
		self.solarSystems = [[NSMutableArray alloc] init];
		return self.solarSystems;
	}
	else
		return nil;
}

- (id) didStartRowWithAttributes:(NSDictionary *) attributeDict rowset:(NSString*) rowset rowsetObject:(id) object {
	if ([rowset isEqualToString:@"solarSystems"]) {
		EVEKillsItem *killsItem = [EVEKillsItem killsItemWithXMLAttributes:attributeDict];
		[object addObject:killsItem];
		return killsItem;
	}
	return nil;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.solarSystems forKey:@"solarSystems"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		self.solarSystems = [aDecoder decodeObjectForKey:@"solarSystems"];
	}
	return self;
}

@end