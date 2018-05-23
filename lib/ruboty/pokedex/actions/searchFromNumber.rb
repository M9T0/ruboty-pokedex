require 'net/http'
require 'json'
require 'uri'

require "searchBase"

module Ruboty
    module Pokedex
        module Actions
            class SearchFromNumber < Ruboty::Pokedex::Actions::SearchBase
                def call
                    keyword = message[:number]
                    search(keyword)
                end
            end
        end
    end
end
