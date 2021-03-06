/************************************************************
 *  * Hyphenate
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 */

#import "EMConversationModel.h"

#import "EMUserProfileManager.h"

@implementation EMConversationModel

- (instancetype)initWithConversation:(EMConversation*)conversation
{
    self = [super init];
    if (self) {
        _conversation = conversation;
        if (_conversation.type == EMConversationTypeGroupChat) {
            NSArray *groups = [[EMClient sharedClient].groupManager getJoinedGroups];
            for (EMGroup *group in groups) {
                if ([_conversation.conversationId isEqualToString:group.groupId]) {
                    _title = group.subject;
                    break;
                }
            }
        }
    }
    return self;
}

- (NSString*)title
{
    if (_conversation.type == EMConversationTypeChat) {
        return [[EMUserProfileManager sharedInstance] getNickNameWithUsername:_conversation.conversationId];
    } else {
        return _title;
    }
}

@end
