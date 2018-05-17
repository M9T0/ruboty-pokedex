require 'faraday'
require 'faraday_middleware'

module Ruboty
    module Pokedex
        module Actions
            class Pokedex < Ruboty::Actions::Base
                POKEDEX_API = 'http://pokeapi.co/api/v2/'

                def call
                    keyword = message[:number]
                    resp = connection.get(POKEDEX_API + "pokemon-species/#{keyword}")

                    id = resp.body['id']
                    name = resp.body['names'].select do |x|
                        x.language.name == "ja"
                    end
                    desc = resp.body['flavor_text_entries'].select do |x|
                        x.language.name = "ja"
                    end
                    res = "No.#{id} #{name[0]}\n#{desc[0]}"

                    message.reply(res)
                end

                def connection
                    Faraday.new do |connection|
                        connection.adapter :net_http
                        connection.response :json
                    end
                end
            end
        end
    end
end
