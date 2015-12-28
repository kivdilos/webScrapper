#!/usr/bin/ruby

require 'mechanize'
require 'celluloid/current'

url = "http://192.168.0.10"

$userAgentAliases = {1 =>  "Linux Firefox",
                     2 =>  "Linux Konqueror",
                     3 =>  "Linux Mozilla",
                     4 =>  "Mac Firefox",
                     5 =>  "Mac Mozilla",
                     6 =>  "Mac Safari 4",
                     7 =>  "Mac Safari",
                     8 =>  "Windows Chrome",
                     9 =>  "Windows IE 8",
                    10 =>  "Windows IE 9",
                    11 =>  "Windows Mozilla"}
class Scrapper
  include celluloid

  def search(url)

          agent = Mechanize.new { |agent|
                  agent.user_agent_alias = $userAgentAliases[rand(1..11)]
          }

          puts "\n Starting search in #{url} \n User Agent: #{agent.user_agent} \n\n"
          page = agent.get(url)
          #pp userAgentAliases = rand(1..11)
  end
end

scrape_pool = Scrapper.pool(size: 10)

30_000.times do
  scrape_pool.async.search(url)
end

#search(url)
