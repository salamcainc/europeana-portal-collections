namespace :jobs do
  namespace :cache do
    desc 'Queue Cache::ColourFacetsJob'
    task colour_facets: :environment do
      Cache::ColourFacetsJob.perform_later
      Collection.published.each do |collection|
        Cache::ColourFacetsJob.perform_later(collection.id)
      end
    end

    desc 'Queue Cache::RecordCountsJob'
    task record_counts: :environment do
      Cache::RecordCountsJob.perform_later
      Collection.published.each do |collection|
        Cache::RecordCountsJob.perform_later(collection.id, types: true)
      end
    end

    desc 'Queue Cache::RecordCounts::RecentAdditionsJob'
    task recent_additions: :environment do
      Cache::RecordCounts::RecentAdditionsJob.perform_later
      Collection.published.each do |collection|
        Cache::RecordCounts::RecentAdditionsJob.perform_later(collection.id)
      end
    end

    desc 'Queue Cache::RecordCounts::ProvidersJob'
    task providers: :environment do
      Cache::RecordCounts::ProvidersJob.perform_later
      Collection.published.each do |collection|
        Cache::RecordCounts::ProvidersJob.perform_later(collection.id)
      end
    end

    desc 'Queue Cache::Feed jobs (blogs / exhibitions / Tumblr)'
    task feeds: :environment do
      Cache::FeedJob::URLS[:blog].values.each do |url|
        Cache::Feed::BlogJob.perform_later(url)
      end
      Cache::FeedJob::URLS[:exhibitions].values.each do |url|
        Cache::FeedJob.perform_later(url)
      end
      Cache::FeedJob::URLS[:tumblr].values.each do |url|
        Cache::Feed::BlogJob.perform_later(url)
      end
    end
  end
end
