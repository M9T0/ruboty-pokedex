require "ruboty/pokedex/actions/pokedex"

module Ruboty
    module Handlers
        class Pokedex < Base
            on(/pokedex\s+(?<number>\d+).*/, name: 'num', description: 'search from number')

            def num(msg)
                Ruboty::Actions::Pokedex.new(msg).call
            end
        end
    end
end
