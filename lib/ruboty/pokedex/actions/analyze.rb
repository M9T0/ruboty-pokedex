require 'faraday'
require 'faraday_middleware'

module Ruboty
    module Actions
        class Pokedex < Base
            POKEDEX_API = 'http://pokeapi.co/api/v2/'

            def search_name
                keyword = message.body.find(/\b(P?<name>\w+)$/)
                resp = connection.get(POKEDEX_API + "pokemon-species/#{keyword}")

                id = resp.body['id']
                name = resp.body['names'].select do |x|
                    x.language.name == "ja"
                end
                desc = resp.body['flavor_text_entries'].select do |x|
                    x.language.name = "ja"
                end
                res = "No.#{id} #{name[0]}\n#{desc[0]}"

                res
            end

            def search_num
                message.body
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
