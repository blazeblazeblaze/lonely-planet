module ViewModels
  class DestinationPage
    attr_reader :destination

    def initialize(destination)
      @destination = destination
    end

    def title
      destination[:title]
    end

    def content
      {
        history:  destination[:history],
        overview: destination[:overview]
      }
    end

    def atlas_id
      destination[:atlas_id]
    end

    def children
      destination.children.map do |child|
        nav_link(child)
      end
    end

    def parents
      navigation  = [nav_link(destination)]
      parent      = destination.parent

      while parent do
        navigation << nav_link(parent)
        parent = parent.parent
      end

      navigation.reverse
    end

    private

    def nav_link(item)
      {
        title:    item[:title],
        atlas_id: item[:atlas_id]
      }
    end
  end
end
