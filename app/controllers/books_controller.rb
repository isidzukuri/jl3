class BooksController < ApplicationController
  def show


# $this->view->javascript = array(
#       'book',
#       'jquery.transit.min',
#       'settings_window',
#     );
#     $this->view->CSS = array(
#       'jquery-ui'
#     );

#     // $this->cache = $this->get_cache_instance();
#     $lists = array();
#     if($user_id = $this->get_user_id()){
#       // if(!$lists = $this->cache->load('user_lists_'.$user_id)){
#         $lists = $this->booklist->get_all_for_user($user_id);
#         // $this->cache->save($lists, 'user_lists_'.$user_id);
#       // }
#     }
#     $this->view->lists = $lists;

#     $book_data = $this->book->get_all_book_data($this->params['id']);
#     $this->view->book = $book_data;
#     $this->view->text = $book_data['text_block'];
#     $this->view->metadata = array(
#       'title' => '"'.$book_data['bookname'].'" '.str_replace('%auth_name%', $book_data['l_name'].' '.$book_data['f_name'], $book_data['meta_title']),
#       'keywords' => $book_data['bookname'].' '.$book_data['l_name'].' '.$book_data['f_name'].' '.$book_data['meta_keywords'],
#       'description' => '"'.$book_data['bookname'].'" - '.$book_data['l_name'].' '.$book_data['f_name'].' '.$book_data['meta_description']
#     );
#     $cookie_string = $this->book->generateCookie($book_data['id']);
#     if(!$cookie_string){
#       $this->view->page_error = true;
#       $this->errortable->error($this->params['action'],'стрінга для кук не згенерована (!$cookie_string). BookController. book id ='.$this->params['id']);
#     }
#     $this->view->url = $this->request->getScheme() . '://' . $this->request->getHttpHost() . $this->request->getRequestUri();
#     $this->view->cookie_string = $cookie_string;

    # $this->view->metadata = array(
    #   'title' => '"'.$book_data['bookname'].'" '.str_replace('%auth_name%', $book_data['l_name'].' '.$book_data['f_name'], $book_data['meta_title']),
    #   'keywords' => $book_data['bookname'].' '.$book_data['l_name'].' '.$book_data['f_name'].' '.$book_data['meta_keywords'],
    #   'description' => '"'.$book_data['bookname'].'" - '.$book_data['l_name'].' '.$book_data['f_name'].' '.$book_data['meta_description']
    # );

    @book = Books::Services::FullDataset.new.call(params[:id])

    raise ActiveRecord::RecordNotFound unless @book

    @text = @book[:text_block]
    @rating = @book[:rating]&.floor(1)
    @rating_class = "voted_stars_#{@book[:rating]&.floor}"

ap @book
    full_name = "#{@book[:l_name]} #{@book[:f_name]}"
    @meta_title = "#{@book[:bookname]} #{@book[:meta_title].gsub('%auth_name%', full_name)}"
    @meta_keywords = "#{@book[:bookname]} #{full_name} #{@book[:meta_keywords]}"
    @meta_description = "#{@book[:bookname]} - #{full_name} #{@book[:meta_description]}"
  end

  def latest
    @books = Books::Queries::ListWithAuthors.new
                                            .call
                                            .limit(150)
                                            .reorder('id DESC')

    @text = TextBlock.where(type: 'latest_incomes')
                     .select(:text)
                     .first
                     &.text

    meta_data = MetaData.where(type: 'latest_incomes')
                        .select(:title, :keywords, :description)
                        .first

    @meta_title = meta_data[:title]
    @meta_keywords = meta_data[:keywords]
    @meta_description = meta_data[:description]
  end

  private
end
