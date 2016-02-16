require 'rslt'

module StyleHelper
  def paragraph(style, &block)
    @builder.p(class: style) { child_content }
  end

  def div(class_name="", &block)
    @builder.div(class: class_name) { child_content }
  end

  def c_data
    return if element.text.strip.empty?
    add element.text
  end
end

class DestinationPageStyle < RSLT::Stylesheet
  def rules
    render('history')      { paragraph("history") }
    render('overview')     { paragraph("overview") }

    render('destination')  { div("destination") }
    render('destinations') { div("destination-list") }

    render('*')            { nil }

    helper StyleHelper do
      within 'destinations' do

        within 'history' do
          render('text()') { c_data }
        end

        within 'overview' do
          render('text()') { c_data }
        end

        render('text()') { add element.to_xml.upcase }
      end
    end
  end
end

io = File.open('destinations.xml')
p DestinationPageStyle.transform io
