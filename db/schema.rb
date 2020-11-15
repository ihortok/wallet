# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_15_132337) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_ownerships", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "user_id"
    t.boolean "super_owner", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_account_ownerships_on_account_id"
    t.index ["user_id"], name: "index_account_ownerships_on_user_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "note"
    t.integer "balance", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "currency_cd"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "country"
    t.string "code"
    t.string "symbol"
    t.string "icon"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "operations", force: :cascade do |t|
    t.integer "type_cd"
    t.bigint "debit_account_id"
    t.bigint "credit_account_id"
    t.integer "sum"
    t.integer "fee"
    t.string "note"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["credit_account_id"], name: "index_operations_on_credit_account_id"
    t.index ["debit_account_id"], name: "index_operations_on_debit_account_id"
    t.index ["user_id"], name: "index_operations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
