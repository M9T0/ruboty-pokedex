require 'net/http'
require 'uri'
require 'json'

module Ruboty
    module Pokedex
        module Actions
            class Pokedex < Ruboty::Actions::Base
                POKEDEX_API = 'http://pokeapi.co/api/v2/'

                def call
                    keyword = message[:number]

                    uri = URI("https://pokeapi.co/api/v2/pokemon-species/#{keyword}/")
                    req = Net::HTTP::Get.new(uri)
                    resp = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') { |http|
                        http.request(req)
                    }
                    puts resp
                    json = JSON.parse(resp.body)

                    id = json['id']
                    name = json['names'].select do |x|
                        x['language']['name'] == "ja"
                    end
                    desc = json['flavor_text_entries'].select do |x|
                        x['language']['name'] == "ja"
                    end
                    res = "No.#{id} #{name[0]}\n#{desc[0]['flavor_text']}"

                    message.reply(res)
                end
            end
        end
    end
end
