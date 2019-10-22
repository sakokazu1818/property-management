ID = '127105969500'
PASSWORD = 'caa70210'

@wait_time = 60
@timeout = 60

Selenium::WebDriver.logger.output = File.join("./", "selenium.log")
Selenium::WebDriver.logger.level = :warn

options = Selenium::WebDriver::Chrome::Options.new

# NOTE HEAD LESS
options.add_argument('--headless')

client = Selenium::WebDriver::Remote::Http::Default.new
client.read_timeout = @timeout

@driver = Selenium::WebDriver.for :chrome, options: options, http_client: client
@driver.manage.timeouts.implicit_wait = @timeout

namespace :fetch_property do
  desc "物件情報の取得"
  task :ran do
    login
    go_to_nippou
    go_to_nippou_list
    export_excel(fetch_search_result_list)
  rescue => e
    export_excel([e])
  end

  def login
    @driver.get('http://www.member.kinkireins.or.jp/IP_system/login/')
    @driver.find_element(:id, 'button_IP_system_login').click

    new_window = @driver.window_handles.last
    @driver.switch_to.window(new_window)

    search_box = @driver.find_elements(:class, 'fontTextInput')
    search_box[0].send_keys ID
    search_box[1].send_keys PASSWORD

    @driver.find_element(:class, 'fontButton').click
  end

  def go_to_nippou
    new_window = @driver.window_handles.last
    @driver.switch_to.window(new_window)
    @driver.find_element(:xpath, '/html/body/div[2]/form/table/tbody/tr[1]/td[3]/table/tbody/tr/td/table/tbody/tr[3]/td/a[1]').click
  end

  def go_to_nippou_list
    @driver.find_element(:xpath, '/html/body/div[2]/form/table[1]/tbody/tr/td[2]/input[1]').click
    @driver.find_element(:id, 'ikkatuButton').click
  end

  def fetch_search_result_list
    search_result_list = []
    loop do
      tr = @driver.find_elements(:id, 'SearchResultList').map{ |s| s.find_elements(:tag_name, 'td')}
      tr.flatten!

      search_result_list << tr.map do |t|
        t.text
      end

      begin
        @driver.find_element(:link_text, '次へ').click()
      rescue => e
        break
      end
    end

    @driver.quit
    search_result_list.flatten!
    search_result_list
  end

  def export_excel(list)
    File.open("#{Rails.root}/public/files/text.txt", 'w') do |file|
      list.each do |l|
        file.puts l
      end
    end

    p 'end!!!!'
  end
end
