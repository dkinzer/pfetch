module Pfetch
  module StubResponse
    def stub_http_response_with(filename)
      format = filename.split(".").last.intern
      data = file_fixture(filename)

      response = Net::HTTPOK.new("1.1", 200, "Content for you")
      allow(response).to receive(:body).and_return(data)

      http_request = HTTParty::Request.new(Net::HTTP::Get, "http://localhost", format: format)
      allow(http_request).to receive_message_chain(:http, :request).and_return(response)

      expect(HTTParty::Request).to receive(:new).and_return(http_request)
    end

    def stub_chunked_http_response_with(chunks, options = {format: "html"})
      response = Net::HTTPResponse.new("1.1", 200, nil)
      allow(response).to receive(:chunked_data).and_return(chunks)
      def response.read_body(&block)
        @body || chunked_data.each(&block)
      end
      yield(response) if block_given?

      http_request = HTTParty::Request.new(Net::HTTP::Get, "http://localhost", options)
      allow(http_request).to receive_message_chain(:http, :request).and_yield(response).and_return(response)

      expect(HTTParty::Request).to receive(:new).and_return(http_request)
    end

    def stub_response(body, code = "200")
      code = code.to_s
      @request.options[:base_uri] ||= "http://localhost"
      unless defined?(@http) && @http
        @http = Net::HTTP.new("localhost", 80)
        allow(@request).to receive(:http).and_return(@http)
      end

      # CODE_TO_OBJ currently missing 308
      response = if code == "308"
        Net::HTTPRedirection.new("1.1", code, body)
      else
        Net::HTTPResponse::CODE_TO_OBJ[code].new("1.1", code, body)
      end
      allow(response).to receive(:body).and_return(body)

      allow(@http).to receive(:request).and_return(response)
      response
    end

    def stub_finding_aids_request(fixture: nil, data: nil)
      data ||= file_fixture("finding_aids/#{fixture}")

      stub_request(:get, "https://findingaids.library.upenn.edu/records/?f%5Bsource%5D%5B0%5D=upenn&format=json&q=food&search_field=all&utf8=%E2%9C%93")
        .with(
          headers: {
            "Accept" => "*/*",
            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "User-Agent" => "Ruby"
          }
        )
        .to_return(status: 200, body: data.to_s, headers: {})
    end

    def stub_colenda_request(fixture: nil, data: nil)
      data ||= file_fixture("colenda/#{fixture}")

      stub_request(:get, "https://colenda.library.upenn.edu/?format=json&q=food&search_field=all&utf8=%E2%9C%93")
        .with(
          headers: {
            "Accept" => "*/*",
            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "User-Agent" => "Ruby"
          }
        )
        .to_return(status: 200, body: data.to_s, headers: {})
    end
  end
end
