require 'view_models/destination_page'

module Renderer
  class Destination
    attr_reader :view_model

    class << self
      def render(destination)
        return unless destination
        new(destination).render
      end

      private :new
    end

    def initialize(destination)
      @view_model = ViewModels::DestinationPage.new(destination)
    end

    def render
      "<div id='container'>
        #{header}
        <div id='wrapper'>
          <div id='sidebar'>
            <div class='block'>
              <h3>Navigation</h3>
              <div class='content'>
                <div class='inner'>
                  #{parent}
                </div>
              </div>
            </div>
          </div>

          <div id='main'>
            <div class='block'>
              <div class='secondary-navigation'>
                <ul>
                  #{navigation}
                </ul>
                <div class='clear'></div>
              </div>
              <div class='content'>
                <div class='inner'>
                  #{content}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>"
    end

    private

    def header
      "<div id='header'>
        <div id='logo'></div>
        <h1>Lonely Planet: #{view_model.title}</h1>
      </div>"
    end

    def parent
      return unless view_model.parents

      view_model.parents.map do |parent|
        "<a href='#{parent[:atlas_id]}.html'>
          #{parent[:title]}
        </a> > "
      end.join
    end

    def navigation
      return unless view_model.children

      view_model.children.map do |child|
        "<li><a href='#{child[:atlas_id]}.html'>#{child[:title]}</a><li>"
      end.join
    end

    def content
      view_model.content
    end
  end
end
