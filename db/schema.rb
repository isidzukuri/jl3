# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_22_074733) do

  create_table "author_add", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "f_name", limit: 80, default: "", null: false
    t.string "l_name", limit: 80, default: " ", null: false
    t.text "bio", null: false
    t.string "portrait", default: "0", null: false
    t.integer "added_by", default: 0, null: false
  end

  create_table "authors", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "f_name", limit: 80, default: "", null: false
    t.string "l_name", limit: 80, default: "", null: false
    t.string "full_name", limit: 100, null: false
    t.text "bio", null: false
    t.string "portrait", default: "0", null: false
    t.integer "show", default: 1, null: false
    t.string "seo", default: "", null: false
    t.index ["full_name"], name: "authors_full_name"
    t.index ["id"], name: "id"
    t.index ["l_name"], name: "authors_last_name"
    t.index ["seo"], name: "seo"
  end

  create_table "blog", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "title", null: false
    t.string "photo", null: false
    t.text "description", null: false
    t.text "text", null: false
    t.string "seo_url", null: false
    t.string "keywords", null: false
    t.text "meta_description", null: false
    t.string "img_alt", null: false
    t.string "img_title", null: false
    t.string "date", null: false
    t.boolean "published", default: false, null: false
    t.string "added_by", limit: 80, null: false
  end

  create_table "book", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "authorid", limit: 3, null: false
    t.string "bookname", limit: 80, null: false, collation: "utf8_general_ci"
    t.string "genre", limit: 20, null: false, collation: "utf8_general_ci"
    t.text "bookdescribe", null: false, collation: "utf8_general_ci"
    t.string "cover", default: "", null: false, collation: "utf8_general_ci"
    t.string "txtfile", limit: 100, null: false, collation: "utf8_general_ci"
    t.integer "txt_size_kb", limit: 2, default: 1, null: false
    t.string "seo", default: "", null: false
    t.index ["authorid"], name: "authorid"
    t.index ["bookname"], name: "book_bookname"
    t.index ["genre"], name: "genre"
    t.index ["seo"], name: "seo"
  end

  create_table "book_downloads", id: :integer, default: nil, charset: "utf8", force: :cascade do |t|
    t.integer "total", default: 0, null: false
    t.integer "txt", default: 0, null: false
    t.integer "fb2", default: 0, null: false
    t.integer "doc", default: 0, null: false
    t.integer "epub", default: 0, null: false
    t.integer "jar", default: 0, null: false
  end

  create_table "book_lists", id: :integer, charset: "utf8", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.string "description", limit: 500, default: "", null: false
    t.string "type", limit: 50, default: "", null: false
    t.index ["user_id"], name: "user_id"
  end

  create_table "book_ratings", id: :integer, charset: "utf8", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "user_id", null: false
    t.integer "rate", limit: 1, null: false
    t.index ["book_id"], name: "book_id"
  end

  create_table "book_support", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "txt", limit: 1, default: 1, null: false
    t.integer "jar", limit: 1, default: 0, null: false
    t.integer "fb2", limit: 1, default: 0, null: false
    t.integer "epub", limit: 1, default: 0, null: false
    t.integer "doc", limit: 1, default: 0, null: false
    t.integer "censorship", limit: 1, default: 0, null: false
    t.string "shop_url", default: "", null: false
    t.string "author_link", limit: 355, default: "", null: false
    t.string "shop_msg", default: "", null: false
    t.string "downloads", limit: 120, default: "0", null: false
    t.integer "bad_txt", limit: 1, default: 0, null: false
    t.integer "bad_jar", limit: 1, default: 0, null: false
    t.integer "bad_jad", limit: 1, default: 0, null: false
    t.integer "bad_fb2", limit: 1, default: 0, null: false
    t.integer "bad_epub", limit: 1, default: 0, null: false
    t.integer "bad_doc", limit: 1, default: 0, null: false
  end

  create_table "book_tags", id: :integer, charset: "utf8", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "tag_id", null: false
    t.integer "moderated", limit: 1, default: 0, null: false
    t.index ["book_id"], name: "book_id"
    t.index ["moderated"], name: "moderated"
    t.index ["tag_id"], name: "tag_id"
  end

  create_table "books_list", id: :integer, charset: "utf8", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "list_id", null: false
    t.index ["book_id", "list_id"], name: "book_id"
    t.index ["list_id"], name: "list_id"
  end

  create_table "books_paper_books", id: :integer, charset: "utf8", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "yakabook_id", null: false
    t.integer "yakabook_moderated", limit: 1, default: 0, null: false
    t.integer "yakaboo_deleted", limit: 1, default: 0, null: false
    t.index ["book_id", "yakabook_id"], name: "book_id"
  end

  create_table "citats", id: :integer, charset: "utf8", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "book_id", null: false
    t.text "text", null: false
    t.index ["book_id"], name: "book_id"
    t.index ["user_id", "book_id"], name: "user_id"
  end

  create_table "converter", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "bookname", null: false
    t.text "text", size: :long, null: false
    t.integer "genre", default: 0, null: false
    t.string "firstname", limit: 80, default: "", null: false
    t.string "lastname", limit: 80, default: "", null: false
    t.integer "date", null: false
    t.string "type", limit: 50, null: false
  end

  create_table "error_table", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "error", limit: 500, null: false
    t.string "type", limit: 80, null: false
    t.string "function", limit: 80, null: false
    t.integer "date", default: 0, null: false
  end

  create_table "front_page", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "last", default: "0", null: false
    t.string "recomended", limit: 225, default: "0", null: false
  end

  create_table "genre", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "seo_name", limit: 30, null: false
    t.integer "parent_id", limit: 2, default: 0, null: false
    t.index ["seo_name"], name: "seo_name"
  end

  create_table "letter", id: { type: :integer, limit: 2 }, charset: "utf8", force: :cascade do |t|
    t.string "symbol", limit: 11, null: false
    t.string "locale", limit: 11, null: false
    t.index ["id"], name: "id", unique: true
  end

  create_table "list", id: :integer, charset: "utf8", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "title", null: false
    t.integer "description", null: false
  end

  create_table "meta_data", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "title", null: false
    t.string "keywords", null: false
    t.string "description", null: false
    t.string "type", limit: 50, null: false
    t.integer "related", null: false
    t.string "admin_name", null: false
    t.index ["related"], name: "related"
    t.index ["type"], name: "type"
  end

  create_table "moderation", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "type", limit: 8, null: false
    t.integer "item_id", null: false
    t.integer "user_id", null: false
    t.integer "temporary_id", null: false
    t.string "status", limit: 10, default: "0", null: false
    t.index ["item_id"], name: "item_id"
    t.index ["temporary_id"], name: "temporary_id"
    t.index ["user_id"], name: "user_id"
  end

  create_table "page", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "seo_name", null: false
    t.string "name", null: false
    t.text "text", null: false
  end

  create_table "reading_books", id: { type: :integer, limit: 3 }, charset: "utf8", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "user_id", limit: 3, null: false
    t.integer "book_id", limit: 3, null: false
    t.text "data", null: false
    t.index ["book_id"], name: "book_id"
    t.index ["user_id"], name: "user_id"
  end

  create_table "statistic", id: :integer, charset: "utf8", force: :cascade do |t|
    t.text "data", null: false
    t.integer "date", null: false
    t.string "type", limit: 10, null: false
  end

  create_table "tags", id: :integer, charset: "utf8", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "title", null: false
    t.string "seo_url", default: "", null: false
    t.integer "visible", limit: 1, default: 0, null: false
    t.index ["id"], name: "id"
    t.index ["seo_url"], name: "seo_url"
  end

  create_table "text_blocks", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "title", null: false
    t.text "text", null: false
    t.string "type", limit: 50, null: false
    t.integer "related", default: 0, null: false
    t.index ["related"], name: "related"
    t.index ["type", "related"], name: "type_and_rel"
    t.index ["type"], name: "type"
  end

  create_table "users", id: :integer, charset: "utf8", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "username", null: false
    t.string "password", null: false
    t.string "email", null: false
    t.integer "last_login", null: false
  end

  create_table "users_books", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "bookname", default: "", null: false
    t.text "description", null: false
    t.string "full_name", null: false
    t.integer "genre", null: false
    t.text "text", size: :long, null: false
    t.string "cover", null: false
    t.integer "by_user", null: false
  end

  create_table "users_front", id: :integer, charset: "utf8", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "username", null: false
    t.string "password", null: false
    t.string "email", null: false
    t.integer "last_login", null: false
    t.integer "last_remind", default: 0, null: false
    t.integer "last_rate", default: 0, null: false
    t.index ["email"], name: "email"
  end

  create_table "users_front_storage", id: :integer, charset: "utf8", force: :cascade do |t|
    t.text "books_added", null: false
    t.text "bio_added", null: false
    t.text "books_reading", null: false
  end

  create_table "yakaboo_authors", id: :integer, charset: "utf8", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "f_name", limit: 80, default: "", null: false
    t.string "l_name", limit: 80, default: "", null: false
    t.string "full_name", limit: 100, null: false
    t.text "bio", null: false
    t.string "portrait", default: "0", null: false
    t.integer "show", default: 1, null: false
    t.string "seo_name", limit: 500, null: false
    t.index ["full_name"], name: "full_name"
    t.index ["id"], name: "id"
    t.index ["id"], name: "id_2"
    t.index ["seo_name"], name: "seo_name", length: 333
  end

  create_table "yakaboo_book", id: :integer, charset: "utf8", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "authorid", null: false
    t.string "bookname", limit: 80, null: false
    t.text "bookdescribe", null: false
    t.integer "price"
    t.string "isbn", limit: 100, null: false
    t.string "publisher", limit: 200, null: false
    t.string "shop_url", limit: 200, null: false
    t.string "seo_name", limit: 300, null: false
    t.string "img_url", null: false
    t.string "shop", limit: 50, default: "yakaboo", null: false
    t.integer "shop_id", null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.index ["authorid"], name: "authorid"
    t.index ["bookname"], name: "bookname"
    t.index ["seo_name"], name: "seo_name"
    t.index ["shop"], name: "shop"
    t.index ["shop_id"], name: "shop_id"
    t.index ["status"], name: "status"
  end

  create_table "yakaboo_book_yakaboo_genre", id: :integer, charset: "utf8", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "yakaboo_genre_id", null: false
    t.integer "yakaboo_book_id", null: false
    t.index ["yakaboo_book_id"], name: "yakaboo_book_id"
    t.index ["yakaboo_genre_id"], name: "yakaboo_genre_id"
  end

  create_table "yakaboo_genre", id: :integer, default: 0, charset: "utf8", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "name", null: false
    t.integer "parent_id", default: 0, null: false
    t.string "seo_name", limit: 120, null: false
    t.index ["seo_name"], name: "seo_name"
  end

end
