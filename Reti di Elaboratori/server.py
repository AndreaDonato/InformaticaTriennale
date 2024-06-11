import http.server
import socketserver

class MyHttpRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        print ("MY SERVER: I got a GET request.")
        if self.path == '/':
            print ("MY SERVER: The GET request is for the root URL.")
            self.path = 'my_webpage.html'
        return http.server.SimpleHTTPRequestHandler.do_GET(self)

    def do_POST(self):
        print ("MY SERVER: I got a POST request.")
        if self.path == '/verify':
            print ("MY SERVER: The POST request is for the /verify URL.")
        
            content_length = int(self.headers['Content-Length'])
            post_data_bytes = self.rfile.read(content_length)
            print ("MY SERVER: The post data I received from the request has following data:\n", post_data_bytes)

            post_data_str = post_data_bytes.decode("UTF-8")
            list_of_post_data = post_data_str.split('&')
            
            post_data_dict = {}
            for item in list_of_post_data:
                variable, value = item.split('=')
                post_data_dict[variable] = value

            print ("MY SERVER: I have changed the post data to a dict and here it is:\n", post_data_dict)
    
            try:
                matricola = int(post_data_dict['age'])
            except:
                matricola = 0
            if matricola > 18:
                self.path = 'matricola_okay.html'
            else:
                self.path = 'matricola_not_okay.html'
		
        return http.server.SimpleHTTPRequestHandler.do_GET(self)
 

# Create an object of the above class
handler_object = MyHttpRequestHandler

PORT = 80
my_server = socketserver.TCPServer(("", PORT), handler_object)

# Start the server
my_server.serve_forever()