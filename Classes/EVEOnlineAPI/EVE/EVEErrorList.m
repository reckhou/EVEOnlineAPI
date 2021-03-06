//
//  EVEErrorList.m
//  EVEOnlineAPI
//
//  Created by Artem Shimanski on 8/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EVEErrorList.h"


@implementation EVEErrorListItem

+ (id) errorListItemWithXMLAttributes:(NSDictionary *)attributeDict {
	return [[EVEErrorListItem alloc] initWithXMLAttributes:attributeDict];
}

- (id) initWithXMLAttributes:(NSDictionary *)attributeDict {
	if (self = [super init]) {
		self.errorCode = [[attributeDict valueForKey:@"errorCode"] intValue];
		self.errorText = [attributeDict valueForKey:@"errorText"];
	}
	return self;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt32:self.errorCode forKey:@"errorCode"];
	[aCoder encodeObject:self.errorText forKey:@"errorText"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super init]) {
		self.errorCode = [aDecoder decodeInt32ForKey:@"errorCode"];
		self.errorText = [aDecoder decodeObjectForKey:@"errorText"];
	}
	return self;
}

@end


@implementation EVEErrorList

+ (EVEApiKeyType) requiredApiKeyType {
	return EVEApiKeyTypeNone;
}

+ (id) errorListWithCachePolicy:(NSURLRequestCachePolicy) cachePolicy error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress, BOOL* stop)) progressHandler {
	return [[EVEErrorList alloc] initWithCachePolicy:cachePolicy error:errorPtr progressHandler:progressHandler];
}

- (id) initWithCachePolicy:(NSURLRequestCachePolicy) cachePolicy error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress, BOOL* stop)) progressHandler {
	if (self = [super initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/eve/ErrorList.xml.aspx", EVEOnlineAPIHost]]
					   cachePolicy:cachePolicy
							error:errorPtr
				  progressHandler:progressHandler]) {
	}
	return self;
}

#pragma mark NSXMLParserDelegate

- (id) didStartRowset: (NSString*) rowset {
	if ([rowset isEqualToString:@"errors"]) {
		self.errors = [[NSMutableArray alloc] init];
		return self.errors;
	}
	else
		return nil;
}

- (id) didStartRowWithAttributes:(NSDictionary *) attributeDict rowset:(NSString*) rowset rowsetObject:(id) object {
	if ([rowset isEqualToString:@"errors"]) {
		EVEErrorListItem *errorListItem = [EVEErrorListItem errorListItemWithXMLAttributes:attributeDict];
		[object addObject:errorListItem];
		return errorListItem;
	}
	return nil;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.errors forKey:@"errors"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		self.errors = [aDecoder decodeObjectForKey:@"errors"];
	}
	return self;
}

@end