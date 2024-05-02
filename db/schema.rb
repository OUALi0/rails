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

ActiveRecord::Schema[7.0].define(version: 2024_04_27_213154) do
  create_table "adherents", force: :cascade do |t|
    t.string "nom"
    t.string "prenom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "auteurs", force: :cascade do |t|
    t.string "nom_prenom"
    t.integer "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "document_auteurs", force: :cascade do |t|
    t.integer "document_id"
    t.integer "auteur_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "doc_type"
    t.string "titre"
    t.integer "isbn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emprunt_documents", force: :cascade do |t|
    t.integer "emprtunt_id"
    t.integer "document_id"
  end

  create_table "emprunt_materiels", force: :cascade do |t|
    t.integer "emprtunt_id"
    t.integer "materiel_id"
  end

  create_table "emprunts", force: :cascade do |t|
    t.string "adherent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materiels", force: :cascade do |t|
    t.string "mat_type"
    t.string "nom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
