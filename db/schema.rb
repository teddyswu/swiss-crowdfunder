# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190625103137) do

  create_table "active_admin_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "campaign_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "campaign_id"
    t.integer "income"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_campaign_groups_on_campaign_id"
    t.index ["user_id"], name: "index_campaign_groups_on_user_id"
  end

  create_table "campaign_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "campaign_id"
    t.string "file"
    t.text "landing_page"
    t.text "campaign_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "campaign_qas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "campaign_id"
    t.text "campaign_question"
    t.text "campaign_answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_campaign_qas_on_campaign_id"
  end

  create_table "campaign_replies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "campaign_id"
    t.bigint "user_id"
    t.text "content"
    t.integer "parent_id"
    t.boolean "enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_campaign_replies_on_campaign_id"
    t.index ["user_id"], name: "index_campaign_replies_on_user_id"
  end

  create_table "campaign_tag_ships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "campaign_id"
    t.integer "campaign_tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "campaign_tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "campaign_updates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "campaign_id"
    t.text "campaign_title"
    t.text "campaign_content"
    t.integer "user_id"
    t.text "delayed_job_id"
    t.boolean "is_send"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_campaign_updates_on_campaign_id"
  end

  create_table "campaigns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "goal"
    t.date "start_date"
    t.date "end_date"
    t.string "title"
    t.string "youtube_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "risk"
    t.text "description"
    t.text "description_html"
    t.text "claim"
    t.string "twitter_url"
    t.text "order_description"
    t.text "order_description_html"
    t.string "slug"
    t.string "email"
    t.text "order_success"
    t.text "order_success_html"
    t.string "image"
    t.boolean "active", default: false
    t.bigint "user_id"
    t.integer "status"
    t.integer "result_status"
    t.boolean "is_rate"
    t.boolean "is_send"
    t.string "name"
    t.string "phone"
    t.text "self_introduction"
    t.index ["slug"], name: "index_campaigns_on_slug", unique: true
    t.index ["user_id"], name: "index_campaigns_on_user_id"
  end

  create_table "cities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.boolean "enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "districts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "zipcode"
    t.integer "city_id"
    t.boolean "enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favo_farmers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "farmer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, length: { slug: 70, scope: 70 }
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", length: { slug: 140 }
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "goodies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.text "description"
    t.integer "price"
    t.integer "quantity"
    t.bigint "campaign_id"
    t.integer "sort"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "delivery_time"
    t.index ["campaign_id"], name: "index_goodies_on_campaign_id"
  end

  create_table "goody_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "goody_id"
    t.string "file"
    t.text "cover"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "number"
    t.string "trade_no"
    t.string "payment_no"
    t.integer "quantity"
    t.integer "amount"
    t.integer "bonus"
    t.string "payment_type"
    t.boolean "paid"
    t.integer "user_id"
    t.text "remark"
    t.text "evaluation"
    t.bigint "goody_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "agreement"
    t.boolean "anonymous"
    t.string "rtn_code"
    t.string "bank_code"
    t.string "vAccount"
    t.string "expire_date"
    t.string "merchant_trade_no"
    t.string "trade_amt"
    t.string "trade_date"
    t.string "payment_date"
    t.string "ecpay_payment_type"
    t.integer "payment_type_charge_fee"
    t.index ["goody_id"], name: "index_orders_on_goody_id"
  end

  create_table "pay_order_numbers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "pay_order_number"
    t.string "original_order_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "send_refund_mails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "campaign_id"
    t.text "delayed_job_id"
    t.datetime "run_at"
    t.boolean "is_send"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supporters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "order_id"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.integer "city_id"
    t.integer "district_id"
    t.string "postal_code"
    t.string "country"
    t.string "tel"
    t.string "cell_phone"
    t.index ["order_id"], name: "index_supporters_on_order_id"
  end

  create_table "tracks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_tracks_on_campaign_id"
    t.index ["user_id"], name: "index_tracks_on_user_id"
  end

  create_table "user_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "nickname"
    t.string "first_name"
    t.string "last_name"
    t.integer "gender"
    t.datetime "birthday"
    t.integer "age_range"
    t.integer "city_id"
    t.integer "district_id"
    t.string "postal_code"
    t.string "country"
    t.text "address"
    t.string "tel"
    t.string "cell_phone"
    t.string "facebook_url"
    t.text "introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "nickname"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "campaign_groups", "campaigns"
  add_foreign_key "campaign_qas", "campaigns"
  add_foreign_key "campaign_replies", "campaigns"
  add_foreign_key "campaign_updates", "campaigns"
  add_foreign_key "supporters", "orders"
  add_foreign_key "tracks", "campaigns"
end
