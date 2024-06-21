$stdout.sync = true

class RateLimiter
    CAPACITY = 5
    TIME_WINDOW = 3

    def initialize
        @queue = []
        @mutex = Mutex.new
        @convar = ConditionVariable.new
    end

    def enqueue(request)
        @mutex.synchronize do
            while @queue.count >= CAPACITY
                @convar.wait(@mutex)
            end

            request.set_time_to_now
            @queue.unshift(request)
        end
    end

    def dequeue
        loop do
            if @queue.count > 0 && @queue.last.get_time + TIME_WINDOW < Time.now.to_i
                @mutex.synchronize do
                    puts "Removing request #{@queue.last}, because #{@queue.last.get_time} < #{Time.now.to_i}"
                    @queue.pop
                    @convar.signal
                end
            end
        end
    end
end

class Request
    @@id = 0

    def initialize
        @id = @@id
        @@id += 1
    end

    def set_time_to_now
        @time = Time.now.to_i
    end

    def get_time
        @time
    end

    def to_s
        @id.to_s
    end
end

if __FILE__ == $0
    rateLimiter = RateLimiter.new
    requests = []

    producer = Thread.new do
        puts "Producing requests..."

        100.times do
            requests << Request.new
        end

        puts "Finish requests production: #{requests.count} requests"
        puts "Enqueing requests..."

        requests.each do |r|
            rateLimiter.enqueue(r)
            puts "Enqueued request #{r}"
            sleep(rand(3))
        end
    end

    consumer = Thread.new do
        rateLimiter.dequeue
    end

    producer.join
    consumer.kill
end