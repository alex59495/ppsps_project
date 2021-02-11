class Worker < ApplicationRecord
  belongs_to :company
  has_many :conductors
  has_many :selected_lifesavers
  has_many :project_informations, class_name: "ProjectInformation", foreign_key: 'responsible_id'
  has_many :project_informations, class_name: "ProjectInformation", foreign_key: 'site_manager_id'
  has_many :project_informations, class_name: "ProjectInformation", foreign_key: 'team_manager_id'
  validates :lifesaver, inclusion: { in: [true, false] }
  validates :conductor, inclusion: { in: [true, false] }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true
  validates :email, presence: true, email: true
  validates :phone, presence: true, phone: true
  validates :company, presence: true

  ROLE = ['Conducteur de travaux', 'Chef de chantier', "Chef d'équipe"]

  include PgSearch::Model
  pg_search_scope :search_worker,
                  against: %i[first_name last_name],
                  using: {
                    tsearch: { prefix: true } # <-- allow the fact to search various words incomplete
                  }

  def self.search(query)
    if query.present?
      search_worker(query)
    else
      # No query? Return all records by name.
      order("first_name ASC")
    end
  end
end
