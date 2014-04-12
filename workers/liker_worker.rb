require 'sidekiq'
load './like_fetcher.rb'

class LikerWorker
  include Sidekiq::Worker
  sidekiq_options queue: :liker

  def perform(access_token, user_id, page_id)
    config = YAML.load(File.open('./config/config.yml'))
    if LikeFetcher.new(access_token, user_id, page_id).liked?
      output_file = File.new(config['output_filename'], 'a')
      output_file.puts user_id
      output_file.close
    end
  end
end