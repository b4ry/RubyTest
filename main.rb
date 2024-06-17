class Greeter
    attr_accessor :names

    def initialize(names = "World")
        @names = names
    end

    def sayHello
        if @names.nil?
            puts "..."
        elsif @names.respond_to?("each")
            @names.each do |name|
                puts "Hello, #{name}!"
            end
        else
            puts "Hello, #{names}!"
        end
    end

    def sayGoodBye
        if @names.nil?
            puts "..."
        elsif @names.respond_to?("join")
            puts "Bye, #{@names.join(", ")}!"
        else
            puts "Bye, #{@names}!"
        end
    end
end

if __FILE__ == $0
    g = Greeter.new("Luke")
    g.sayHello()
    g.sayGoodBye()

    g = Greeter.new("Luke, Julieta")
    g.sayHello()
    g.sayGoodBye()
end