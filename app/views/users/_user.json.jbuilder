json.extract! user, :id, :username, :email, :password, :first_name, :last_name, :gender, :birth_date, :birth_place, :fiscal_code, :category, :region, :province, :institute, :office, :created_at, :updated_at
json.url user_url(user, format: :json)
