require 'csv'
class Gossip
    attr_accessor :author, :content

    def initialize(author, content)
        @author = author
        @content = content
    end    
    
    
    def save    
        CSV.open("./db/gossip.csv", "ab") do |csv|
            csv << [@author, @content]
        end
    end

    def self.all
        all_gossips = []
        CSV.read("./db/gossip.csv").each do |csv_line|
            all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return all_gossips
    end

    def self.find(id)
        CSV.open("./db/gossip.csv").each_with_index do |row, index|
            return gossip = Gossip.new(row[0], row[1]) if index == id.to_i
        end
    end 
    
    def self.update(id, author, content)

        row_array = CSV.read('db/gossip.csv')
        row_array.each.with_index(id.to_i) do |row, index|
            if id.to_i == index
                row_array[index] = [author, content]
            end    

        end
    end
end            