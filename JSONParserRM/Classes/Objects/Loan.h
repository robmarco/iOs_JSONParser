//
//  Loan.h
//  JSONParserRM
//
//  Created by Roberto Marco on 21/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//
//      Loan Model as JSON Response
//          http://api.kivaws.org/v1/loans/search.json?status=fundraising
//
//
//      "loans": [
//            {
//                "id": 685789,
//                "name": "Mary Jane",
//                "description": {
//                    "languages": [
//                                  "en"
//                                  ]
//                },
//                "status": "fundraising",
//                "funded_amount": 0,
//                "basket_amount": 0,
//                "image": {
//                    "id": 1562653,
//                    "template_id": 1
//                },
//                "activity": "Cereals",
//                "sector": "Food",
//                "use": "to purchase additional sacks of rice grains to sell",
//                "location": {
//                    "country_code": "PH",
//                    "country": "Philippines",
//                    "town": "Cauayan, Negros Occidental",
//                    "geo": {
//                        "level": "country",
//                        "pairs": "13 122",
//                        "type": "point"
//                    }
//                },
//                "partner_id": 145,
//                "posted_date": "2014-03-21T11:30:02Z",
//                "planned_expiration_date": "2014-04-20T11:30:02Z",
//                "loan_amount": 375,
//                "borrower_count": 1,
//                "lender_count": 0,
//                "bonus_credit_eligibility": true
//            },
//

#import <Foundation/Foundation.h>

@interface Loan : NSObject

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *status;
// @property descriptions
@property (nonatomic, strong) NSNumber *funded_amount;
@property (nonatomic, strong) NSNumber *basket_amount;
//@property image
@property (nonatomic, strong) NSString *activity;
@property (nonatomic, strong) NSString *sector;
@property (nonatomic, strong) NSString *use;
// @property location
@property (nonatomic, strong) NSNumber *partner_id;
@property (nonatomic, strong) NSDate *posted_date;
@property (nonatomic, strong) NSDate *planned_expiration_date;
@property (nonatomic, strong) NSNumber *loan_amount;
@property (nonatomic, strong) NSNumber *borrower_count;
@property (nonatomic, strong) NSNumber *lender_count;
@property () BOOL bonus_credit_eligibility;

@end
