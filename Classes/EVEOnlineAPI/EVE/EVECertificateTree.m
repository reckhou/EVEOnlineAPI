//
//  EVECertificateTree.m
//  EVEOnlineAPI
//
//  Created by Artem Shimanski on 8/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EVECertificateTree.h"


@implementation EVECertificateTreeItem

+ (id) certificateTreeItemWithXMLAttributes:(NSDictionary *)attributeDict {
	return [[EVECertificateTreeItem alloc] initWithXMLAttributes:attributeDict];
}

- (id) initWithXMLAttributes:(NSDictionary *)attributeDict {
	if (self = [super init]) {
		self.categoryID = [[attributeDict valueForKey:@"categoryID"] intValue];
		self.categoryName = [attributeDict valueForKey:@"categoryName"];
	}
	return self;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt32:self.categoryID forKey:@"categoryID"];
	[aCoder encodeObject:self.categoryName forKey:@"categoryName"];
	[aCoder encodeObject:self.classes forKey:@"classes"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super init]) {
		self.categoryID = [aDecoder decodeInt32ForKey:@"categoryID"];
		self.categoryName = [aDecoder decodeObjectForKey:@"categoryName"];
		self.classes = [aDecoder decodeObjectForKey:@"classes"];
	}
	return self;
}

@end


@implementation EVECertificateTreeClassesItem

+ (id) certificateTreeClassesItemWithXMLAttributes:(NSDictionary *)attributeDict {
	return [[EVECertificateTreeClassesItem alloc] initWithXMLAttributes:attributeDict];
}

- (id) initWithXMLAttributes:(NSDictionary *)attributeDict {
	if (self = [super init]) {
		self.classID = [[attributeDict valueForKey:@"classID"] intValue];
		self.className = [attributeDict valueForKey:@"className"];
	}
	return self;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt32:self.classID forKey:@"classID"];
	[aCoder encodeObject:self.className forKey:@"className"];
	[aCoder encodeObject:self.certificates forKey:@"certificates"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super init]) {
		self.classID = [aDecoder decodeInt32ForKey:@"classID"];
		self.className = [aDecoder decodeObjectForKey:@"className"];
		self.certificates = [aDecoder decodeObjectForKey:@"certificates"];
	}
	return self;
}

@end


@implementation EVECertificateTreeCertificatesItem

+ (id) certificateTreeCertificatesItemWithXMLAttributes:(NSDictionary *)attributeDict {
	return [[EVECertificateTreeCertificatesItem alloc] initWithXMLAttributes:attributeDict];
}

- (id) initWithXMLAttributes:(NSDictionary *)attributeDict {
	if (self = [super init]) {
		self.certificateID = [[attributeDict valueForKey:@"certificateID"] intValue];
		self.grade = [[attributeDict valueForKey:@"grade"] intValue];
		self.corporationID = [[attributeDict valueForKey:@"corporationID"] intValue];
		self.description = [attributeDict valueForKey:@"description"];
	}
	return self;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt32:self.certificateID forKey:@"certificateID"];
	[aCoder encodeInt32:self.grade forKey:@"grade"];
	[aCoder encodeInt32:self.corporationID forKey:@"corporationID"];
	[aCoder encodeObject:self.description forKey:@"description"];
	[aCoder encodeObject:self.requiredSkills forKey:@"requiredSkills"];
	[aCoder encodeObject:self.requiredCertificates forKey:@"requiredCertificates"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super init]) {
		self.certificateID = [aDecoder decodeInt32ForKey:@"certificateID"];
		self.grade = [aDecoder decodeInt32ForKey:@"grade"];
		self.corporationID = [aDecoder decodeInt32ForKey:@"corporationID"];
		self.description = [aDecoder decodeObjectForKey:@"description"];
		self.requiredSkills = [aDecoder decodeObjectForKey:@"requiredSkills"];
		self.requiredCertificates = [aDecoder decodeObjectForKey:@"requiredCertificates"];
	}
	return self;
}

@end


@implementation EVECertificateTreeRequiredSkillsItem

+ (id) certificateTreeRequiredSkillsItemWithXMLAttributes:(NSDictionary *)attributeDict {
	return [[EVECertificateTreeRequiredSkillsItem alloc] initWithXMLAttributes:attributeDict];
}

- (id) initWithXMLAttributes:(NSDictionary *)attributeDict {
	if (self = [super init]) {
		self.typeID = [[attributeDict valueForKey:@"typeID"] intValue];
		self.skillLevel = [[attributeDict valueForKey:@"skillLevel"] intValue];
	}
	return self;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt32:self.typeID forKey:@"typeID"];
	[aCoder encodeInt32:self.skillLevel forKey:@"skillLevel"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super init]) {
		self.typeID = [aDecoder decodeInt32ForKey:@"typeID"];
		self.skillLevel = [aDecoder decodeInt32ForKey:@"skillLevel"];
	}
	return self;
}

@end


@implementation EVECertificateTreeRequiredCertificatesItem

