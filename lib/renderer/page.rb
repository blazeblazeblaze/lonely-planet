module Renderer
  class Page
    class << self
      def render
        "<!DOCTYPE html>
          <html>
            <head>
              <meta http-equiv='content-type' content='text/html; charset=UTF-8'>
              <title>Lonely Planet</title>
              <link href='static/all.css' media='screen' rel='stylesheet' type='text/css'>
            </head>
            <body>
              #{yield}
            </body>
          </html>"
      end

      private :new
    end
  end
end
