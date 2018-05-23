require 'net/http'
require 'uri'
require 'json'

require "searchBase"

module Ruboty
    module Pokedex
        module Actions
            class SearchFromName < Ruboty::Pokedex::Actions::SearchBase
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
