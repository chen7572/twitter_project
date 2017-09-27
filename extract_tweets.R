library("twitteR")
library("ROAuth")

setup_twitter_oauth(consumer_key = 'cVBUluS3IOoimaTPNIdImY3Mb',consumer_secret = '5wLp0iX2BLKSzTr2cEidCbetGqyrvop6V0bdFHzoD1lIj292C4',access_token = '386134133-yo24CXeFMGISwW66KD4tiYAnai7n2iTvpDIi7r9i',access_secret = '5uCJ5eeqaXPjPxEY3zvepvM84eiVjaCOa5OdCf6bLEaZ4')

harvey <- searchTwitter("#Harvey",n=3000,lang="en")
irma <- searchTwitter("#Irma",n=3000,lang="en")

harvey2 <- searchTwitter("#Harvey",n=3000,lang="en",since='2017-08-17',until = '2017-08-24')
harvey3 <- searchTwitter("#Harvey",n=3000,lang="en",since='2017-08-17',resultType = 'recent')

