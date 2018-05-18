require 'net/http'
require 'uri'
require 'json'

require "ruboty/pokedex/data"

module Ruboty
    module Pokedex
        module Actions
            class Pokedex2 < Ruboty::Actions::Base
                NAMESPACE = 'POKEDEX'
                POKEDEX_API = 'https://pokeapi.co/api/v2/'

                def brain
                    message.robot.brain.data[NAMESPACE] ||= {}
                end

                def call
                    name = message[:name]
                    if !Ruboty::Pokedex::Data::NAME_MAP.has_key?(name)
                        return
                    end
                    keyword = Ruboty::Pokedex::Data::NAME_MAP[name]

                    json = get(POKEDEX_API + "pokemon-species/#{keyword}/")
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
