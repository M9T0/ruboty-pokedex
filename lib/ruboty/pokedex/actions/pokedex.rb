require 'net/http'
require 'uri'
require 'json'

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

                    json = get(POKEDEX_API + "pokemon-species/#{keyword}/")
                    id = json['id']
                    name = json['names'].find do |x|
                        x['language']['name'] == "ja" ||
                        x['language']['name'] == "ja-Hrkt"
                    end
                    desc = json['flavor_text_entries'].select do |x|
                        x['language']['name'] == "ja" ||
                        x['language']['name'] == "ja-Hrkt"
                    end
                    res = "No.#{id} #{name['name']}\n"
                    desc.each do |item|
                        vers = get(item['version']['url'])
                        ver = vers['names'].find do |x|
                            x['language']['name'] == "ja" ||
                            x['language']['name'] == "ja-Hrkt"
                        end
                        res += "#{item['flavor_text']}\n～ポケットモンスター #{ver['name']} より～\n"
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
