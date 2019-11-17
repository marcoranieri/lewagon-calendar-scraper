class CalendarScraper
  require 'open-uri'
  require 'mechanize'

  require 'pry'

  def initialize(bootcamp, name="Marco", credential_txt="secret.txt")
    @agent = Mechanize.new
    @name, @bootcamp = name, bootcamp

    @agent.get(build_calendar_url)

    kitt_calendar_page = @agent.get(submit_login_form(credentials(credential_txt)))

    @days = kitt_calendar_page.search(".calendar-day").first(10).map do |e|
      e.text.split("\n")
      .reject{|e| e.strip.empty? || ["Quiz", "Reboot"].include?(e.strip) }
      .map(&:strip)
      .push(e.to_s)
    end

# binding.pry

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

  def set_credential(credentials)
    form_page = @agent.page.link_with(text: "\n      as a teacher\n").click
    form_page.form.login    = credentials[0]
    form_page.form.password = credentials[1]
    form_page
  end

  def submit_login_form(credentials)
    github_auth_page = @agent.submit(set_credential(credentials).form)
    calendar_page = github_auth_page.link_with(text: 'click here').click
    calendar_page.link_with(href: build_href).click
  end

  def build_calendar_url
    "https://kitt.lewagon.com/camps/#{@bootcamp}/calendar"
  end

  def build_href
    "/camps/#{@bootcamp}/calendar"
  end

end

p CalendarScraper.new(319)
