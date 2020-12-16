require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_roster = []
    html = Nokogiri::HTML(open(index_url))
    html.css(".student-card").collect do |student|
      hash ={
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: "https://learn-co-curriculum.github.io/student-scraper-test-page/index.html" + student.css("a").attribute("href")
    }
      student_roster << hash
    end
    student_roster
      
  end


    def self.scrape_profile_page(profile_url)
      stud_prof = {}
    html = open(profile_url)
    profile = Nokogiri::HTML(html)

    

    profile.css("div.main-wrapper.profile .social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        stud_prof[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        stud_prof[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        stud_prof[:github] = social.attribute("href").value
      else
        stud_prof[:blog] = social.attribute("href").value
      end
    end

    stud_prof[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
    stud_prof[:bio] = profile.css("div.main-wrapper.profile .description-holder p").text

    stud_prof
  end
    
end



