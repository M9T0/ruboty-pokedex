module Ruboty
    module Handlers
        class Pokedex < Base
            on(/\b(?<keyword>\w+)\b/, name: 'name', description: 'search from name')
            on(/\b(?<number>\d+\b)/, name: 'num', description: 'search from number')

            def name(msg)
                Ruboty::Actions::Pokedex.new(msg)
            end

            def num(msg)
                Ruboty::Actions::Pokedex.new(msg)
            end
        end
    end
end
