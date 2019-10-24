class Scraping
  def self.movie_urls
    links = []
    agent = Mechanize.new
    next_url = ""
    
    while  true 
      current_page = agent.get("http://review-movie.herokuapp.com/" + next_url)
      elements = current_page.search(".entry-title a")
      
      elements.each do |ele|
        links << ele.get_attribute("href")
      end
      
      next_link = current_page.at(".pagination .next a")
      break unless next_link
      next_url = next_link.get_attribute("href")
      
    end
    
    links.each do |link|
      get_product("http://review-movie.herokuapp.com/#{link}")
    end
    
  end

  def self.get_product(link)
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at(".post h2").inner_text
    
    image_url = page.at(".entry-content img").get_attribute("src") if page.at(".entry-content img")
    director = page.at(".entry-content .director span").inner_text if page.at(".entry-content .director span")
    detail = page.at(".entry-content p").inner_text if page.at(".entry-content p")
    open_data = page.at(".review_details .date span").inner_text if page.at(".review_details .date span")
    # open_data = page.at('.date span').inner_text if page.at('.date span')

  

    product = Product.where(title: title).first_or_initialize
    product.image_url = image_url
    product.director = director
    product.detail = detail
    product.open_data = open_data
    product.save
  end
  
  # def self.delete_data
  #   products = Product.where("id >= 338")
  #   products.each do |product|
  #     product.destroy
  #   end
  # end
  
end


