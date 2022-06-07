class Knight
    @@MovingPattern = [
        [-1, -2], [1, 2], [-1, 2], [1, -2], [-2, -1], [2, 1], [-2, 1], [2, -1]
      ]
    attr_accessor :position
    def initialize(position=[0,0])
        @position = position
    end

    def possible_move(origin, result=[])
        @@MovingPattern.each do |move|
            x = origin[0] + move[0]
            y = origin[1] + move[1]
            result << [x, y] if x.between?(0, 7) && y.between?(0, 7)
        end
        result
    end
    
    def knight_graph(origin, distination, visited=[], graph={}, qu=[], prev=[])
        children = possible_move(origin)
        if origin == distination
            qu.clear
            visited << origin
            prev << origin
        elsif !visited.include?(origin)
            graph[origin] = children
            visited << origin
            children.each {|child| qu<<child}
        end
        
        until qu.empty?
            knight_graph(qu.shift, distination, visited, graph, qu)
        end
        graph
    end


    def shortest_path(origin, distination, path=[])
        not_found = true
       while not_found
           knight_graph(origin,distination).each do |parent, child|
                path << parent
                if child.include?(distination)
                    not_found = false
                    return path << distination
                else
                    child.each do |c|
                        if !knight_graph(origin,distination)[c].nil?
                            if knight_graph(origin,distination)[c].include?(distination)
                                path << c
                                not_found = false
                                return path << distination

                            else
                                puts "not found"
                                not_found = false
                            end
                        end
                    end
                end
            end

       end
    end

end