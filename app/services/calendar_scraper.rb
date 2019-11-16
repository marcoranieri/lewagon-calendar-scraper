class CalendarScraper
  require 'open-uri'
  require 'nokogiri'
  require 'mechanize'

  require 'pry'

  def initialize(bootcamp, name="Marco", credential_txt="secret.txt")
    @agent = Mechanize.new
    @name, @bootcamp = name, bootcamp

    username, password = credentials(credential_txt)

    url = "https://kitt.lewagon.com/camps/#{@bootcamp}/calendar"

    @page = @agent.get(url)
    after_page = @agent.page.link_with(text: "\n      as a teacher\n").click
    after_page.form.login = username
    after_page.form.password = password

    auth_page = @agent.submit(after_page.form)
    new_page = auth_page.link_with(text: 'click here').click

    href = "/camps/#{@bootcamp}/calendar"
    calendar_page = new_page.link_with(href: href).click

    full_calendar_page = @agent.get(calendar_page)

    @days = full_calendar_page.search(".calendar-day").first(10).map do |e|
      e.text.split("\n")
      .reject{|e| e.strip.empty? || ["Quiz", "Reboot"].include?(e.strip) }
      .map(&:strip).push(e.to_s)
    end

    binding.pry
    # @html_doc = Nokogiri::HTML(open(url).read)

  end # // Initialize

  def searching
    query = ".work-day-box-link.work-day-box.work-day-assistant-box div.d-flex.align-items-baseline.justify-content-center"
    @html_doc.search(query).first(5).each do |element|
      puts element.text.strip
      # puts element.attribute('href').value
    end


  end



  private

  def credentials(credential_txt)
    File.open(File.join(Dir.pwd,credential_txt)).map(&:strip)
  end

end

CalendarScraper.new(319).search
# "as a teacher"
