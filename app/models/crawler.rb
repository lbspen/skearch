class Crawler
  URL = 'http://www.indeed.com'

  def crawl()
    job_texts = []
    (0...1).each do |i|
      perform_search(i)
      job_texts += visit_jobs
    end
    job_texts
  end

  private

  def perform_search(start_index)
    session.visit "#{URL}/jobs?q=#{job_title}&l=#{location}&start=#{start_index * 10}"
    wait
  end

  def visit_jobs
    job_links = session.all(:xpath,'//h2[@class="jobtitle"]/a').map {|link| link['href']}
    job_links.map do |href|
      begin
        session.visit "#{URL}#{href}"
        wait
        page = Nokogiri::HTML(session.html)
        page.search('//script').remove
        page.search('//style').remove
        page.inner_text.squish
      rescue
      end
    end
  end

  def session
    @session ||= Capybara::Session.new(:poltergeist)
  end

  def job_title
    'data+scientist'
  end

  def location
    'Seattle,+WA'
  end

  def wait
    # TODO: temporarily turn off stdout
    session.find(:xpath, '//abc') rescue nil
  end
end
