class Crawler
  URL = 'http://www.indeed.com'

  def crawl()
    perform_search
    visit_jobs
  end

  private

  def perform_search
    # TODO: use query string below rather than clicking
    # "http://www.indeed.com/jobs?q=Software+Engineer&l=Seattle%252C+WA"
    session.visit URL
    session.fill_in 'what', :with => job_title
    session.fill_in 'where', :with => location
    session.click_button 'Find Jobs'
    wait
  end

  def visit_jobs
    job_links = session.all(:xpath,'//h2[@class="jobtitle"]/a').map {|link| link['href']}
    texts = job_links.map do |href|
      session.visit "#{URL}#{href}"
      wait
      page = Nokogiri::HTML(session.html)
      page.search('//script').remove
      page.search('//style').remove
      page.inner_text.squish
    end
  end

  def session
    @session ||= Capybara::Session.new(:poltergeist)
  end

  def job_title
    'Software Engineer'
  end

  def location
    'Seattle, WA'
  end

  def wait
    # TODO: temporarily turn off stdout
    session.find(:xpath, '//abc') rescue nil
  end
end