+ (id) certificateTreeRequiredCertificatesItemWithXMLAttributes:(NSDictionary *)attributeDict {
	return [[EVECertificateTreeRequiredCertificatesItem alloc] initWithXMLAttributes:attributeDict];
}

- (id) initWithXMLAttributes:(NSDictionary *)attributeDict {
	if (self = [super init]) {
		self.certificateID = [[attributeDict valueForKey:@"certificateID"] intValue];
		self.grade = [[attributeDict valueForKey:@"grade"] intValue];
	}
	return self;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt32:self.certificateID forKey:@"certificateID"];
	[aCoder encodeInt32:self.grade forKey:@"grade"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super init]) {
		self.certificateID = [aDecoder decodeInt32ForKey:@"certificateID"];
		self.grade = [aDecoder decodeInt32ForKey:@"grade"];
	}
	return self;
}

@end


@implementation EVECertificateTree

+ (EVEApiKeyType) requiredApiKeyType {
	return EVEApiKeyTypeNone;
}

+ (id) certificateTreeWithCachePolicy:(NSURLRequestCachePolicy) cachePolicy error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress, BOOL* stop)) progressHandler {
	return [[EVECertificateTree alloc] initWithCachePolicy:cachePolicy error:errorPtr progressHandler:progressHandler];
}

- (id) initWithCachePolicy:(NSURLRequestCachePolicy) cachePolicy error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress, BOOL* stop)) progressHandler {
	if (self = [super initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/eve/CertificateTree.xml.aspx", EVEOnlineAPIHost]]
					   cachePolicy:cachePolicy
							error:errorPtr
				  progressHandler:progressHandler]) {
	}
	return self;
}

#pragma mark NSXMLParserDelegate

- (id) didStartRowset: (NSString*) rowset {
	if ([rowset isEqualToString:@"categories"]) {
		self.categories = [[NSMutableArray alloc] init];
		return self.categories;
	}
	else if ([rowset isEqualToString:@"classes"]) {
		NSMutableArray *classes = [[NSMutableArray alloc] init];
		[self.currentRow setClasses:classes];
		return classes;
	}
	else if ([rowset isEqualToString:@"certificates"]) {
		NSMutableArray *certificates = [[NSMutableArray alloc] init];
		[self.currentRow setCertificates:certificates];
		return certificates;
	}
	else if ([rowset isEqualToString:@"requiredSkills"]) {
		NSMutableArray *requiredSkills = [[NSMutableArray alloc] init];
		[self.currentRow setRequiredSkills:requiredSkills];
		return requiredSkills;
	}
	else if ([rowset isEqualToString:@"requiredCertificates"]) {
		NSMutableArray *requiredCertificates = [[NSMutableArray alloc] init];
		[self.currentRow setRequiredCertificates:requiredCertificates];
		return requiredCertificates;
	}
	else
		return nil;
}

- (id) didStartRowWithAttributes:(NSDictionary *) attributeDict rowset:(NSString*) rowset rowsetObject:(id) object {
	if ([rowset isEqualToString:@"categories"]) {
		EVECertificateTreeItem *certificateTreeItem = [EVECertificateTreeItem certificateTreeItemWithXMLAttributes:attributeDict];
		[object addObject:certificateTreeItem];
		return certificateTreeItem;
	}
	else if ([rowset isEqualToString:@"classes"]) {
		EVECertificateTreeClassesItem *certificateTreeClassesItem = [EVECertificateTreeClassesItem certificateTreeClassesItemWithXMLAttributes:attributeDict];
		[object addObject:certificateTreeClassesItem];
		return certificateTreeClassesItem;
	}
	else if ([rowset isEqualToString:@"certificates"]) {
		EVECertificateTreeCertificatesItem *certificateTreeCertificatesItem = [EVECertificateTreeCertificatesItem certificateTreeCertificatesItemWithXMLAttributes:attributeDict];
		[object addObject:certificateTreeCertificatesItem];
		return certificateTreeCertificatesItem;
	}
	else if ([rowset isEqualToString:@"requiredSkills"]) {
		EVECertificateTreeRequiredSkillsItem *certificateTreeRequiredSkillsItem = [EVECertificateTreeRequiredSkillsItem certificateTreeRequiredSkillsItemWithXMLAttributes:attributeDict];
		[object addObject:certificateTreeRequiredSkillsItem];
		return certificateTreeRequiredSkillsItem;
	}
	else if ([rowset isEqualToString:@"requiredCertificates"]) {
		EVECertificateTreeRequiredCertificatesItem *certificateTreeRequiredCertificatesItem = [EVECertificateTreeRequiredCertificatesItem certificateTreeRequiredCertificatesItemWithXMLAttributes:attributeDict];
		[object addObject:certificateTreeRequiredCertificatesItem];
		return certificateTreeRequiredCertificatesItem;
	}
	return nil;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.categories forKey:@"categories"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		self.categories = [aDecoder decodeObjectForKey:@"categories"];
	}
	return self;
}

@end