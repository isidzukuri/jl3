require 'spec_helper'

RSpec.describe BooksController do
  render_views

  describe '#latest' do
    let!(:book_1) { create :book }
    let!(:book_2) { create :book }
    let!(:text_block) { create(:text_block, type: :latest_incomes, related: 0) }
    let!(:meta_data) { create(:meta_data, type: :latest_incomes, related: 0) }

    subject! { get :latest }

    it do
      expect(response).to render_template(:latest)
      expect(response.status).to eq 200
    end

    it 'has books' do
      expect(response.body).to include(book_1[:bookname])
      expect(response.body).to include(book_path(book_1[:seo]))
      expect(response.body).to include(book_2[:bookname])
      expect(response.body).to include(book_path(book_2[:seo]))
    end

    it 'has meta tags' do
      expect(response.body).to include("<title>#{meta_data[:title]}</title>")
      expect(response.body).to include("<meta name=\"keywords\" content=\"#{meta_data[:keywords]}\" />")
      expect(response.body).to include("<meta name=\"description\" content=\"#{meta_data[:description]}\" />")
    end
    
    it 'has text' do
      expect(response.body).to include("<h2>#{meta_data[:title]}</h2>")
      expect(response.body).to include(text_block[:text])
    end
  end

  describe '#show' do
    let(:author) { create(:author) }
    let(:genre) { create(:genre) }
    let!(:book_support) { create(:book_support, book: book) }
    let!(:meta_data) { create(:meta_data, :book) }
    let!(:text_block) { create(:text_block, :book) }
    let!(:book) { create(:book, author: author, genre: genre, txtfile: 'some_file') }
    let!(:tag) { create(:book_tag, book: book).tag }
    let!(:book_rating_1) { create(:book_rating, book: book, rate: 5) }
    let!(:book_rating_2) { create(:book_rating, book: book, rate: 4) }

    let(:id) { book.id }

    subject! { get :show, params: { id: id } }

    it 'has content' do
      expect(response.body).to include(author_path(author[:seo]))
      expect(response.body).to include(author[:f_name])
      expect(response.body).to include(author[:l_name])
      expect(response.body).to include(book[:bookname])
      expect(response.body).to include("genre/#{genre.seo_name}/page/1")
      expect(response.body).to include(genre.name)
      expect(response.body).to include(book[:bookdescribe])
      expect(response.body).to include(book[:cover])
      expect(response.body).to include(text_block[:text])
      expect(response.body).to include(tag[:title])
      expect(response.body).to include(tag[:seo_url])
      expect(response.body).to include(book_support.shop_msg)
      expect(response.body).to include("<a href=\"/files/#{book[:txtfile]}.txt\" id=\"txt\">")
      expect(response.body).to include("<a href=\"/files/#{book[:txtfile]}.fb2\" id=\"fb2\">")
      expect(response.body).to include("<a href=\"/files/#{book[:txtfile]}.jar\" id=\"jar\">")
      expect(response.body).to include("<a href=\"/files/#{book[:txtfile]}.doc\" id=\"doc\">")
      expect(response.body).to include("<a href=\"/files/#{book[:txtfile]}.epub\" id=\"epub\">")
      expect(response.body).to include("<span id=\"show_reader\" data-txt=\"#{book[:txtfile]}\">[#{I18n.t(:whole_text)}]</span>")
      
      full_name = "#{author[:l_name]} #{author[:f_name]}"
      expect(response.body).to include("#{book[:bookname]} #{meta_data[:title].gsub('%auth_name%', full_name)}")
      expect(response.body).to include("#{book[:bookname]} #{full_name} #{meta_data[:keywords]}")
      expect(response.body).to include("#{book[:bookname]} - #{full_name} #{meta_data[:description]}")
      expect(response.body).to include("itemscope itemtype=\"http://schema.org/Book\"")
      expect(response.body).to include("itemprop=\"genre\"")
      expect(response.body).to include("itemprop=\"author\"")
      expect(response.body).to include("itemprop=\"description\"")
      expect(response.body).to include("itemprop=\"ratingValue\"")
      expect(response.body).to include("itemprop=\"aggregateRating\"")
      expect(response.body).to include("itemscope itemtype=\"http://schema.org/AggregateRating\"")
    end

    # reader
    # downloads




    context 'author links present' do
      # expect(subject[:author_link]).to eq(book_support.author_link)
      # "a:2:{s:4:\"urls\";a:1:{i:0;s:0:\"\";}s:6:\"ancors\";a:1:{i:0;s:0:\"\";}}" 
      #  "a:2:{s:4:\"urls\";a:2:{i:0;s:24:\"http://perevody.kiev.ua/\";i:1;s:78:\"http://prodvizhenie.net.ua/books/robert-shekli/r-shekli-ostannya-zbirka-demoni\";}s:6:\"ancors\";a:2:{i:0;s:60:\"Переклад з англійської Р.Ткачука\";i:1;s:29:\"оригінал тексту\";}}"
    end

    context 'book is forbidden' do
      let!(:book_support) { create(:book_support, book: book, censorship: 1) }

      it do
        expect(response.body).to include("<div id=\"censorship\">")
        expect(response.body).to include(I18n.t(:censorship))
        expect(response.body).to_not include("<a href=\"/files/#{book[:txtfile]}.txt\" id=\"txt\">")
        expect(response.body).to_not include("<a href=\"/files/#{book[:txtfile]}.fb2\" id=\"fb2\">")
        expect(response.body).to_not include("<a href=\"/files/#{book[:txtfile]}.jar\" id=\"jar\">")
        expect(response.body).to_not include("<a href=\"/files/#{book[:txtfile]}.doc\" id=\"doc\">")
        expect(response.body).to_not include("<a href=\"/files/#{book[:txtfile]}.epub\" id=\"epub\">")
        expect(response.body).to_not include("<span id=\"show_reader\" data-txt=\"#{book[:txtfile]}\">[#{I18n.t(:whole_text)}]</span>")
      end
    end

    context 'cant convert text to some format in the past' do
      let!(:book_support) do 
        create(:book_support, book: book, bad_txt: 1,
                                          bad_doc: 1,
                                          bad_fb2: 1,
                                          bad_jar: 1,
                                          bad_epub: 1)
      end

      it do
        expect(response.body).to_not include("<a href=\"/files/#{book[:txtfile]}.txt\" id=\"txt\">")
        expect(response.body).to_not include("<a href=\"/files/#{book[:txtfile]}.fb2\" id=\"fb2\">")
        expect(response.body).to_not include("<a href=\"/files/#{book[:txtfile]}.jar\" id=\"jar\">")
        expect(response.body).to_not include("<a href=\"/files/#{book[:txtfile]}.doc\" id=\"doc\">")
        expect(response.body).to_not include("<a href=\"/files/#{book[:txtfile]}.epub\" id=\"epub\">")
      end
    end
  end
end
