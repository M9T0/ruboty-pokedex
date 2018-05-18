require "ruboty/pokedex/actions/pokedex"

module Ruboty
    module Handlers
        class Pokedex < Base
            on(/pokedex\s+(?<number>\d+).*/, name: 'num', description: 'search from number', all: true)
            on(/pokedex\s+(?<name>\p{katakana}+).*/, name: 'name', description: 'search from name', all: true)

            def num(msg)
                Ruboty::Pokedex::Actions::Pokedex.new(msg).call
            end

            def name(msg)
                Ruboty::Pokedex::Actions::Pokedex.new(msg).call
            end
        end
    end
end
