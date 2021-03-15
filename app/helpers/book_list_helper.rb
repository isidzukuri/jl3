module BookListHelper
  def book_key(book)
    book[:seo] == '' ? book[:id] : book[:seo]
  end

  def author_key(book)
    book[:author_seo] == '' ? book[:authorid] : book[:author_seo]
  end

  def author_full_name(book)
    "#{book[:f_name]}  #{book[:l_name]}"
  end
end
