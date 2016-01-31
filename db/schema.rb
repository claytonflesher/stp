# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160131160602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "custom_messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string   "topic"
    t.text     "body"
    t.integer  "received_messageable_id"
    t.string   "received_messageable_type"
    t.integer  "sent_messageable_id"
    t.string   "sent_messageable_type"
    t.boolean  "opened",                     default: false
    t.boolean  "recipient_delete",           default: false
    t.boolean  "sender_delete",              default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.boolean  "recipient_permanent_delete", default: false
    t.boolean  "sender_permanent_delete",    default: false
  end

  add_index "messages", ["ancestry"], name: "index_messages_on_ancestry", using: :btree
  add_index "messages", ["sent_messageable_id", "received_messageable_id"], name: "acts_as_messageable_ids", using: :btree

  create_table "patient_messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patient_therapist_relationships", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "therapist_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "status"
  end

  add_index "patient_therapist_relationships", ["patient_id"], name: "index_patient_therapist_relationships_on_patient_id", using: :btree
  add_index "patient_therapist_relationships", ["therapist_id"], name: "index_patient_therapist_relationships_on_therapist_id", using: :btree

  create_table "patients", force: :cascade do |t|
    t.string   "username",             null: false
    t.string   "password_digest",      null: false
    t.string   "name"
    t.string   "phone"
    t.string   "email",                null: false
    t.string   "zipcode",              null: false
    t.string   "gender"
    t.string   "former_religion",      null: false
    t.string   "description",          null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "verified_at"
    t.string   "verification_token"
    t.string   "password_reset_token"
  end

  create_table "therapists", force: :cascade do |t|
    t.string   "username",                                null: false
    t.string   "password_digest",                         null: false
    t.string   "first_name",                              null: false
    t.string   "last_name",                               null: false
    t.string   "phone",                                   null: false
    t.string   "email",                                   null: false
    t.string   "address",                                 null: false
    t.string   "city",                                    null: false
    t.string   "state",                                   null: false
    t.string   "country",                                 null: false
    t.string   "zipcode",                                 null: false
    t.string   "practice",                                null: false
    t.integer  "years_experience",                        null: false
    t.string   "qualifications",                          null: false
    t.string   "website"
    t.string   "gender",                                  null: false
    t.string   "religion",                                null: false
    t.string   "former_religion"
    t.string   "licenses",                                null: false
    t.string   "main_license",                            null: false
    t.boolean  "distance_counseling",                     null: false
    t.string   "languages"
    t.string   "purpose",                                 null: false
    t.string   "description"
    t.string   "approach"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "geo_address"
    t.datetime "verified_at"
    t.string   "verification_token"
    t.string   "password_reset_token"
    t.boolean  "admin",                   default: false
    t.boolean  "super_admin",             default: false
    t.boolean  "adolescents"
    t.boolean  "adults"
    t.boolean  "children"
    t.boolean  "coping_with_change"
    t.boolean  "depression"
    t.boolean  "existential"
    t.boolean  "general_anxiety"
    t.boolean  "grief_loss"
    t.boolean  "marriage_family"
    t.boolean  "mood_disorders"
    t.boolean  "ocd"
    t.boolean  "ptsd"
    t.boolean  "relationship_counseling"
    t.boolean  "self_improvement"
    t.boolean  "sex_therapy"
    t.boolean  "social_anxiety"
    t.boolean  "stress_management"
    t.boolean  "substance_abuse"
    t.boolean  "trauma_recovery"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "voter_id"
    t.integer  "votee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "decision"
    t.string   "comment"
  end

  add_index "votes", ["votee_id"], name: "index_votes_on_votee_id", using: :btree
  add_index "votes", ["voter_id", "votee_id"], name: "index_votes_on_voter_id_and_votee_id", unique: true, using: :btree
  add_index "votes", ["voter_id"], name: "index_votes_on_voter_id", using: :btree

  add_foreign_key "patient_therapist_relationships", "patients"
  add_foreign_key "patient_therapist_relationships", "therapists"
end
