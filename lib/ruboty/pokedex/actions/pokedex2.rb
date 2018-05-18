require 'net/http'
require 'uri'
require 'json'

require "ruboty/pokedex/data"

module Ruboty
    module Pokedex
        module Actions
            class Pokedex2 < Ruboty::Pokedex::Actions::Pokedex
                def call
                    name = message[:name]
                    if !Ruboty::Pokedex::Data::NAME_MAP.has_key?(name)
                        return
                    end
                    keyword = Ruboty::Pokedex::Data::NAME_MAP[name]

                    search(keyword)
                end
            end
        end
    end
end
