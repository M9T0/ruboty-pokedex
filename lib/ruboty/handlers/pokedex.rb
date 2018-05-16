module Ruboty
    module Handlers
        class Pokedex < Base
            on(/(?<keyword>\w+)/, name: 'name', description: 'search from name')
            on(/(?<number>\d+)/, name: 'num', description: 'search from number')

            def name(msg)
            end

            def num(msg)
            end
        end
    end
end
