class StreamingController < ApplicationController
  PREFIX = (("." * 1024) + "\n").freeze
  
  def index
    body = proc do |stream|
      # This gets the browser to start rendering interactively:
      stream.write(PREFIX)
      
      10.downto(1) do |i|
        stream.write "#{i} bottles of beer on the wall\n"
        sleep 1
        stream.write "#{i} bottles of beer\n"
        sleep 1
        stream.write "Take one down, pass it around\n"
        sleep 1
        stream.write "#{i - 1} bottles of beer on the wall\n"
        sleep 1
      end
    end

    # Works, puma, falcon, Rails 7.1
    self.response = Rack::Response[200, {"content-type" => "text/plain"}, body]
  end
end
