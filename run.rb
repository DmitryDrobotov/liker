load 'workers/liker_worker.rb'

config = YAML.load(File.open('./config/config.yml'))
input_file = File.new(config['input_filename'], 'r')

input_file.each_line do |line|
  sleep 0.01
  user_id = line.to_i
  LikerWorker.perform_async(config['application_token'], user_id, config['page_id'])
end

input_file.close