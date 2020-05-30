module ShelvesHelper

    def impression_times(book_id)
        impressions = Impression.where(user_id: current_user.id,
                                       book_id: book_id)
        impressions.length
    end

    def tweet_times(book_id)
        tweets = Impression.where(user_id: current_user.id,
                                  book_id: book_id,
                                  tweeted_flg: 1)
        tweets.length
    end

end
