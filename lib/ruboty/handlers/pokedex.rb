module Ruboty
    module Handlers
        class Pokedex < Base
            on(/(?<keyword>\w+)/, name: 'name', description: 'search from name')
            on(/(?<number>\d+)/, name: 'num', description: 'search from number')

            def name(msg)
                msg.reply('name')
            end

            def num(msg)
                msg.reply('num')
            end
        end
    end
end
