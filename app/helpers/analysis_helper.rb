module AnalysisHelper

    def start_reading_count(id)
        books = Book.where(user_id: id)
        count = books.where.not(reading_start_date: nil).count
        count.to_s(:delimited)
    end

    def finish_reading_count(id)
        books = Book.where(user_id: id)
        count = books.where.not(reading_end_date: nil).count
        count.to_s(:delimited)
    end

    def impression_count(id)
        count = Impression.where(user_id: id).count
        count.to_s(:delimited)
    end

    def impression_letters(id)
        impressions = Impression.where(user_id: id)
        count = 0
        impressions.each do |impression|
            count += impression.impression.length
        end
        count.to_s(:delimited)
    end

    def tweet_count(id)
        count  = Impression.where(user_id: id).where.not(tweeted_time: nil).count
        count.to_s(:delimited)
    end

    def liked_count(id)
        impressions = Impression.where(user_id: id)
        count = 0
        impressions.each do |impression|
            count += impression.like_count
        end
        count.to_s(:delimited)
    end

end
