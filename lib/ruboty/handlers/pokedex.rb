module Ruboty
    module Handlers
        class Pokedex < Base
            on(/pokedex\b+(?<number>\d+?)\b*/, name: 'num', description: 'search from number')

            def num(msg)
                Ruboty::Actions::Pokedex.new(msg).call
            end
        end
    end
end
