require "administrate/base_dashboard"

class SupervisorDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    username: Field::String,
    email: Field::String,
    password: Field::String,
    password_confirmation: Field::String,
    first_name: Field::String,
    last_name: Field::String,
    fiscal_code: Field::String,
    gender: Field::String,
    birth_date: Field::Date,
    birth_place: Field::String,
    region: Field::String,
    province: Field::String,
    institute: Field::String,
    office: Field::String,
    category: Field::String,
    boss: Field::Boolean,
    manager: Field::Boolean,
    regular: Field::Boolean,
    remember_created_at: Field::DateTime,
    failed_attempts: Field::Number,
    locked_at: Field::DateTime,
    unlock_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    reset_password_token: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    birth_date
    birth_place
    boss
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    username
    email
    password
    password_confirmation
    first_name
    last_name
    gender
    fiscal_code
    birth_date
    birth_place
    region
    province
    institute
    office
    category
    boss
    manager
    regular
    failed_attempts
    locked_at
    unlock_token
    reset_password_sent_at
    reset_password_token
    remember_created_at
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    username
    email
    password
    password_confirmation
    first_name
    last_name
    gender
    fiscal_code
    birth_date
    birth_place
    region
    province
    institute
    office
    category
    boss
    manager
    regular
    failed_attempts
    locked_at
    unlock_token
    reset_password_sent_at
    reset_password_token
    remember_created_at
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how supervisors are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(supervisor)
  #   "Supervisor ##{supervisor.id}"
  # end
end
