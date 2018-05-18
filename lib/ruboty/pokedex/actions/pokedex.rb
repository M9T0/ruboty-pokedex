require 'net/http'
require 'json'
require 'uri'

require "ruboty/pokedex/data"

module Ruboty
    module Pokedex
        module Actions
            class Pokedex < Ruboty::Actions::Base
                NAMESPACE = 'POKEDEX'
                POKEDEX_API = 'https://pokeapi.co/api/v2/'

                def brain
                    message.robot.brain.data[NAMESPACE] ||= {}
                end

                def call
                    keyword = message[:number]

                    root = get(POKEDEX_API + "pokemon/#{keyword}/")
                    json = get(root['species']['url'])
                    id = json['id']
                    name = json['names'].find do |x|
                        x['language']['name'] == "ja" ||
                        x['language']['name'] == "ja-Hrkt"
                    end
                    desc = json['flavor_text_entries'].select do |x|
                        x['language']['name'] == "ja"
                    end
                    res = "No.#{id} #{name['name']}\n\n"
                    desc.each do |item|
                        vers = get(item['version']['url'])
                        ver = vers['names'].find do |x|
                            x['language']['name'] == "ja-Hrkt"
                        end
                        if ver == nil
                            res += "#{item['flavor_text']}\n～ポケットモンスター #{item['version']['name']} より～\n\n"
                        else
                            res += "#{item['flavor_text']}\n～ポケットモンスター #{ver['name']} より～\n\n"
                        end
                    end
                    res += root['sprites']['front_default']

                    message.reply(res)
                end

                def get(url)
                    if brain.has_key?(url)
                        brain[url]
                    else
                        uri = URI(url)
                        req = Net::HTTP::Get.new(uri)
                        resp = Net::HTTP.start(uri.host, uri.port, :use_ssl => true) { |http|
                            http.request(req)
                        }
                        json = JSON.parse(resp.body)
                        brain[url] = json
                        json
                    end
                end
            end
        end
    end
end
